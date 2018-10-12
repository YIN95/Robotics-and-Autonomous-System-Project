#include <gp9_objects_detection/calibration_util.h>

int main(int argc, char* argv[])
{
    ros::init(argc, argv, "calibration_util");

    Calibration calibration;

    while(calibration.nh.ok()){
        ros::spinOnce();
    }

    return 0;
}

Calibration::Calibration(){
    sub_image_rgb = nh.subscribe<sensor_msgs::Image>("/camera/rgb/image_rect_color", 1, &Calibration::imageRGBCallback, this);
	sub_image_depth = nh.subscribe<sensor_msgs::Image>("/camera/depth_registered/sw_registered/image_rect", 1, &Calibration::imageDepthCallback, this);
}

void Calibration::imageRGBCallback(const sensor_msgs::ImageConstPtr &msg){

}
void Calibration::imageDepthCallback(const sensor_msgs::ImageConstPtr &msg){
    
}