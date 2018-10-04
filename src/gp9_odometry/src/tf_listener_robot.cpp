#include "tf_listener_robot.h"

void transformPoint_rob_map(const tf::TransformListener& listener, geometry_msgs::PointStamped& robot_base_point, geometry_msgs::PointStamped& robot_map_point, nav_msgs::Odometry& robot_on_map_odom, ros::Publisher& pub_rob_odom_on_map){
  robot_base_point.header.frame_id = "Coor_robot_base";
  robot_base_point.header.stamp = ros::Time();

  try{
    listener.transformPoint("Coor_map", robot_base_point, robot_map_point);
    ROS_INFO("=-=-=-=-=-=-=-=-=-=-=-=-=");
    
    ROS_INFO("Coor_robot_base: (%.2f, %.2f) --> Coor_map: (%.2f, %.2f)",
        robot_base_point.point.x, robot_base_point.point.y,
        robot_map_point.point.x, robot_map_point.point.y);

    robot_on_map_odom.pose.pose.position.x = robot_map_point.point.x;
    robot_on_map_odom.pose.pose.position.y = robot_map_point.point.y;
    pub_rob_odom_on_map.publish(robot_on_map_odom);
  }
  catch(tf::TransformException& ex){
    ROS_ERROR("Received an exception trying to transform a point from \"Coor_robot_base\" to \"Coor_map\": %s", ex.what());
  }

}



int main(int argc, char** argv){
  ros::init(argc, argv, "robot_tf_listener");  
  TF_L_SYSTEM TF;
  tf::TransformListener listener(ros::Duration(2));
  ros::Timer timer_rob2map = TF.nh.createTimer(ros::Duration(1), 
          boost::bind(&transformPoint_rob_map, boost::ref(listener), 
          boost::ref(TF.robot_base_point), boost::ref(TF.robot_map_point), boost::ref(TF.robot_on_map_odom), boost::ref(TF.pub_rob_odom_on_map)));
  
  ros::spin();
  return 0;
 
}


TF_L_SYSTEM::TF_L_SYSTEM(){
  sub_odom_rob = nh.subscribe<nav_msgs::Odometry>("/odom", 1, &TF_L_SYSTEM::odometryCallbackUpdateRobPosture, this);
  pub_rob_odom_on_map  = nh.advertise<nav_msgs::Odometry>("/tf/rob_odom", 1);

  robot_base_point.point.x = 0.0;
  robot_base_point.point.y = 0.0;
  robot_base_point.point.z = 0.0;
  
  robot_map_point.point.x = 0.0;
  robot_map_point.point.y = 0.0;
  robot_map_point.point.z = 0.0;
}

void TF_L_SYSTEM::odometryCallbackUpdateRobPosture(const nav_msgs::Odometry::ConstPtr &msg){
  robot_base_point.point.x = msg->pose.pose.position.x;
  robot_base_point.point.y = msg->pose.pose.position.y;
  robot_base_point.point.z = 0.0;
  robot_on_map_odom = *msg;
  return;
}