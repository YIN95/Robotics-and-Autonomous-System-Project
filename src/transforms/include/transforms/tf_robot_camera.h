#include "ros/ros.h"
#include <tf/transform_broadcaster.h>
#include <nav_msgs/Odometry.h>
#include <geometry_msgs/Pose2D.h>

class TF_Robot_Camera{
public:
    TF_Robot_Camera();
    void setTransform();
    
public:
    ros::NodeHandle nh;
};