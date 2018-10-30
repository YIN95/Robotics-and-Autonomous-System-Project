#include <gp9_objects_detection/calibration_util.h>

int main(int argc, char* argv[])
{
    ros::init(argc, argv, "calibration_util");

    Calibration calibration;
    ros::Rate rate(10);

    while(calibration.nh.ok()){
        ros::spinOnce();
        calibration.calcCoord();
        rate.sleep();
    }

    return 0;
}

Calibration::Calibration(){
    rgb_info_sub = nh.subscribe<sensor_msgs::CameraInfo>("/camera/rgb/camera_info", 1, &Calibration::RGBInfoCallback, this);
	depth_info_sub = nh.subscribe<sensor_msgs::CameraInfo>("/camera/depth/camera_info", 1, &Calibration::depthInfoCallback, this);
    sub_image_rgb = nh.subscribe<sensor_msgs::Image>("/camera/rgb/image_rect_color", 1, &Calibration::imageRGBCallback, this);
	sub_image_depth = nh.subscribe<sensor_msgs::Image>("/camera/depth_registered/sw_registered/image_rect", 1, &Calibration::imageDepthCallback, this);
}

void Calibration::RGBInfoCallback(const sensor_msgs::CameraInfo::ConstPtr &msg){
    // P is row-major, so P is listed row by row
    f_x_rgb = msg->P[0]; 
    f_y_rgb = msg->P[5];
    c_x_rgb = msg->P[2];
    c_y_rgb = msg->P[6];
}
void Calibration::depthInfoCallback(const sensor_msgs::CameraInfo::ConstPtr &msg){
    // P is row-major, so P is listed row by row
    f_x_depth = msg->P[0];
    f_y_depth = msg->P[5];
    c_x_depth = msg->P[2];
    c_y_depth = msg->P[6];
}

void Calibration::imageRGBCallback(const sensor_msgs::ImageConstPtr &msg){

}
void Calibration::imageDepthCallback(const sensor_msgs::ImageConstPtr &msg){
    
}

void Calibration::calcCoord(){
    
}