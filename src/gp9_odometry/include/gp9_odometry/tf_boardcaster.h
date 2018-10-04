#include "ros/ros.h"
#include <tf/transform_broadcaster.h>

class TF_B_SYSTEM{
public:
    TF_B_SYSTEM();
    void sendTransform_robot_map();
    
public:
    ros::NodeHandle nh;
    tf::TransformBroadcaster broadcaster;
       

public:
    double rob2map_x;
    double rob2map_y;
    double rob2map_theta;

};

