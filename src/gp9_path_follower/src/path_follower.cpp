#include <ros/ros.h>
#include <tf/transform_broadcaster.h>
#include <vector>
#include <math.h>
#include <visualization_msgs/Marker.h>
#include <geometry_msgs/Twist.h>
#include <geometry_msgs/Pose2D.h>
#include <geometry_msgs/Quaternion.h>
#include <sensor_msgs/LaserScan.h>

/* 
TODO list 

1. Debug abort method when seeing obstacles with lidar.  
2. Add support for stopping when seeing batteries, for this we need camera topic.
*/

class StraightLines{

public:

	ros::NodeHandle nh;
	ros::Subscriber sub_desired_pose;
	ros::Subscriber sub_odom;
	ros::Subscriber sub_lidar;

	ros::Publisher pub_desired_pose;
	ros::Publisher pub_velocity;

	StraightLines(int control_frequency_, double min_distance_to_obstacle_, int every_lidar_value_) {
		nh = ros::NodeHandle("~");

		sub_desired_pose = nh.subscribe<geometry_msgs::Pose2D>("/desired_pose", 1, &StraightLines::desiredPoseCallBack, this);
		sub_odom = nh.subscribe<geometry_msgs::Pose2D>("/pose", 1, &StraightLines::poseCallBack, this);
		sub_lidar = nh.subscribe<sensor_msgs::LaserScan>("/scan", 1, &StraightLines::lidarCallBack, this);

		pub_desired_pose = nh.advertise<visualization_msgs::Marker>("/visualization_marker", 1);
		pub_velocity = nh.advertise<geometry_msgs::Twist>("/motor_controller/velocity", 1);

		point_flag = false;
		stopped = false;
		control_frequency = control_frequency_;
		dt = 1 / control_frequency;

		laser_distances = std::vector<double>(360, 0);
		min_distance_to_obstacle = min_distance_to_obstacle_;
		every_lidar_value = every_lidar_value_;

		pose = std::vector<double>(3, 0);
		pose_desired = std::vector<double>(3, 0);

		error_angle = M_PI;
		error_distance = 100;
		error_previous_angle = std::vector<double>(2, 0);
		error_previous_dist = 0;

		error_int_angle = std::vector<double>(2, 0);

		// Gains
		gains_rotation = std::vector<double>(3, 0);
		gains_translation = std::vector<double>(3, 0);

		// ROTATION
		gains_rotation[0] = 4.5;	//3 more or less fine (value of yesterday)
		gains_rotation[1] = 0;	//0.5 more or less fine (value of yesterday)
		gains_rotation[2] = 0;

		// TRANSLATION
		gains_translation[0] = 1;
		gains_translation[1] = 0.01;
		gains_translation[2] = 0.1;
		
	}

	void poseCallBack(const geometry_msgs::Pose2D::ConstPtr& pose_msg) {
		pose[0] = pose_msg->x;
		pose[1] = pose_msg->y;
		pose[2] = pose_msg->theta;
		ROS_INFO("pose x: %f", pose[0]);
		ROS_INFO("pose y: %f", pose[1]);
		ROS_INFO("pose theta: %f", pose[2]);
	}

	void desiredPoseCallBack(const geometry_msgs::Pose2D::ConstPtr& desired_pose_msg) {
		pose_desired[0] = desired_pose_msg->x;
		pose_desired[1] = desired_pose_msg->y;
		pose_desired[2] = desired_pose_msg->theta;
		//ROS_INFO("pose_desired x: %f", pose_desired[0]);
		//ROS_INFO("pose_desired y: %f", pose_desired[1]);
		show_desired_pose();
	}

	void lidarCallBack(const sensor_msgs::LaserScan::ConstPtr& lidar_msg) {
		for (int i = 0; i < 360; i++) {
			laser_distances[i] = lidar_msg->ranges[i];
		}
	}

	////////////////////////////////// CHANGE TO RETURN TRUE INSIDE LOOP ////////////////////
	bool obstacleCheck() {
		double lidar_dist;
		for (int i = 0; i < 360; i += every_lidar_value) {
			lidar_dist = laser_distances[i];
			if (lidar_dist < min_distance_to_obstacle) {
				return false;
			}
		}
		return false;
	}

	double radToDeg(double radians) {
		return radians * 180 / M_PI;
	}


	void moveToPoint() {
		double degrees = 15;
		double angle_threshold = degrees * M_PI / 180;
		double distance_threshold = 0.05;

		double desired_angle;
		double delta_x = pose_desired[0] - pose[0];
		double delta_y = pose_desired[1] - pose[1];
		double distance = sqrt(pow(delta_x, 2) + pow(delta_y, 2));

		ROS_INFO("distance: %f", distance);

		if (distance < distance_threshold) {
			desired_angle = 0;
		}

		else {
			desired_angle = atan2(delta_y, delta_x); // aim to goal point
		}

		error_angle = desired_angle - pose[2];

		//ROS_INFO("BEFORE IF STATEMENTS");
		ROS_INFO("error angle: %f", radToDeg(error_angle));
		//ROS_INFO("desired angle: %f", radToDeg(desired_angle));

		double error_angle_abs = fabs(error_angle);

		// ROS_INFO("error angle: %f", radToDeg(error_angle));
		//ROS_INFO("error angle abs: %f", radToDeg(error_angle_abs));
		//ROS_INFO("error dist: %f", distance);
		//ROS_INFO("GOING INTO IF STATEMENTS");

		if ((error_angle_abs > angle_threshold) && (distance > distance_threshold)) {
			ROS_INFO("first turn");
			PID_rotation(error_angle, 0);
		}

		else if (distance > distance_threshold) {
			ROS_INFO("translation");
			PID_translation(distance);
		}

		else {
			point_flag = true;
			velocity_msg.linear.x = 0;
			velocity_msg.angular.z = 0;
		}
	}


	void turnOnSpot() {

		if (point_flag) {
			ROS_INFO("second turn");
			double desired_angle = pose_desired[2];
			error_angle = desired_angle - pose[2];
			ROS_INFO("error angle: %f", radToDeg(error_angle));
			PID_rotation(error_angle, 1);
			point_flag = false;
		}
	}


	void PID_rotation(double error_angle, int rotation_number) {

		double derror_angle = (error_angle - error_previous_angle[rotation_number]) * control_frequency;
		error_int_angle[rotation_number] = error_int_angle[rotation_number] + error_angle;
		error_previous_angle[rotation_number] = error_angle;

		double P = gains_rotation[0] * error_angle;
		double I = gains_rotation[1] * error_int_angle[rotation_number];
		double D = gains_rotation[2] * derror_angle;

		ROS_INFO("w P part: %f", P);
		ROS_INFO("w D part: %f", D);
		ROS_INFO("w I part: %f", I);

		double w = P + I + D;

		velocity_msg.linear.x = 0;
		velocity_msg.angular.z = w;
	}

	void PID_translation(double distance) {

		error_distance = distance; // desired distance is 0
		double derror_distance = (error_distance - error_previous_dist) * control_frequency;
		error_int_dist += error_distance;
		error_previous_dist = error_distance;

		double P = gains_translation[0] * error_distance;
		double I = gains_translation[1] * error_int_dist;
		double D = gains_translation[2] * derror_distance;
		
		double v = P + I + D;

		ROS_INFO("v P part: %f", P);
		ROS_INFO("v D part: %f", D);
		ROS_INFO("v I part: %f", I);

		velocity_msg.linear.x = v;
		velocity_msg.angular.z = 0;
	}
  
	void stop() {
		velocity_msg.linear.x = 0;
		velocity_msg.angular.z = 0;
		stopped = true;
	}


	void move() {

		// double delta_x = pose_desired[0] - pose[0];
		// double delta_y = pose_desired[1] - pose[1];
		// error_distance = sqrt(pow(delta_x, 2) + pow(delta_y, 2));

		bool obstacle_in_the_way = obstacleCheck();
		if (obstacle_in_the_way) {
			ROS_INFO("obstacle in the way");
			stop();
		}

		else {
			moveToPoint();
			turnOnSpot();
		}

		ROS_INFO("v : %f", velocity_msg.linear.x);
		ROS_INFO("w : %f", velocity_msg.angular.z);


		ROS_INFO("publishing");
		pub_velocity.publish(velocity_msg);
		ROS_INFO("=============================================");
	}

	bool has_stopped() {
		return stopped;
	}

	void show_desired_pose() {

		visualization_msgs::Marker marker;
		geometry_msgs::Quaternion odom_quat = tf::createQuaternionMsgFromYaw(pose_desired[2]);
		
		marker.header.frame_id = "map";
		marker.header.stamp = ros::Time();
		marker.ns = "my_namespace";
		marker.id = 0;
		marker.type = visualization_msgs::Marker::ARROW;
		marker.action = visualization_msgs::Marker::ADD;
		marker.pose.position.x = pose_desired[0];
		marker.pose.position.y = pose_desired[1];
		marker.pose.position.z = 0;
		marker.pose.orientation = odom_quat;
		marker.scale.x = 0.5;
		marker.scale.y = 0.1;
		marker.scale.z = 0.1;
		marker.color.a = 0.5; // Don't forget to set the alpha!
		marker.color.r = 1.0;
		marker.color.g = 0;
		marker.color.b = 1.0;
		pub_desired_pose.publish(marker);
	}

private:
	bool point_flag;
	bool stopped;
	int control_frequency;
	double dt;
	geometry_msgs::Twist velocity_msg;

	std::vector<double> laser_distances;
	double min_distance_to_obstacle;
	int every_lidar_value;

	double error_angle;
	
	double error_distance;
	double error_previous_dist;
	
	double error_int_dist;
	std::vector<double> pose;
	std::vector<double> pose_desired;
	
	std::vector<double> error_int_angle;
	std::vector<double> error_previous_angle;
	
	std::vector<double> gains_rotation;
	std::vector<double> gains_translation;

};

int main(int argc, char** argv) {

	int control_frequency = 10;
	int check_every_laser = 4;
	double min_distance_to_obstacles = 0.30;

	ros::init(argc, argv, "path_follower");
	StraightLines sl(control_frequency, min_distance_to_obstacles, check_every_laser);
	ros::Rate rate(control_frequency);

	while (sl.nh.ok()) {
		ros::spinOnce();
		if (!sl.has_stopped()) {
			sl.move();
		}

		rate.sleep();
	}

	return 0;
}
