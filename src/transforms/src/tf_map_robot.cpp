#include "tf_map_robot.h"

int main(int argc, char** argv){
  ros::init(argc, argv, "tf_map_robot");

  TF_Map_Robot TF;
  ros::Rate rate(10);

  while(TF.nh.ok()){
    ros::spinOnce();
    rate.sleep();
  }

}


void TF_Map_Robot::poseCallBack(const geometry_msgs::Pose2D::ConstPtr &msg) {
  static tf::TransformBroadcaster br_global;
  tf::Transform transform;
  transform.setOrigin(tf::Vector3(msg->x, msg->y, 0.0));
  tf::Quaternion q;
  q.setRPY(0, 0, msg->theta); // this attribute of the message comes as a quaternion
  transform.setRotation(q);
  br_global.sendTransform(tf::StampedTransform(transform, ros::Time::now(), "/map", "/robot"));
  ROS_INFO("X: %f", msg->x);
  ROS_INFO("Y: %f", msg->y);
  ROS_INFO("THETA: %f", msg->theta);
}


TF_Map_Robot::TF_Map_Robot() {
  sub_pose = nh.subscribe<geometry_msgs::Pose2D>("/pose", 1, &TF_Map_Robot::poseCallBack, this);

}


