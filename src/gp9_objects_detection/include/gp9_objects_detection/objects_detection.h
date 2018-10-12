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
#include <gp9_objects_detection/detection_util.h>

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
    void detectAndDisplay(cv_bridge::CvImagePtr ptr);
    void colorFilter(Mat frame);
    void removeBackground(Mat frame);
    int colorFilter_is_object(Mat frame, int x, int y);
    int colorClassifier(int h, int s, int v, int b, int g, int r);
    void showresult(int txt);
    void showResult(int index);
    int getDepth(int x, int y);
public:
    static const int img_rgb_height = 480;
    static const int img_rgb_width = 640;
    int object_depth;
    cv_bridge::CvImagePtr cv_rgb_ptr;
    cv_bridge::CvImagePtr cv_depth_ptr;
    string cascade_name;
    CascadeClassifier cascade;
    std::vector<Rect> objects;
    ObjectColorShape obj;
};

