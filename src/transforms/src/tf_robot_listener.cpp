// #include <ros/ros.h>
// #include <tf/transform_listener.h>
// #include <geometry_msgs/Pose2D.h>

// int main(int argc, char** argv){
//     ros::init(argc, argv, "tf_object_listener");

//     ros::NodeHandle nh;
//     ros::Publisher pose_pub = nh.advertise<geometry_msgs::Pose2D>("/global_pose/robot", 1);
//     tf::TransformListener listener;
//     ros::Rate rate(10);

//     while (nh.ok()){
//         tf::StampedTransform transform;
//         try{
//             listener.lookupTransform("/map", "/robot", ros::Time(0), transform);
//         }
//         catch (tf::TransformException &ex) {
//             ROS_ERROR("%s",ex.what());
//             ros::Duration(1.0).sleep();
//             continue;
//     }

//     geometry_msgs::Pose2D pose;
//     pose.x = transform.getOrigin().x();
//     pose.y = transform.getOrigin().y();
//     ROS_INFO("posex: %d", pose.x);
//     ROS_INFO("posey: %d", pose.y);
//     pose_pub.publish(pose);
    
//     rate.sleep();
//   }
//   return 0;
// };