#include "motor_controller.h"

int main(int argc, char** argv) 
{	
	int control_frequency = 10;
	
	ros::init(argc, argv, "motor_publish");
	MotorController motorController(control_frequency);
	ros::Rate rate(control_frequency);
	
	while (ros::ok()) {
		ros::spinOnce();
		motorController.PI();
		rate.sleep();
		ROS_INFO("-=-=-=-=-=-=-=-=-=-=-=-=-=-=-");
	}
	return 0;
}

MotorController::MotorController(){		
	nh = ros::NodeHandle("~");
	
	sub_velocity = nh.subscribe<geometry_msgs::Twist>("/motor_controller/velocity", 1, &MotorController::velocityCallback, this);
	sub_encoder_left = nh.subscribe<phidgets::motor_encoder>("/motor_left/encoder", 1, &MotorController::encoderCallbackLeft, this);
	sub_encoder_right = nh.subscribe<phidgets::motor_encoder>("/motor_right/encoder", 1, &MotorController::encoderCallbackRight, this);

	pub_left = nh.advertise<std_msgs::Float32>("/motor_left/cmd_vel", 1);
	pub_right = nh.advertise<std_msgs::Float32>("/motor_right/cmd_vel", 1);
	
	int control_frequency = 10;
	dt = 1.0 / control_frequency;
			
	alpha = std::vector<double>(2, 0);
	beta = std::vector<double>(2, 0);
	alpha[LEFT] = 10;
	alpha[RIGHT] = 10;
	beta[LEFT] = 5;
	beta[RIGHT] = 5;
	int_error = std::vector<double>(2, 0);
	w_desired =	std::vector<double>(2, 0);
	w_estimate = std::vector<double>(2, 0);
	delta_encoder =	std::vector<int>(2, 0);
}

MotorController::MotorController(int control_frequency_) {		
	nh = ros::NodeHandle("~");

	sub_velocity = nh.subscribe<geometry_msgs::Twist>("/motor_controller/velocity", 1, &MotorController::velocityCallback, this);
	sub_encoder_left = nh.subscribe<phidgets::motor_encoder>("/motor_left/encoder", 1, &MotorController::encoderCallbackLeft, this);
	sub_encoder_right = nh.subscribe<phidgets::motor_encoder>("/motor_right/encoder", 1, &MotorController::encoderCallbackRight, this);

	pub_left = nh.advertise<std_msgs::Float32>("/motor_left/cmd_vel", 1);
	pub_right = nh.advertise<std_msgs::Float32>("/motor_right/cmd_vel", 1);
	
	control_frequency = control_frequency_;
	dt = 1.0 / control_frequency;
	
	alpha = std::vector<double>(2, 0);
	beta = std::vector<double>(2, 0);
	alpha[LEFT] = 15;
	alpha[RIGHT] = 15;
	beta[LEFT] = 5;
	beta[RIGHT] = 5;
	int_error = std::vector<double>(2, 0);
	w_desired =	std::vector<double>(2, 0);
	w_estimate = std::vector<double>(2, 0);
	delta_encoder =	std::vector<int>(2, 0);
}

void MotorController::velocityCallback(const geometry_msgs::Twist::ConstPtr &msg) {
	v_robot_desired = msg->linear.x;
	w_robot_desired= msg->angular.z;
}

void MotorController::encoderCallbackLeft(const phidgets::motor_encoder::ConstPtr &msg) {
	delta_encoder[LEFT] = msg->count_change;
	ROS_INFO("encoder_left : %i", delta_encoder[LEFT]);
}

void MotorController::encoderCallbackRight(const phidgets::motor_encoder::ConstPtr &msg) {
	delta_encoder[RIGHT] = msg->count_change;
	delta_encoder[RIGHT] *= -1;
	ROS_INFO("encoder_right : %i", delta_encoder[RIGHT]);
}

void MotorController::updateEstimatedSpeed() {
	w_estimate[LEFT] = (delta_encoder[LEFT] * 2 * M_PI * control_frequency) / ticks_per_rev;
	w_estimate[RIGHT] = (delta_encoder[RIGHT] * 2 * M_PI * control_frequency) / ticks_per_rev;
	ROS_INFO("w_estimated_left : %f", w_estimate[LEFT]);
	ROS_INFO("w_estimated_right: %f", w_estimate[RIGHT]);
}

void MotorController::updateDesiredSpeed() {
	w_desired[LEFT] = (v_robot_desired - w_robot_desired * (base / 2)) / wheel_radius;
	w_desired[RIGHT] = (v_robot_desired + w_robot_desired * (base / 2)) / wheel_radius;
	ROS_INFO("w_desired_left : %f", w_desired[LEFT]);
	ROS_INFO("w_desired_right: %f", w_desired[RIGHT]);
}

void MotorController::setMotorPowers() {
	double error_left;
	double error_right;
	int signal;
	
	error_left = w_desired[LEFT] - w_estimate[LEFT];
	int_error[LEFT] += error_left * dt;
	ROS_INFO("error_left: %f", error_left);
	signal = int (alpha[LEFT] * error_left + beta[LEFT] * int_error[LEFT]);
	left_motor.data = signal;
	
	
	error_right = w_estimate[RIGHT] - w_desired[RIGHT];
	int_error[RIGHT] += error_right * dt;
	ROS_INFO("error_right: %f", error_right);
	signal = int (alpha[RIGHT] * error_right + beta[RIGHT] * int_error[RIGHT]);
	right_motor.data = signal;
}

void MotorController::clipPowerValues() {
	double left = std::abs(left_motor.data);
	double right = std::abs(right_motor.data);
	double largest = std::max(left, right);
	if (largest > clip_value) {
		ROS_INFO("Clipping stuff");
		double scale_factor = clip_value / largest;
		left_motor.data *= scale_factor;
		right_motor.data *= scale_factor;
	}
	ROS_INFO("signal to left motor: %f", left_motor.data);
	ROS_INFO("signal to right motor: %f", right_motor.data);
}

void MotorController::PI() {
	updateDesiredSpeed();
	updateEstimatedSpeed();
	setMotorPowers();
	clipPowerValues();
	pub_left.publish(left_motor);
	pub_right.publish(right_motor);
}