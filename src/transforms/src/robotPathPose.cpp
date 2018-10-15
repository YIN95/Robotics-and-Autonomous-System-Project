#include "ros/ros.h"
#include <tf/transform_broadcaster.h>
#include <geometry_msgs/Pose2D.h>
#include <math.h>
#include <std_msgs/Float32.h>
#include <iostream>
#include <stdio.h>
#include <robotPathPose.h>

int main(int argc, char** argv){
    ros::init(argc, argv, "robotPathPose");
    robotPathPose rPP;
    ros::Rate rate(10);
    while (rPP.nh.ok()){
       
       ros::spinOnce();
	    rate.sleep();
    }
    return 0;
};

robotPathPose::robotPathPose(){
    sub_object_coor = nh.subscribe<geometry_msgs::Pose2D>("/global_pose/object", 1, &robotPathPose::objectCallback, this);
    sub_robot_coor = nh.subscribe<geometry_msgs::Pose2D>("/global_pose/robot", 1, &robotPathPose::robotCallback, this);
    pub_global_robot_coor_theta = nh.advertise<geometry_msgs::Pose2D>("/global_PathPose/robot", 1);
    
    object_x = 0;
    object_y = 0;
    robot_x = 0;
    robot_y = 0;
    theta = 0;
}


void robotPathPose::objectCallback(const geometry_msgs::Pose2D::ConstPtr &msg){
    geometry_msgs::Pose2D pose;
    object_x = msg->x;
    object_y = msg->y;
    pose.theta = coor2Pose(object_x, object_y, robot_x, robot_y);
    pose.x = object_x - 0.05;
    pose.y = object_y;
    pub_global_robot_coor_theta.publish(pose);
    return;
}

void robotPathPose::robotCallback(const geometry_msgs::Pose2D::ConstPtr &msg){
    robot_x = msg->x;
    robot_y = msg->y;
    return;
}

double robotPathPose::coor2Pose(double x1, double y1, double x2, double y2){
    double l1 = x1 - x2;
    double l2 = y1 - y2;
    theta = atan2(l2, l1);
    return theta;
}

