#include "odometry.h"

int main(int argc, char** argv){
    int control_frequency = 10;
    
    ros::init(argc, argv, "odometry");
    Odometry odometry(control_frequency);
    ros::Rate rate(10);

    while (nh.ok()) {
		ros::spinOnce();


		rate.sleep();
		ROS_INFO("-=-=-=-=-=-=-=-=-=-=-=-=-=-=-");
	}
	return 0;
}

Odometry::Odometry(int control_frequency_){
    control_frequency = control_frequency_;
    dt = (current_time - last_time).toSec();

    odom_pub = nh.advertise<nav_msgs::Odometry>("odom", 50);
    estimatedSpeed = nh.subscribe<geometry_msgs::Twist>("/velocity_estimate", 1, &Odometry::motorCallbackSpeed, this);

    current_time = ros::Time::now();
    last_time = ros::Time::now();

    rob_x = 0.0;
    rob_y = 0.0;
    rob_theta = 0.0;

    rob_x_v = 0.0;
    rob_y_v = 0.0;
    rob_theta_v = 0.0;
}

void Odometry::updateEstimatedSpeed(){
    rob_x_v = estimated_v * 
}

void Odometry::motorCallbackSpeed(const geometry_msgs::Twist::ConstPtr &msg){
    estimated_v = msg->linear.x;
    estimated_w = msg->angular.z;
    return;
}