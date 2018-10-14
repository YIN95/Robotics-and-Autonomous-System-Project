#include "tf_camera_object.h"
#include <math.h>

int main(int argc, char** argv){
  ros::init(argc, argv, "tf_camera_object");

  TF_Camera_Object TF;
  ros::Rate rate(10);

  while(TF.nh.ok()){
    ros::spinOnce();
    rate.sleep();
  }

}


void TF_Camera_Object::poseCallBack(const visualization_msgs::Marker::ConstPtr &msg) {
  static tf::TransformBroadcaster br_global;
  tf::Transform transform;
//   transform.setOrigin(tf::Vector3(msg->x, msg->y, 0.0));
  transform.setOrigin(tf::Vector3(msg->pose.position.x , -1.0 * msg->pose.position.y , 0.0));
  tf::Quaternion q;
  q.setRPY(0, 0, 0);
  transform.setRotation(q);
  br_global.sendTransform(tf::StampedTransform(transform, ros::Time::now(), "/camera", "/object"));

}


TF_Camera_Object::TF_Camera_Object() {
  sub_pose = nh.subscribe<visualization_msgs::Marker>("/object/marker", 1, &TF_Camera_Object::poseCallBack, this);

}


