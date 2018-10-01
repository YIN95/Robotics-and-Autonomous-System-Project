#include "velocity_publish.h"

VelocityControler VW(0.08, 0);
// when w > 0, turn left
// when w < 0 turn right

int main(int argc, char **argv)
{
	
	ros::init(argc, argv, "velocity_publish");
	ros::NodeHandle nh;
	ros::Rate rate(10);

	ros::Publisher pub = nh.advertise<geometry_msgs::Twist>("/motor_controller/velocity", 1);
	
	geometry_msgs::Twist velocity_msg;
	
	velocity_msg.linear.x = VW.v;
	velocity_msg.angular.z = VW.w;
	
	while (ros::ok()){
		rate.sleep();
		pub.publish(velocity_msg);
	}
	return 0;
}

/* Command control */
void VelocityControler::goForward(){
	setVW(0.08, 0.0);
	return;
}

void VelocityControler::goBackward(){
	setVW(-0.08, 0.0);
	return;
}

void VelocityControler::turnLeft(){
	setVW(0.08, 0.2);
	return;
}

void VelocityControler::turnRight(){
	setVW(0.08, -0.2);
	return;
}


/* Velocity Controller*/
VelocityControler::VelocityControler(){
	v = 0.2;
	w = 0;
}
VelocityControler::VelocityControler(double v_, double w_){
	v = v_;
	w = w_;
}
void VelocityControler::setV(double v_){
	v = v_;
	return;
}
void VelocityControler::setW(double w_){
	w = w_;
	return;
}
void VelocityControler::setVW(double v_, double w_){
	setV(v_);
	setW(w_);
	return;
}