#include "ros/ros.h"
#include <tf/transform_broadcaster.h>
#include <geometry_msgs/Pose2D.h>
#include <math.h>
#include <std_msgs/Float32.h>
#include <iostream>
#include <stdio.h>

class robotPathPose{
public:
    robotPathPose();
    void objectCallback(const geometry_msgs::Pose2D::ConstPtr &msg);
    void robotCallback(const geometry_msgs::Pose2D::ConstPtr &msg);
    double coor2Pose(double x1, double y1, double x2, double y2);
public:
    ros::NodeHandle nh;
    ros::Subscriber sub_object_coor;
    ros::Subscriber sub_robot_coor;
    ros::Publisher  pub_global_robot_coor_theta;
public:
    double object_x;
    double object_y;
    double robot_x;
    double robot_y;
    double theta;
};