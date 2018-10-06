#include "ros/ros.h"
#include <tf/transform_broadcaster.h>
#include <nav_msgs/Odometry.h>
#include <geometry_msgs/Pose2D.h>

class TF_Global_Robot{
public:
    TF_Global_Robot();
    void poseCallBack(const geometry_msgs::Pose2D::ConstPtr &msg);
    
public:
    ros::NodeHandle nh;
    ros::Subscriber sub_pose;

};

