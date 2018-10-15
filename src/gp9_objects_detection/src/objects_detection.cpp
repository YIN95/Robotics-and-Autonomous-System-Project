#include <gp9_objects_detection/objects_detection.h>
// roslaunch realsense_camera sr300_nodelet_rgbd.launch

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
    
    cascade_name = "/home/ras19/catkin_ws/src/gp9_objects_detection/src/cascade.xml";
    if(!cascade.load(cascade_name)){ 
        ROS_ERROR("Error loading cascade!"); 
    };
}

void ObjectDetection::imageRGBCallback(const sensor_msgs::ImageConstPtr &msg){
    try{
        cv_rgb_ptr = cv_bridge::toCvCopy(msg, sensor_msgs::image_encodings::BGR8);
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
    cv::imshow("DEPTH_WINDOW", cv_depth_ptr->image);
    cv::waitKey(3);  
}

void ObjectDetection::detectAndDisplay(cv_bridge::CvImagePtr ptr)
{
    try{
        bool only_detect_one = true;
        Mat frame = ptr->image;
        Mat frame_gray;
        cvtColor(frame, frame_gray, COLOR_BGR2GRAY);
        equalizeHist(frame_gray, frame_gray);
        //-- Detect objects
        cascade.detectMultiScale(frame_gray, objects, 1.1, 5, 0|CASCADE_SCALE_IMAGE, Size(80, 80));
        if (only_detect_one && objects.size()>0){
            int center_x = objects[0].x + objects[0].width/2;
            int center_y = objects[0].y + objects[0].height/2;
            Point center(center_x, center_y);
            // ellipse(frame, center, Size(objects[0].width/2, objects[0].height/2 ), 0, 0, 360, Scalar( 255, 0, 255 ), 4, 8, 0 );
            int color_result = colorFilter_is_object(frame, center_x, center_y);
            
            if (color_result > 0){
                ellipse(ptr->image, center, Size(4, 4), 0, 0, 360, Scalar( 255, 0, 255 ), 4, 8, 0 );
                Point pt1(objects[0].x, objects[0].y);
                Point pt2(objects[0].x + objects[0].width, objects[0].y + objects[0].height);
                object_depth = getDepth(center_x, center_y);
                ROS_INFO("DEPTH: %d", object_depth);
                rectangle(ptr->image, pt1, pt2, Scalar( 255, 0, 255 ), 4, 8, 0 );
                showResult(color_result);

                pose.x = 1.0 * object_depth / 1000;
                pose.y = pose.x / fx * (center_x - cx);
                pose.theta = 0;
                pub_object_pose.publish(pose);
                if (preDetectColor != color_result)
                    pubPose(pose.x, pose.y);
                preDetectColor = color_result;
            }
        }
        else{
            for (size_t i = 0; i < objects.size(); i++ ){
                Point center(objects[i].x + objects[i].width/2, objects[i].y + objects[i].height/2);
                ellipse(frame, center, Size(objects[i].width/2, objects[i].height/2 ), 0, 0, 360, Scalar( 255, 0, 255 ), 4, 8, 0 );
            }
        }
        imshow("RESULT", frame);
        char key = (char)waitKey(1);
    }
    catch(...){
        return;
    }
}

void ObjectDetection::removeBackground(Mat frame){
    Mat img_hsv;
    cvtColor(frame,img_hsv,CV_RGB2HSV);
    // OBJECTS_MIN = cv.Scalar(0, 40, 90)
    // OBJECTS_MAX = cv.Scalar(255, 255, 255)
}

void ObjectDetection::pubPose(double x, double y){
    visualization_msgs::Marker marker;
    marker.header.frame_id = "camera";
    marker.header.stamp = ros::Time();
    marker.ns = "my_namespace";
    marker.id = 0;
    marker.type = visualization_msgs::Marker::SPHERE;
    marker.action = visualization_msgs::Marker::ADD;
    marker.pose.position.x = x;
    marker.pose.position.y = y;
    marker.pose.position.z = 0;
    marker.pose.orientation.x = 0.0;
    marker.pose.orientation.y = 0.0;
    marker.pose.orientation.z = 0.0;
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
    pub_object_marker.publish(marker);
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
    
    if (40 < b && b < 80 && 70 < g && g < 120 && 0 < r && r < 10){
        ROS_INFO("COLOR_GREEN");
        return obj.COLOR_GREEN;
    }
    else if ((0 <= b && b < 20) && (70 < g && g < 180) && (160 < r && r < 255)){
        ROS_INFO("COLOR_YELLOW");
        return obj.COLOR_YELLOW;
    }
    else if ((5 <= b && b < 30) && 80 < g && g < 160 && 50 < r && r < 125){
        ROS_INFO("COLOR_LIGHT_GREEN");
        return obj.COLOR_LIGHT_GREEN;
    }
    else if (0 <= b && b < 10 && 30 < g && g < 70 && 150 < r && r < 210){
        ROS_INFO("COLOR_ORANGE");
        return obj.COLOR_ORANGE;
    }
    else if (0 <= b && b < 30 && 0 <= g && g < 40 && 125 < r && r < 160){
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

void ObjectDetection::showResult(int index){
    Point org(30, 50);
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
    Mat frame_depth = cv_depth_ptr->image;
    uchar* d = frame_depth.ptr<uchar>(y); 
    int depth = d[2*x] + 255*d[2*x+1];            
    return depth;
}