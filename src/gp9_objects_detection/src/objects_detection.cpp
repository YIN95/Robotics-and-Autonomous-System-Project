#include <gp9_objects_detection/objects_detection.h>
// roslaunch realsense_camera sr300_nodelet_rgbd.launch
// the following one is better
// roslaunch ras_camera ras_camera_nodelet.launch

int main(int argc, char** argv) 
{	

	ros::init(argc, argv, "object_detection");
	ObjectDetection objectDetection;
	ros::Rate rate(10);
	
	while (objectDetection.nh.ok()) {
		ros::spinOnce();
		rate.sleep();
	}
	return 0;
}

ObjectDetection::ObjectDetection(){
    object_depth = 99999;
    preDetectColor = 0;
	sub_image_rgb = nh.subscribe<sensor_msgs::Image>("/camera/rgb/image_rect_color", 1, &ObjectDetection::imageRGBCallback, this);
	// sub_image_depth = nh.subscribe<sensor_msgs::Image>("/camera/depth_registered/sw_registered/image_rect", 1, &ObjectDetection::imageDepthCallback, this);
   	sub_image_depth = nh.subscribe<sensor_msgs::Image>("/camera/depth/image_raw", 1, &ObjectDetection::imageDepthCallback, this);
    pub_object_pose = nh.advertise<geometry_msgs::Pose2D>("/object/pose", 1);
    pub_object_marker = nh.advertise<visualization_msgs::Marker>("/object/marker", 1);
    pub_object_marker_array = nh.advertise<visualization_msgs::MarkerArray>("/object/marker_array", 10);
    pose_pub = nh.advertise<geometry_msgs::Pose2D>("/global_pose/object", 1);

    char *buffer;
    buffer = getcwd(NULL, 0);
    string path = buffer;
    string filePath = "/gp9_objects_detection/src/cascade.xml";
    string fullPath = path + filePath;
    
    fullPath = "/home/ras19/catkin_ws/src/gp9_objects_detection/src/cascade2.xml";
    cascade_name = fullPath;
    //cascade.mode = ;
    if(!cascade.load(cascade_name)){ 
        ROS_ERROR("Error loading cascade!"); 
    };
}

void ObjectDetection::imageRGBCallback(const sensor_msgs::ImageConstPtr &msg){
    try{
        cv_rgb_ptr = cv_bridge::toCvCopy(msg, sensor_msgs::image_encodings::BGR8);
        origin_frame = (cv_rgb_ptr->image).clone();
        detectAndDisplay(cv_rgb_ptr);
    }
    catch (...){
        return;
    }
    // cv::imshow("RGB_WINDOW", cv_rgb_ptr->image);
    // cv::waitKey(3);    
}

void ObjectDetection::imageDepthCallback(const sensor_msgs::ImageConstPtr &msg){
    try{
        cv_depth_ptr = cv_bridge::toCvCopy(msg);
        // , sensor_msgs::image_encodings::mono8
    }
    catch (...){
        return;
    }
    // cv::imshow("DEPTH_WINDOW", cv_depth_ptr->image);
    // cv::waitKey(3);  
}

void ObjectDetection::detectAndDisplay(cv_bridge::CvImagePtr ptr)
{
    try{
        bool only_detect_one = true;
        int detect_size = 1;
        Mat frame = ptr->image;
        Mat frame_gray;
        Mat frame_target;
        cvtColor(frame, frame_gray, COLOR_BGR2GRAY);
        equalizeHist(frame_gray, frame_gray);
        //-- Detect objects
        cascade.detectMultiScale(frame_gray, objects, 1.1, 5, 0|CASCADE_SCALE_IMAGE, Size(50, 50), Size(140, 140));
        detect_size = std::min(int(objects.size()), detect_size);
        if (only_detect_one && objects.size()>0){
            int i;
            for (i=0; i<detect_size; i++){
                int center_x = objects[i].x + objects[i].width/2;
                int center_y = objects[i].y + objects[i].height/2;
                Point center(center_x, center_y);
                // ellipse(frame, center, Size(objects[0].width/2, objects[0].height/2 ), 0, 0, 360, Scalar( 255, 0, 255 ), 4, 8, 0 );
                int color_result = colorFilter_is_object(frame, center_x, center_y);
                object_depth = getDepth(center_x, center_y);
                object_depth = getTrueDepth(object_depth);
                ROS_INFO("DEPTH: %d", object_depth);
                if (color_result > 0 && object_depth >= 0){
                    ellipse(ptr->image, center, Size(4, 4), 0, 0, 360, Scalar( 255, 0, 255 ), 4, 8, 0 );
                    Point pt1(objects[i].x, objects[i].y);
                    Point pt2(objects[i].x + objects[i].width, objects[i].y + objects[i].height);
                    
                    
                    rectangle(ptr->image, pt1, pt2, Scalar( 255, 0, 255 ), 4, 8, 0 );
                    showResult(color_result, i+1);

                    pose.x = 1.0 * object_depth / 1000;
                    pose.y = -1.0 * pose.x / fx * (center_x - cx);
                    pose.theta = 0;
                    pub_object_pose.publish(pose);

                    frame_target = cropTarget(center_x, center_y);
                    imshow("target", frame_target);
                    char keyt = (char)waitKey(1);

                    // if (preDetectColor != color_result){
                    if (check_pre_object(color_result)&& object_depth >= 50 && object_depth <=650){
                        //frame_target = cropTarget(pose.x, pose.y);
                        listen_obj_map(pose.x, pose.y, color_result);
                        preDetectColor = color_result;
                    }

                    
                }
            }

        }
        else{
            for (size_t i = 0; i < objects.size(); i++ ){
                Point center(objects[i].x + objects[i].width/2, objects[i].y + objects[i].height/2);
                ellipse(frame, center, Size(objects[i].width/2, objects[i].height/2 ), 0, 0, 360, Scalar( 255, 0, 255 ), 4, 8, 0 );
            }
        }
        imshow("RESULT", frame);
        char keyr = (char)waitKey(1);
       
    }
    catch(...){
        return;
    }
}

void ObjectDetection::listen_obj_map(double x, double y, int type){
    geometry_msgs::PointStamped obj_tf_camera;
    obj_tf_camera.header.frame_id = "camera";
    obj_tf_camera.header.stamp = ros::Time();
    obj_tf_camera.point.x = x;
    obj_tf_camera.point.y = y;
    obj_tf_camera.point.z = 0.0;
    try{
        geometry_msgs::PointStamped obj_tf_map;
        listener.transformPoint("map", obj_tf_camera, obj_tf_map);

        ROS_INFO("camera: (%.2f, %.2f. %.2f) -----> map: (%.2f, %.2f, %.2f) at time %.2f",
            obj_tf_camera.point.x, obj_tf_camera.point.y, obj_tf_camera.point.z,
            obj_tf_map.point.x, obj_tf_map.point.y, obj_tf_map.point.z, obj_tf_map.header.stamp.toSec());
        geometry_msgs::Pose2D pose_;
        pose_.x = obj_tf_map.point.x;
        pose_.y = obj_tf_map.point.y;
        pose_pub.publish(pose_);
        pubPose(pose_.x, pose_.y, type);
    }
    catch(tf::TransformException& ex){
        ROS_ERROR("Received an exception trying to transform a point");
    }

    
}

void ObjectDetection::removeBackground(Mat frame){
    Mat img_hsv;
    cvtColor(frame,img_hsv,CV_RGB2HSV);
    // OBJECTS_MIN = cv.Scalar(0, 40, 90)
    // OBJECTS_MAX = cv.Scalar(255, 255, 255)
}

void ObjectDetection::pubPose(double x, double y, int type){
    int id;
    id = marker_array.markers.size();
    marker.header.frame_id = "map";
    marker.header.stamp = ros::Time();
    marker.ns = "space";
    marker.id = id;
    marker.type = visualization_msgs::Marker::SPHERE;
    marker.action = visualization_msgs::Marker::ADD;
    marker.pose.position.x = x;
    marker.pose.position.y = y;
    marker.pose.position.z = 0;
    marker.pose.orientation.x = 0.0;
    marker.pose.orientation.y = 0.0;
    marker.pose.orientation.z = type;
    marker.pose.orientation.w = 1.0;
    marker.scale.x = 0.1;
    marker.scale.y = 0.1;
    marker.scale.z = 0.1;
    marker.color.a = 1.0; // Don't forget to set the alpha!
    marker.color.r = 0.0;
    marker.color.g = 1.0;
    marker.color.b = 0.0;
    // //only if using a MESH_RESOURCE marker type:
    // marker.mesh_resource = "package://pr2_description/meshes/base_v0/base.dae";
    // pub_object_marker.publish(marker);

    marker_array.markers.push_back(marker);
    pub_object_marker_array.publish(marker_array);
        
    // ROS_INFO("SIZE: %d", xx);
    // vis_pub.publish(marker);
}

int ObjectDetection::colorFilter_is_object(Mat frame, int x, int y){
     
    try{
        Mat img_hsv;
        cvtColor(frame, img_hsv, CV_RGB2HSV);
        uchar* d_ = frame.ptr<uchar>(y); 
        uchar* d = img_hsv.ptr<uchar>(y); 
        int h = d[3 * x];            
        int s = d[x * 3 + 1];            
        int v = d[x * 3 + 2];
        int b = d_[3 * x];    
        int g = d_[x * 3 + 1];            
        int r = d_[x * 3 + 2];  
        if (s < 40){
            ROS_INFO("-----------");
            ROS_INFO("center: (%d, %d)", x, y);
            ROS_INFO("BGR: (%d, %d, %d)", b, g, r);
            ROS_INFO("HSV: (%d, %d, %d)", h, s, v);
           
            return colorClassifier(h, s, v, b, g, r);
            return -1;
            
        }
        else{
            ROS_INFO("-----------");
            ROS_INFO("center: (%d, %d)", x, y);
            ROS_INFO("BGR: (%d, %d, %d)", b, g, r);
            ROS_INFO("HSV: (%d, %d, %d)", h, s, v);
           
            return colorClassifier(h, s, v, b, g, r);
        }
    }
    catch (...){
        ROS_ERROR("error on hsv");
    }
    return -1;  
}

int ObjectDetection::colorClassifier(int h, int s, int v, int b, int g, int r){
    bool use_rgb = false;
    if (use_rgb){
        if (10 < b && b < 70 && 50 < g && g < 120 && 0 < r && r < 40){
            ROS_INFO("COLOR_GREEN");
            return obj.COLOR_GREEN;
        }
        else if ((0 <= b && b < 20) && (70 < g && g < 180) && (143 < r && r < 255)){
            ROS_INFO("COLOR_YELLOW");
            return obj.COLOR_YELLOW;
        }
        else if ((5 <= b && b < 30) && 80 < g && g < 160 && 50 < r && r < 125){
            ROS_INFO("COLOR_LIGHT_GREEN");
            return obj.COLOR_LIGHT_GREEN;
        }
        else if (0 <= b && b < 10 && 30 < g && g < 70 && 150 < r && r < 220){
            ROS_INFO("COLOR_ORANGE");
            return obj.COLOR_ORANGE;
        }
        else if (0 <= b && b < 30 && 0 <= g && g < 40 && 125 < r && r < 185){
            ROS_INFO("COLOR_RED");
            return obj.COLOR_RED;
        }
        else if (80 <= b && b < 160 && 79 < g && g < 130 && 0 <= r && r < 30){
            ROS_INFO("COLOR_LIGHT_BLUE");
            return obj.COLOR_LIGHT_BLUE;
        }
        else if (30 <= b && b < 79 && 40 < g && g < 110 && 0 <= r && r < 30){
            ROS_INFO("COLOR_BLUE");
            return obj.COLOR_BLUE;
        }
        else if (50 <= b && b < 180 && 40 < g && g < 100 && 90 < r && r < 180){
            ROS_INFO("COLOR_PURPLE");
            return obj.COLOR_PURPLE;
        }
        return -1;
    }
    else{
        // return 1;
        if (s <95){
            return -1;
        }
        if (35 <= h && h <= 69 && 0 <= s && s <= 255 && 0 <= v && v <= 255){
            ROS_INFO("COLOR_GREEN");
            return obj.COLOR_GREEN;
        }
        else if ((90 <= h && h <= 107) && (0 <= s && s <= 255) && (0 <= v && v <= 255)){
            ROS_INFO("COLOR_YELLOW");
            return obj.COLOR_YELLOW;
        }
        else if ((70 <= h && h <= 89) && 0 <= s && s <= 255 && 0 <= v && v <= 255){
            ROS_INFO("COLOR_LIGHT_GREEN");
            return obj.COLOR_LIGHT_GREEN;
        }
        else if (108 <= h && h <= 117 && 0 <= s && s <= 255 && 0 <= v && v <= 255){
            ROS_INFO("COLOR_ORANGE");
            return obj.COLOR_ORANGE;
        }
        else if (0 <= h && h < 17 && 0 <= s && s <= 255 && 0 <= v && v <= 255){
            ROS_INFO("COLOR_RED");
            return obj.COLOR_RED;
        }
        else if (118 <= h && h <= 128 && 0 <= s && s <= 255 && 0 <= v && v <= 255){
            ROS_INFO("COLOR_RED");
            return obj.COLOR_RED;
        }
        else if (18 <= h && h <= 35 && 0 <= s && s <= 255 && 0 <= v && v <= 255){
            ROS_INFO("COLOR_LIGHT_BLUE");
            return obj.COLOR_LIGHT_BLUE;
        }
        else if (18 <= h && h <= 35 && 0 <= s && s <= 255 && 0 <= v && v <= 255){
            ROS_INFO("COLOR_BLUE");
            return obj.COLOR_BLUE;
        }
        else if (129 <= h && h < 170 && 0 <= s && s <= 255 && 0 <= v && v <= 255){
            ROS_INFO("COLOR_PURPLE");
            return obj.COLOR_PURPLE;
        }
        return -1;        
    }
    
}

void ObjectDetection::showResult(int index, int obi){
    Point org(30, obi*50);
    String text;
    switch(index) {
        case 1:
            text = "COLOR_YELLOW";
            break; 
        case 2:
            text = "COLOR_GREEN";
            break;
        case 3:
            text = "COLOR_LIGHT_GREEN";
            break; 
        case 4:
            text = "COLOR_ORANGE";
            break;
        case 5:
            text = "COLOR_RED";
            break; 
        case 6:
            text = "COLOR_BLUE";
            break;
        case 7:
            text = "COLOR_BLUE";
            break; 
        case 8:
            text = "COLOR_PURPLE";
            break;
        default : //Optional
            return;
    }
    putText(cv_rgb_ptr->image, text, org, 1, 2.5, Scalar( 255, 0, 255 ), 4, 8, 0);
    
    return;
}

int ObjectDetection::getDepth(int x, int y){
    int i, j, depth, temp;
    depth = 0;
    Mat frame_depth = cv_depth_ptr->image;
    for (i=x-10; i<x+10; i++){
        for (j=y-10; j<y+10; j++){
            uchar* d = frame_depth.ptr<uchar>(j);
            temp = d[2*i] + 255*d[2*i+1];
            depth = max(depth, temp);
        }
    }

    
    // uchar* d = frame_depth.ptr<uchar>(y); 
    // int depth = d[2*x] + 255*d[2*x+1];            
    return depth;
}

bool ObjectDetection::check_pre_object(int temp){
    int size = marker_array.markers.size();
    int index = 1;
    
    if (size == 0){
        return true;
    }

    while((index <= 3) && (size - index >= 0)){
        // ROS_INFO("!!!%d , %s", temp, arker_array.markers[size-index].ns);
        if (marker_array.markers[size-index].pose.orientation.z == temp){
            return false;
        }
        index++;
    }
    return true;
}

int ObjectDetection::getTrueDepth(int depth){
    double TD;
    int height = 180;
    TD = sqrt(depth*depth - height*height);
    TD = std::max(int(TD), 0);
    return int(TD);
}

Mat ObjectDetection::cropTarget(int x, int y){
    Mat frame_global = cv_rgb_ptr->image;
    Mat frame_target;
    int sx, sy;
    int cropsize = 128;
    sx = x-(cropsize/2);
    sy = y-(cropsize/2);
    
    if ((x-(cropsize/2))<0){
        sx = 0;
    }

    if ((y-(cropsize/2))<0){
        sy = 0;
    }

    if ((x+(cropsize/2))>640){
        sx = 640-cropsize;
    }

    if ((y+(cropsize/2))>480){
        sy = 480-cropsize;
    }
    ROS_INFO("x, %d ; y, %d", x, y);
    ROS_INFO("sx, %d ; sy, %d", sx, sy);
    Rect rect(sx, sy, cropsize, cropsize);
    frame_target = origin_frame(rect);
    //imshow("RESULT", frame_global);
    //char key = (char)waitKey(1);
    return frame_target;
}

void ObjectDetection::saveTrainingData(Mat target){
    
}

 