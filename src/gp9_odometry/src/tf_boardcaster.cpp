#include "tf_boardcaster.h"

int main(int argc, char** argv){
  ros::init(argc, argv, "robot_tf_publisher");
  TF_B_SYSTEM TF;
  ros::Rate rate(10);

  while(TF.nh.ok()){
    ros::spinOnce();
    TF.sendTransform_robot_map();
    rate.sleep();
  }
}




TF_B_SYSTEM::TF_B_SYSTEM(){
    
    rob2map_x = 0.1;
    rob2map_y = 0.1;
    rob2map_theta = 0;
}


void TF_B_SYSTEM::sendTransform_robot_map(){
    // tf from robot to map
    broadcaster.sendTransform(
      tf::StampedTransform(
        tf::Transform(tf::Quaternion(0, 0, rob2map_theta, 1),  // rotation
                      tf::Vector3(rob2map_x, rob2map_y, 0.0)),  // transition
        ros::Time::now(), // stamp
        "Coor_map", "Coor_robot_base"));
}