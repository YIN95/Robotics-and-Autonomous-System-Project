#include "ros/ros.h"
#include <math.h>
#include <vector>
#include <std_msgs/Float32.h>
#include <sensor_msgs/Image.h>
#include <cv_bridge/cv_bridge.h>
#include <iostream>
#include <stdio.h>

class Calibration{
public:
    ros::NodeHandle nh;
    ros::Subscriber sub_image_rgb;
    ros::Subscriber sub_image_depth;

public:
    static const double fx = 619.7237548828125;
    static const double fy = 619.7237548828125;
    static const double fx_inv = 1/619.7237548828125;
    static const double fy_inv = 1/619.7237548828125;
    static const double cx = 304.5382995605469;
    static const double cy = 247.18377685546875;
    static const int image_height = 480;
    static const int image_width = 640;

public: 
    Calibration();
    void imageRGBCallback(const sensor_msgs::ImageConstPtr &msg);
    void imageDepthCallback(const sensor_msgs::ImageConstPtr &msg);
};