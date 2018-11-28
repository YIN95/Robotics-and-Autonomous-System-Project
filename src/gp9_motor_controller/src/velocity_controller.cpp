#include <gp9_motor_controller/velocity_controller.h>

// when w > 0, turn left
// when w < 0 turn right

int main(int argc, char **argv)
{
	int control_frequency = 125;

	ros::init(argc, argv, "velocity_publish");
	VelocityController VW;
	ros::NodeHandle nh;
	ros::Rate rate(control_frequency);

	ros::Subscriber key_sub = nh.subscribe<geometry_msgs::Twist>("/key_vel", 1, &VelocityController::twistCallBack, &VW);
	ros::Publisher pub = nh.advertise<geometry_msgs::Twist>("/motor_controller/velocity", 1);
	
	while (nh.ok()){
		ros::spinOnce();
		pub.publish(VW.velocity_msg);
		rate.sleep();
	}
	return 0;
}

/* Command control */
void VelocityController::goForward(){
	setVW(0.08, 0.0);
	return;
}

void VelocityController::goBackward(){
	setVW(-0.08, 0.0);
	return;
}

void VelocityController::turnLeft(){
	setVW(0.0, 0.2);
	return;
}

void VelocityController::turnRight(){
	setVW(0.0, -0.2);
	return;
}

void VelocityController::twistCallBack(const geometry_msgs::Twist::ConstPtr& msg){
	velocity_msg.linear.x = msg->linear.x;
	velocity_msg.angular.z = 8*msg->angular.z; // 6*
}


/* Velocity Controller*/
VelocityController::VelocityController(){
	v = 0.2;
	w = 0;
}
VelocityController::VelocityController(double v_, double w_){
	v = v_;
	w = w_;
}
void VelocityController::setV(double v_){
	v = v_;
	return;
}
void VelocityController::setW(double w_){
	w = w_;
	return;
}
void VelocityController::setVW(double v_, double w_){
	setV(v_);
	setW(w_);
	return;
}
