#include "ros/ros.h"
#include <tf/transform_broadcaster.h>
#include <nav_msgs/Odometry.h>
#include <geometry_msgs/Pose2D.h>
#include <visualization_msgs/Marker.h>

class TF_Camera_Object{
public:
    TF_Camera_Object();
    void poseCallBack(const visualization_msgs::Marker::ConstPtr &msg);
    // void setTransform();
    
public:
    ros::NodeHandle nh;
    ros::Subscriber sub_pose;
};