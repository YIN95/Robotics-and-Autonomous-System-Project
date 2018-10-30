#include "ros/ros.h"
#include <math.h>
#include <vector>
#include <std_msgs/Float32.h>
#include <geometry_msgs/Twist.h>
#include "phidgets/motor_encoder.h"

class MotorController{
public: /* ros */
	ros::NodeHandle nh;
	/* Subscribers */
	ros::Subscriber sub_velocity;
	ros::Subscriber sub_encoder_left;
	ros::Subscriber sub_encoder_right;
	/* Publishers */
	ros::Publisher pub_left;
	ros::Publisher pub_right;
	ros::Publisher pub_velocity;

public: /* Functions */
	/* Constructor Functions */
	MotorController(int control_frequency_);
	//~MotorController();

	/* Functions */
	void velocityCallback(const geometry_msgs::Twist::ConstPtr &msg);
	void encoderCallbackLeft(const phidgets::motor_encoder::ConstPtr &msg);
	void encoderCallbackRight(const phidgets::motor_encoder::ConstPtr &msg);

	void updateEstimatedSpeed();
	void updateDesiredSpeed();

	void setMotorPowers();
	void clipPowerValues();
	void PID();
	void publishEstimatedSpeed();

private:
	/* Variables */
	const static int LEFT = 0;	// LEFT SIDE
	const static int RIGHT = 1;	// RIGHT SIDE
	const static double base = 0.19;
	const static double wheel_radius = 0.05;
	// Best empirical value of the CPR is 875! Could be tuned more
	const static double ticks_per_rev = 875; // 898 or 979.62
	const static double clip_value = 50;
    int control_frequency;
	
	double v_threshold;
	double w_threshold;

    double dt;
	double v_robot_desired;
	double w_robot_desired;

	double v_robot_estimated;
	double w_robot_estimated;

	std_msgs::Float32 left_motor;
	std_msgs::Float32 right_motor;

	geometry_msgs::Twist velocity_estimated;

    /* Variables for PI controller*/
	std::vector<double> alpha;	// P gain
	std::vector<double> beta;	// I gain
	std::vector<double> gamma;	// D gain
	std::vector<double> int_error;
	std::vector<double> prev_error;
	std::vector<double> w_desired;
	std::vector<double> w_des_prev;
	std::vector<double> w_estimate;
	std::vector<int> delta_encoder;
};
