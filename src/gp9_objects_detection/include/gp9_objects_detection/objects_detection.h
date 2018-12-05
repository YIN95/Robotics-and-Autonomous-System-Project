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
#include <geometry_msgs/Pose2D.h>
#include <tf/transform_broadcaster.h>
#include <iostream>
#include <stdio.h>
#include <gp9_objects_detection/detection_util.h>
#include <visualization_msgs/Marker.h>
#include <visualization_msgs/MarkerArray.h>
#include <tf/transform_listener.h>
#include <geometry_msgs/PointStamped.h>
#include <string>
#include <std_msgs/Int32.h>
#include <std_msgs/String.h>
#include <std_msgs/Bool.h>
#include <geometry_msgs/TransformStamped.h>
#include <ras_msgs/RAS_Evidence.h>
#include <iostream>
#include <fstream>

using namespace cv;
using namespace std;
class ObjectDetection{
public: /* ros */
	ros::NodeHandle nh;
    ros::Subscriber sub_image_rgb;  // subscribe the rgb image from the realsence
    ros::Subscriber sub_image_depth;    // subscribe the depth image from the realsence
    ros::Subscriber sub_tensorflow_state;   // subscribe the classification state (busy or not busy)
    ros::Subscriber sub_classification_shape;   // subscaribe the result of classification from tensorflow
    ros::Subscriber sub_rob_position;   // subscribe the robot global position from tf
    ros::Subscriber sub_moving_state;   // subscribe the moving state (moving or stop)

    ros::Publisher pub_object_pose; // publish the detected object pose
    ros::Publisher pub_object_marker;   // publish the object marker to rviz
    ros::Publisher pub_object_marker_array; // publish all object marker to rviz
    ros::Publisher pose_pub;    // publish the global pose of robot
    ros::Publisher pub_speak;   // publish the classifiction results to espeak
    ros::Publisher pub_evidence;    // publish the evidence
    ros::Publisher pub_findBattery; // if detect an battery, publish to a topic. 
    ros::Publisher pub_findObject;  // if detect an object, publish to a topic. 
    //ros::Publisher pub_classification_target;

    visualization_msgs::Marker marker;
    visualization_msgs::MarkerArray marker_array;   // object array, shown in rviz

    tf::TransformListener listener; // tf listener, used to subscribe the global pose of robot and object. 
    
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
    void showResult(int index, int obi);
    int getDepth(int x, int y); // get the currenet
    void pubPose(double x, double y, int type); // publish the pose of robot (current)
    void listen_obj_map(double x, double y, int type);  // check which object
    bool check_pre_object(int temp);    // useless
    int getTrueDepth(int depth);    // better depth
    Mat cropTarget(int x, int y);   // crop a small image used for classification
    void saveTrainingData(Mat target);  // useless
    void publishClassificationTarget(Mat target);   // publish the classification result 
    void stateCallback(const std_msgs::Int32ConstPtr &msg); // to know the current state in state machine
    void shapeCallback(const std_msgs::Int32ConstPtr &msg); // to know the shape
    int check_now_object(); // get the current object 
    int check_now_object_color_shape(); // use less
    void speakResult(); // speak the result with espeak
    void showCresult(); // show the current result of object
    bool check_pre_object_by_position(int temp, double x, double y);    // now useless
    void publishEvidence(String object_id, Mat image, double x, double y);  // publish the evidence -- for rosbag
    String getEvidenceID(int index);    // get the id of the object, used for evidence
    void robotCallback(const geometry_msgs::Pose2D::ConstPtr &msg); // subscribe the coordinate of the robot
    double calculateDiatance(double x1, double y1, double x2, double y2);   // calculate distance between two coordinate
    void stateMovingCallback(const std_msgs::Int32ConstPtr &msg);   // check weather the robot is moving
    int getDepth_onePoint(int x, int y);    // get the depth from one point
    bool detectBarrier(bool detect);    // detect the barrier

public:
    static const int img_rgb_height = 480;
    static const int img_rgb_width = 640;
    static const double fx = 619.7237548828125;
    static const double cx = 304.5382995605469;
    int preDetectColor; // now useless
    int object_depth;   // the depth of object
    int tensorflowState;    // whether the classification is busy 1 busy 0 not busy
    int movingState;    // 1 moving 0 stop
    cv_bridge::CvImagePtr cv_rgb_ptr;   // rgb image pointer 
    cv_bridge::CvImagePtr cv_depth_ptr; // depth image pointer
    string cascade_name;    // the haar cascade name
    CascadeClassifier cascade;  // the haar cascade of object
    CascadeClassifier cascade_battery; // the haar cascade of battery
    std::vector<Rect> objects;  // all object
    std::vector<Rect> objects_battery;  // all battery
    ObjectColorShape obj;
    geometry_msgs::Pose2D pose; 
    Mat origin_frame;   // the origin rgb image
    Mat evidence_frame; // the image used for evidence
    Mat origin_frame_masked;    // the origin image with hsv mask

    // used for coordinate transform
    geometry_msgs::PointStamped obj_tf_camera;
    geometry_msgs::PointStamped obj_tf_map;
    geometry_msgs::Pose2D pose_;

    // the evidence we need to publish
    double evidence_x;  
    double evidence_y;
    String evidence_id;

    // informaton of the current object
    int now_color;  
    int now_shape;
    int now_object;

    // coordinate of the robot
    double robot_x;
    double robot_y;
    double robot_theta;

    ros::Time current_time;
    ros::Time arrival_time;
    ros::Time current_time2;    
    ros::Time arrival_time2;

    
};

 