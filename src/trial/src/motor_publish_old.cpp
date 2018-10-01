#include "ros/ros.h"
#include <math.h>
#include <vector>
#include <std_msgs/Float32.h>
#include <geometry_msgs/Twist.h>
#include "phidgets/motor_encoder.h"

const float base = 0.19;
const float wheel_radius = 0.05;
const int ticks_per_rev = 360;
const int control_frequency = 10;
const float dt = 1.0 / control_frequency;

double v_robot_desired;
double w_robot_desired;

// First element represent the left side, use LEFT and RIGHT variables
const int LEFT = 0;
const int RIGHT = 1;

std::vector<float> alpha (2, 0);
std::vector<float> beta (2, 0);
std::vector<float> int_error (2, 0);
std::vector<float> w_desired (2, 0);
std::vector<float> w_estimate (2, 0);
std::vector<int> delta_encoder (2, 0);


void velocityCallback(const geometry_msgs::Twist::ConstPtr& msg) {
	v_robot_desired = msg->linear.x;
	w_robot_desired= msg->angular.z;
}
		
void encoderCallbackLeft(const phidgets::motor_encoder::ConstPtr& msg) {
	delta_encoder[LEFT] = msg->count_change;
}
		
void encoderCallbackRight(const phidgets::motor_encoder::ConstPtr& msg) {
	delta_encoder[RIGHT] = msg->count_change;
}

void updateEstimatedSpeed() {
	w_estimate[LEFT] = (delta_encoder[LEFT] * 2 * M_PI * control_frequency) / ticks_per_rev;
	w_estimate[RIGHT] = (delta_encoder[RIGHT] * 2 * M_PI * control_frequency) / ticks_per_rev;
	w_estimate[RIGHT] *= -1; // compensate for right wheel spinning in wrong direction
	
	ROS_INFO("w est left : %f", w_estimate[LEFT]);
	ROS_INFO("w est right: %f", w_estimate[RIGHT]);
}

void updateDesiredSpeed() {
	w_desired[LEFT] = (v_robot_desired - w_robot_desired * (base / 2)) / wheel_radius;
	w_desired[RIGHT] = (v_robot_desired + w_robot_desired * (base / 2)) / wheel_radius;
	
	ROS_INFO("w des left : %f", w_desired[LEFT]);
	ROS_INFO("w des right: %f", w_desired[RIGHT]);
}

void setMotorPower(std_msgs::Float32& motor, int side) {
	
	float error = w_desired[side] - w_estimate[side];
	int_error[side] += error * dt;
	ROS_INFO("error: %f", error);
	//ROS_INFO("int error: %f", int_error[side]);
	int signal = int (alpha[side] * error + beta[side] * int_error[side]);
	motor.data = signal;
}

void clipPowerValues(std_msgs::Float32& left_motor_, std_msgs::Float32& right_motor_) {
	// Also clip on negative values
	float left = std::abs(left_motor_.data);
	float right = std::abs(right_motor_.data);
	float largest = std::max(left, right);
	if (largest > 80) {
		ROS_INFO("Clipping stuff");
		float scale_factor = 80 / largest;
		left_motor_.data *= scale_factor;
		right_motor_.data *= scale_factor;
	}
	ROS_INFO("signal to left motor: %f", left_motor_.data);
	ROS_INFO("signal to right motor: %f", right_motor_.data);
}


int main(int argc, char **argv) 
{
	alpha[LEFT] = 10;
	alpha[RIGHT] = 0;
	beta[LEFT] = 0;
	beta[RIGHT] = 0;
	ros::init(argc, argv, "motor_publish");
	ros::NodeHandle nh;
	ros::Rate rate(control_frequency);
	
	// Subscribers
	ros::Subscriber sub_velocity = nh.subscribe<geometry_msgs::Twist>("/motor_controller/velocity", 1, velocityCallback);
	ros::Subscriber sub_encoder_left = nh.subscribe<phidgets::motor_encoder>("motor_left/encoder", 1, encoderCallbackLeft);
	ros::Subscriber sub_encoder_right = nh.subscribe<phidgets::motor_encoder>("motor_right/encoder", 1, encoderCallbackRight);
	
	// Publishers
	ros::Publisher pub_left = nh.advertise<std_msgs::Float32>("/motor_left/cmd_vel", 1);
	ros::Publisher pub_right = nh.advertise<std_msgs::Float32>("/motor_right/cmd_vel", 1);
	
	std_msgs::Float32 left_motor;
	std_msgs::Float32 right_motor;
	
	while (ros::ok()) {
		ros::spinOnce();
		updateEstimatedSpeed();
		updateDesiredSpeed();
		
		ROS_INFO("After callbacks: ");
		ROS_INFO("left encoder : %i", delta_encoder[LEFT]);
		ROS_INFO("right encoder: %i", delta_encoder[RIGHT]);
		
		ROS_INFO("left");
		setMotorPower(left_motor, LEFT);
		ROS_INFO("right");
		setMotorPower(right_motor, RIGHT);
		clipPowerValues(left_motor, right_motor);
		
		pub_left.publish(left_motor);
		pub_right.publish(right_motor);
		rate.sleep();
		ROS_INFO("------------------------------");
	}
	
	return 0;
}
