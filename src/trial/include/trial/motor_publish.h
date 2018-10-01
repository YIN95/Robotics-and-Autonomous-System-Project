#include "ros/ros.h"
#include <math.h>
#include <vector>
#include <std_msgs/Float32.h>
#include <geometry_msgs/Twist.h>
#include "phidgets/motor_encoder.h"

class MotorController 
{
public: /* ros */
	ros::NodeHandle nh;
	/* Subscribers */
	ros::Subscriber sub_velocity;
	ros::Subscriber sub_encoder_left;
	ros::Subscriber sub_encoder_right;
	/* Publishers */
	ros::Publisher pub_left;
	ros::Publisher pub_right;

public: /* Functions */
	/* Constructor Functions */
	MotorController();
	MotorController(int control_frequency_);

	/* Functions */
	void velocityCallback(const geometry_msgs::Twist::ConstPtr &msg);
	void encoderCallbackLeft(const phidgets::motor_encoder::ConstPtr &msg);
	void encoderCallbackRight(const phidgets::motor_encoder::ConstPtr &msg);

	void updateEstimatedSpeed();
	void updateDesiredSpeed();

	void setMotorPowers();
	void clipPowerValues();
	void PI();

private:
	/* Variables */
	const static int LEFT = 0;	// LEFT SIDE
	const static int RIGHT = 1;	// RIGHT SIDE
	const static double base = 0.19;
	const static double wheel_radius = 0.05;
	const static int ticks_per_rev = 360;

	int control_frequency;
	double dt;
	
	double v_robot_desired;
	double w_robot_desired;

	std_msgs::Float32 left_motor;
	std_msgs::Float32 right_motor;

	std::vector<double> alpha;
	std::vector<double> beta;
	std::vector<double> int_error;
	std::vector<double> w_desired;
	std::vector<double> w_estimate;
	std::vector<int> delta_encoder;

};