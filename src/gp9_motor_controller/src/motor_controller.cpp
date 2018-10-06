#include "motor_controller.h"

int main(int argc, char** argv) 
{	
	int control_frequency = 10;
	
	ros::init(argc, argv, "motor_publish");
	MotorController motorController(control_frequency);
	ros::Rate rate(control_frequency);
	
	while (motorController.nh.ok()) {
		ros::spinOnce();
		motorController.PID();
		motorController.publishEstimatedSpeed();
		rate.sleep();
		ROS_INFO("-=-=-=-=-=-=-=-=-=-=-=-=-=-=-");
	}
	return 0;
}

MotorController::MotorController(int control_frequency_) {		
	nh = ros::NodeHandle("~");

	sub_velocity = nh.subscribe<geometry_msgs::Twist>("/motor_controller/velocity", 1, &MotorController::velocityCallback, this);
	sub_encoder_left = nh.subscribe<phidgets::motor_encoder>("/motor_left/encoder", 1, &MotorController::encoderCallbackLeft, this);
	sub_encoder_right = nh.subscribe<phidgets::motor_encoder>("/motor_right/encoder", 1, &MotorController::encoderCallbackRight, this);

	pub_left = nh.advertise<std_msgs::Float32>("/motor_left/cmd_vel", 1);
	pub_right = nh.advertise<std_msgs::Float32>("/motor_right/cmd_vel", 1);
	pub_velocity = nh.advertise<geometry_msgs::Twist>("/velocity_estimate", 1);
	
	control_frequency = control_frequency_;
	dt = 1.0 / control_frequency;
	
	v_robot_desired = 0;
	w_robot_desired = 0;
	
	alpha = std::vector<double>(2, 0);
	beta = std::vector<double>(2, 0);
	gamma = std::vector<double>(2, 0);
	alpha[LEFT] = 5;
	alpha[RIGHT] = 5;
	beta[LEFT] = 20;
	beta[RIGHT] = 20;
	gamma[LEFT] = 0;
	gamma[RIGHT] = 0;
	prev_error = std::vector<double>(2, 0);
	int_error = std::vector<double>(2, 0);
	w_desired =	std::vector<double>(2, 0);
	w_estimate = std::vector<double>(2, 0);
	delta_encoder =	std::vector<int>(2, 0);
}

void MotorController::velocityCallback(const geometry_msgs::Twist::ConstPtr &msg) {
	v_robot_desired = msg->linear.x;
	w_robot_desired= msg->angular.z;
	ROS_INFO("v: %f", v_robot_desired);
	ROS_INFO("w: %f", w_robot_desired);
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
	w_estimate[LEFT] = (delta_encoder[LEFT] * 2 * M_PI * 121) / ticks_per_rev;
	w_estimate[RIGHT] = (delta_encoder[RIGHT] * 2 * M_PI * 121) / ticks_per_rev;
	ROS_INFO("w_estimated_left : %f", w_estimate[LEFT]);
	ROS_INFO("w_estimated_right: %f", w_estimate[RIGHT]);

	v_robot_estimated = (w_estimate[RIGHT] + w_estimate[LEFT]) * wheel_radius / 2;
	w_robot_estimated = (w_estimate[RIGHT] - w_estimate[LEFT]) * wheel_radius / base;

	ROS_INFO("v estimate: %f", v_robot_estimated);
	ROS_INFO("w estimate: %f", w_robot_estimated);

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
	double derror_left_dt, derror_right_dt;
	int signal_left, signal_right;
	
	error_left = w_desired[LEFT] - w_estimate[LEFT];
	derror_left_dt = (error_left - prev_error[LEFT]) / dt;
	int_error[LEFT] = int_error[LEFT] + error_left * dt;
	ROS_INFO("error_left: %f", error_left);
	ROS_INFO("int error left: %f", int_error[LEFT]);
	signal_left = int (alpha[LEFT] * error_left + beta[LEFT] * int_error[LEFT] + gamma[LEFT] * derror_left_dt);
	left_motor.data = signal_left;
	prev_error[LEFT] = error_left;
	
	error_right = w_estimate[RIGHT] - w_desired[RIGHT];
	derror_right_dt = (error_right - prev_error[RIGHT]) / dt;
	int_error[RIGHT] = int_error[RIGHT] + error_right * dt;
	ROS_INFO("error_right: %f", error_right);
	ROS_INFO("int error right: %f", int_error[RIGHT]);
	signal_right = int (alpha[RIGHT] * error_right + beta[RIGHT] * int_error[RIGHT] + gamma[RIGHT] * derror_right_dt);
	right_motor.data = signal_right;
	prev_error[RIGHT] = error_right;
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

void MotorController::PID() {
	updateDesiredSpeed();
	updateEstimatedSpeed();
	setMotorPowers();
	clipPowerValues();
	pub_left.publish(left_motor);
	pub_right.publish(right_motor);
}

void MotorController::publishEstimatedSpeed(){
	geometry_msgs::Twist msg;
	msg.linear.x = v_robot_estimated;
	msg.angular.z = w_robot_estimated;
	pub_velocity.publish(msg);
}
//~MotorController();