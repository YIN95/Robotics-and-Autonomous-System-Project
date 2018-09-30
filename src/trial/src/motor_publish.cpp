#include "ros/ros.h"
#include <std_msgs/Float32.h>
//#include <phidgets/motor_encoder.h>
//#include <phidgets/motor_params.h>

int control_frequency = 10;


int main(int argc, char **argv) 
{
	ros::init(argc, argv, "motor_publish");
	ros::NodeHandle nh;
	ros::Rate rate(control_frequency);
	
	ros::Publisher pub = nh.advertise<std_msgs::Float32>("/motorcontrol/cmd_vel", 1);
	
	std_msgs::Float32 motor_msg;
	motor_msg.data = 30;
	while (ros::ok()) {
		pub.publish(motor_msg);
		rate.sleep();
	}
	return 0;
}
