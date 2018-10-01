#include "ros/ros.h"
#include <math.h>
#include <vector>
#include <std_msgs/Float32.h>
#include <geometry_msgs/Twist.h>
#include "phidgets/motor_encoder.h"

class MotorController 
{
	public:
		
		ros::NodeHandle nh;
		
		// Subscribers
		ros::Subscriber sub_velocity;
		ros::Subscriber sub_encoder_left;
		ros::Subscriber sub_encoder_right;
	
		// Publishers
		ros::Publisher pub_left;
		ros::Publisher pub_right;
	
		// Constructor
		MotorController() {
			
			nh = ros::NodeHandle("~");
			
			sub_velocity = nh.subscribe<geometry_msgs::Twist>("/motor_controller/velocity", 1, &MotorController::velocityCallback, this);
			sub_encoder_left = nh.subscribe<phidgets::motor_encoder>("motor_left/encoder", 1, &MotorController::encoderCallbackLeft, this);
			sub_encoder_right = nh.subscribe<phidgets::motor_encoder>("motor_right/encoder", 1, &MotorController::encoderCallbackRight, this);
	
			pub_left = nh.advertise<std_msgs::Float32>("/motor_left/cmd_vel", 1);
			pub_right = nh.advertise<std_msgs::Float32>("/motor_right/cmd_vel", 1);
			
			int control_frequency = 10;
			dt = 1.0 / control_frequency;
			wheel_radius = 0.05;
			base = 0.19;
			ticks_per_rev = 360;
			LEFT = 0;
			RIGHT = 1;
			
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
		
		MotorController(int control_frequency_) {
		
			nh = ros::NodeHandle("~");
		
			sub_velocity = nh.subscribe<geometry_msgs::Twist>("/motor_controller/velocity", 1, &MotorController::velocityCallback, this);
			sub_encoder_left = nh.subscribe<phidgets::motor_encoder>("/motor_left/encoder", 1, &MotorController::encoderCallbackLeft, this);
			sub_encoder_right = nh.subscribe<phidgets::motor_encoder>("/motor_right/encoder", 1, &MotorController::encoderCallbackRight, this);
	
			pub_left = nh.advertise<std_msgs::Float32>("/motor_left/cmd_vel", 1);
			pub_right = nh.advertise<std_msgs::Float32>("/motor_right/cmd_vel", 1);
			
			control_frequency = control_frequency_;
			dt = 1.0 / control_frequency;
			wheel_radius = 0.05;
			base = 0.19;
			ticks_per_rev = 360;
			LEFT = 0;
			RIGHT = 1;
			
			alpha = std::vector<double>(2, 0);
			beta = std::vector<double>(2, 0);
			alpha[LEFT] = 20;
			alpha[RIGHT] = 20;
			beta[LEFT] = 5;
			beta[RIGHT] = 5;
			int_error = std::vector<double>(2, 0);
			w_desired =	std::vector<double>(2, 0);
			w_estimate = std::vector<double>(2, 0);
			delta_encoder =	std::vector<int>(2, 0);
	
		}
		
		void velocityCallback(const geometry_msgs::Twist::ConstPtr &msg) {
			v_robot_desired = msg->linear.x;
			w_robot_desired= msg->angular.z;
		}
		
		void encoderCallbackLeft(const phidgets::motor_encoder::ConstPtr &msg) {
			delta_encoder[LEFT] = msg->count_change;
		}
		
		void encoderCallbackRight(const phidgets::motor_encoder::ConstPtr &msg) {
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
		
		void setMotorPowers() {
			double error;
			int signal;
			
			error = w_desired[LEFT] - w_estimate[LEFT];
			int_error[LEFT] += error * dt;
			ROS_INFO("error: %f", error);
			signal = int (alpha[LEFT] * error + beta[LEFT] * int_error[LEFT]);
			left_motor.data = signal;
			
			
			error = w_desired[RIGHT] - w_estimate[RIGHT];
			int_error[LEFT] += error * dt;
			ROS_INFO("error: %f", error);
			signal = int (alpha[RIGHT] * error + beta[RIGHT] * int_error[RIGHT]);
			right_motor.data = signal;
		}

		void clipPowerValues() {
			// Also clip on negative values
			double left = std::abs(left_motor.data);
			double right = std::abs(right_motor.data);
			double largest = std::max(left, right);
			if (largest > 80) {
				ROS_INFO("Clipping stuff");
				double scale_factor = 80 / largest;
				left_motor.data *= scale_factor;
				right_motor.data *= scale_factor;
			}
			ROS_INFO("signal to left motor: %f", left_motor.data);
			ROS_INFO("signal to right motor: %f", right_motor.data);
		}
		
		void PI() {
			updateDesiredSpeed();
			updateEstimatedSpeed();
			setMotorPowers();
			clipPowerValues();
			pub_left.publish(left_motor);
			pub_right.publish(right_motor);
		}
	
	private:
		int control_frequency;
		double base;
		double wheel_radius;
		int ticks_per_rev;
		double dt;

		double v_robot_desired;
		double w_robot_desired;

		// First element represent the left side, use LEFT and RIGHT variables
		int LEFT;
		int RIGHT;
		
		std_msgs::Float32 left_motor;
		std_msgs::Float32 right_motor;

		std::vector<double> alpha;
		std::vector<double> beta;
		std::vector<double> int_error;
		std::vector<double> w_desired;
		std::vector<double> w_estimate;
		std::vector<int> delta_encoder;

};


int main(int argc, char** argv) 
{	
	const int control_frequency = 10;
	
	ros::init(argc, argv, "motor_publish");
	MotorController motorController(control_frequency);
	ros::Rate rate(control_frequency);
	
	while (ros::ok()) {
		ros::spinOnce();
		motorController.PI();
		rate.sleep();
		ROS_INFO("------------------------------");
	}
	return 0;
}
