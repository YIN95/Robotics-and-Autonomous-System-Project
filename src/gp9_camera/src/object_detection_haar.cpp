#include <gp9_camera/object_detection_haar.h>

int main(int argc, char** argv) 
{	

        ros::init(argc, argv, "object_detection_haar");
	ObjectDetection objectDetection;
	ros::Rate rate(10);
	
	while (objectDetection.nh.ok()) {
		ros::spinOnce();
		rate.sleep();
		ROS_INFO("-=-=-=-=-=-=-=-=-=-=-=-=-=-=-");
	}
	return 0;
}

ObjectDetection::ObjectDetection(){
    img_rgb_height = 0;
    img_rgb_width = 0;
	sub_image_rgb = nh.subscribe<sensor_msgs::Image>("/camera/rgb/image_rect_color", 1, &ObjectDetection::imageRGBCallback, this);
	sub_image_depth = nh.subscribe<sensor_msgs::Image>("/camera/depth/image", 1, &ObjectDetection::imageDepthCallback, this);
    cascade_name = "/home/ras19/catkin_ws/src/gp9_camera/src/cascade.xml";
    if(!cascade.load(cascade_name)){ 
        ROS_INFO("Error loading cascade!"); 
    };
}

void ObjectDetection::imageRGBCallback(const sensor_msgs::ImageConstPtr &msg){
    try{
        cv_rgb_ptr = cv_bridge::toCvCopy(msg, sensor_msgs::image_encodings::BGR8);
    }
    catch (cv_bridge::Exception& e)
    {
        ROS_ERROR("cv_bridge exception: %s", e.what());
        return;
    }

    detectAndDisplay(cv_rgb_ptr->image);
    
    // cv::imshow("RGB_WINDOW", cv_rgb_ptr->image);
    // cv::waitKey(3);    
}

void ObjectDetection::imageDepthCallback(const sensor_msgs::ImageConstPtr &msg){
    try{
        cv_depth_ptr = cv_bridge::toCvCopy(msg);
        // , sensor_msgs::image_encodings::mono8
    }
    catch (cv_bridge::Exception& e)
    {
        ROS_ERROR("cv_bridge exception: %s", e.what());
        return;
    }
    
    // cv::imshow("DEPTH_WINDOW", cv_depth_ptr->image);
    // cv::waitKey(3);  
}

void ObjectDetection::detectAndDisplay(Mat frame)
{
    bool only_detect_one = true;
    Mat frame_gray;

    cvtColor(frame, frame_gray, COLOR_BGR2GRAY);
    equalizeHist(frame_gray, frame_gray);
    //-- Detect objects
    cascade.detectMultiScale(frame_gray, objects, 1.1, 5, 0|CASCADE_SCALE_IMAGE, Size(80, 80));

    if (only_detect_one){
        Point center(objects[0].x + objects[0].width/2, objects[0].y + objects[0].height/2);
        // ellipse(frame, center, Size(objects[0].width/2, objects[0].height/2 ), 0, 0, 360, Scalar( 255, 0, 255 ), 4, 8, 0 );
        ellipse(frame, center, Size(4, 4), 0, 0, 360, Scalar( 255, 0, 255 ), 4, 8, 0 );
        Point pt1(objects[0].x, objects[0].y);
        Point pt2(objects[0].x + objects[0].width, objects[0].y + objects[0].height);
        rectangle(frame, pt1, pt2, Scalar( 255, 0, 255 ), 4, 8, 0 );

        Mat objectROI = frame_gray( objects[0] );
    }
    else{
        for (size_t i = 0; i < objects.size(); i++ ){
            Point center(objects[i].x + objects[i].width/2, objects[i].y + objects[i].height/2);
            
            // recantagle()
            ellipse(frame, center, Size(objects[i].width/2, objects[i].height/2 ), 0, 0, 360, Scalar( 255, 0, 255 ), 4, 8, 0 );
            Mat objectROI = frame_gray( objects[i] );
        }
    }

    imshow("RESULT", frame);
    char key = (char)waitKey(1);
}

