#include "odometry.h"

int main(int argc, char** argv){
    int control_frequency = 10;
    
    ros::init(argc, argv, "odometry");
    Odometry odometry(control_frequency);
    ros::Rate rate(10);

    while (ros::ok()) {
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
    rob_w = 0.0;

    odom_quat = tf::createQuaternionMsgFromYaw(rob_theta);
}

void Odometry::updateEstimatedOdometry(){
    odom_quat = tf::createQuaternionMsgFromYaw(rob_theta);

    odom_trans.header.stamp = current_time;
    odom_trans.header.frame_id = "odom";
    odom_trans.child_frame_id = "base_link";

    odom_trans.transform.translation.x = rob_x;
    odom_trans.transform.translation.y = rob_y;
    odom_trans.transform.translation.z = 0.0;
    odom_trans.transform.rotation = odom_quat;

    //send the transform
    odom_broadcaster.sendTransform(odom_trans);
    odom.header.stamp = current_time;
    odom.header.frame_id = "odom";
    
    //set the position
    odom.pose.pose.position.x = rob_x;
    odom.pose.pose.position.y = rob_y;
    odom.pose.pose.position.z = 0.0;
    odom.pose.pose.orientation = odom_quat;

    //set the velocity
    odom.child_frame_id = "base_link";
    odom.twist.twist.linear.x = rob_x_v;
    odom.twist.twist.linear.y = rob_y_v;
    odom.twist.twist.angular.z = rob_w;

    //publish the message
    odom_pub.publish(odom);
    last_time = current_time;
    r.sleep();
    
    return;
}

void Odometry::updateEstimatedPosition(){
    rob_x = rob_x + rob_x_delta;
    rob_y = rob_y + rob_y_delta;
    rob_theta = rob_theta + rob_theta_delta;
    
    return;
}

void Odometry::updateEstimatedDelta(){
    rob_x_delta = rob_x_v * dt;
    rob_y_delta = rob_y_v * dt;
    rob_theta_delta = rob_w * dt;

    return;
}

void Odometry::updateEstimatedSpeed(){
    rob_x_v = estimated_v * cos(rob_theta); 
    rob_y_v = estimated_v * sin(rob_theta); 
    rob_w = estimated_w;
    
    return;
}

void Odometry::motorCallbackSpeed(const geometry_msgs::Twist::ConstPtr &msg){
    estimated_v = msg->linear.x;
    estimated_w = msg->angular.z;
    ROS_INFO("estimated_v : %f", estimated_v);
    ROS_INFO("estimated_w : %f", estimated_w);
    
    return;
}