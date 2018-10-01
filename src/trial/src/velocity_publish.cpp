#include <ros/ros.h>
#include <geometry_msgs/Twist.h>


double v = 0.1;
double w = 0;

int main(int argc, char **argv)
{
	ros::init(argc, argv, "velocity_publish");
	ros::NodeHandle nh;
	ros::Rate rate(10);
	
	ros::Publisher pub = nh.advertise<geometry_msgs::Twist>("/motor_controller/velocity", 1);
	
	geometry_msgs::Twist velocity_msg;
	
	velocity_msg.linear.x = v;
	velocity_msg.angular.z = w;
	
	while (ros::ok()) {
		rate.sleep();
		pub.publish(velocity_msg);
	}
	return 0;
}
