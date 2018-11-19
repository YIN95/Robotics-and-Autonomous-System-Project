#include "ros/ros.h"
#include <math.h>
#include <vector>
#include <std_msgs/Float32.h>
#include <std_msgs/Int32.h>
#include <geometry_msgs/Twist.h>
#include <geometry_msgs/Pose2D.h>
#include <tf/transform_broadcaster.h>
#include <tf/transform_listener.h>
#include <visualization_msgs/Marker.h>
#include <nav_msgs/Odometry.h>


class Odometry{
public: /* ros */
    ros::NodeHandle nh;
	ros::Time current_time;
    ros::Time last_time;

	/* Publishers */
    ros::Publisher pub_pose;
    ros::Publisher pub_robot_marker;
    ros::Publisher pub_moving_state;

    /* Subscribers */
	ros::Subscriber estimatedSpeed;
    ros::Subscriber sub_weighted_pose;


    geometry_msgs::Pose2D pose;

public: /* Functions */
    Odometry(int control_frequency_);
    // void transformPoint(const )
    void updateEstimatedPosition();
    void updateEstimatedSpeed();
    void updateEstimatedDelta();
    void updateEstimatedOdometry();
    void motorCallbackSpeed(const geometry_msgs::Twist::ConstPtr &msg);
    void poseCallback(const geometry_msgs::Pose2D::ConstPtr &msg);
    void pub_robot_Pose(double x, double y);
    // void cal
    void ismoving(double vx, double vy, double w);
private: /* robot pose */
    // the odometry of robot relative map
    
    // the odometry of robot relative to robot
    double rob_x;   // position x
    double rob_y;   // position y
    double rob_theta;   // orientation

    int control_frequency;
    double dt;
    bool _ismoving;
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
    unsigned int count_value;
    unsigned int update_time;

};
