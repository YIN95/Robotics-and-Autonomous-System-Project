#include "ros/ros.h"
#include <geometry_msgs/PointStamped.h>
#include <tf/transform_listener.h>
#include "odometry.h"

class TF_L_SYSTEM{
public:
    TF_L_SYSTEM();
    void odometryCallbackUpdateRobPosture(const nav_msgs::Odometry::ConstPtr &msg);
    void update_publish_rob_odom_on_map();
public:
    ros::NodeHandle nh;

    /* Subscribers */
    ros::Subscriber sub_odom_rob; 

    /* Publishers */
    ros::Publisher pub_rob_odom_on_map;
    geometry_msgs::PointStamped robot_base_point;
    geometry_msgs::PointStamped robot_map_point;
    nav_msgs::Odometry robot_on_map_odom;
};

