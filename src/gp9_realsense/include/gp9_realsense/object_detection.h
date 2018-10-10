#include "ros/ros.h"
#include <math.h>
#include <vector>
#include <std_msgs/Float32.h>
#include <sensor_msgs/Image.h>
#include <cv_bridge/cv_bridge.h>
#include <image_transport/image_transport.h>
#include <sensor_msgs/image_encodings.h>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/objdetect.hpp>
#include <opencv2/videoio.hpp>
#include <iostream>
#include <stdio.h>
using namespace cv;
using namespace std;
class ObjectDetection{

public: /* ros */
	ros::NodeHandle nh;
    ros::Subscriber sub_image_rgb;
    ros::Subscriber sub_image_depth;
public:
    ObjectDetection();
    void imageRGBCallback(const sensor_msgs::ImageConstPtr &msg);
    void imageDepthCallback(const sensor_msgs::ImageConstPtr &msg);
    void detectAndDisplay(Mat frame);
    void colorFilter(Mat frame);

public:
    int img_rgb_height;
    int img_rgb_width;
    cv_bridge::CvImagePtr cv_rgb_ptr;
    cv_bridge::CvImagePtr cv_depth_ptr;
    string cascade_name;
    CascadeClassifier cascade;
    std::vector<Rect> objects;
};



