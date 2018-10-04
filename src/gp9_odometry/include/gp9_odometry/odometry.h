#include "ros/ros.h"
#include <math.h>
#include <vector>
#include <std_msgs/Float32.h>
#include <geometry_msgs/Twist.h>
#include "phidgets/motor_encoder.h"
#include <nav_msgs/Odometry.h>
#include <tf/transform_broadcaster.h>
#include <tf/transform_listener.h>

class Odometry{
public: /* ros */
    ros::NodeHandle nh;
	ros::Time current_time;
    ros::Time last_time;

	/* Publishers */
	ros::Publisher pub_odom;    // publish the odometry

    /* Subscribers */
	ros::Subscriber estimatedSpeed;

    /* transformation */
    tf::TransformBroadcaster odom_broadcaster;
    geometry_msgs::Quaternion odom_quat;
    geometry_msgs::TransformStamped odom_trans;
    nav_msgs::Odometry odom;

public: /* Functions */
    Odometry(int control_frequency_);
    // void transformPoint(const )
    void updateEstimatedPosition();
    void updateEstimatedSpeed();
    void updateEstimatedDelta();
    void updateEstimatedOdometry();
    void motorCallbackSpeed(const geometry_msgs::Twist::ConstPtr &msg);
    // void cal

private: /* robot pose */
    // the odometry of robot relative map
    
    // the odometry of robot relative to robot
    double rob_x;   // position x
    double rob_y;   // position y
    double rob_theta;   // orientation

    int control_frequency;
    double dt;

    double rob_x_on_map;
    double rob_y_on_map;
    double rob_theta_on_map;

    double rob_x_delta;
    double rob_y_delta;
    double rob_theta_delta;

    double estimated_v;
    double estimated_w;

    double rob_x_v; // velocity x v*cos theta
    double rob_y_v; // velocity y v*sin theta
    double rob_w; // velocity orientation w


};