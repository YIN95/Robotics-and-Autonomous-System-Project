#include <ros/ros.h>
#include <tf/transform_broadcaster.h>
#include <vector>
#include <math.h>
#include <visualization_msgs/Marker.h>
#include <std_msgs/Bool.h>
#include <std_msgs/Int32.h>
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
	ros::Subscriber sub_brain;
	ros::Subscriber sub_goal;

    ros::Publisher pub_close_enough;
	ros::Publisher pub_desired_pose;
	ros::Publisher pub_velocity;
	ros::Publisher pub_has_reached_goal;
	ros::Publisher pub_emergency_break;

	StraightLines(int control_frequency_, double min_distance_to_obstacle_, int every_lidar_value_) {
		nh = ros::NodeHandle("~");

		sub_odom = nh.subscribe<geometry_msgs::Pose2D>("/pose", 1, &StraightLines::poseCallBack, this);
		sub_lidar = nh.subscribe<sensor_msgs::LaserScan>("/scan", 1, &StraightLines::lidarCallBack, this);
		sub_desired_pose = nh.subscribe<geometry_msgs::Pose2D>("/desired_pose", 1, &StraightLines::desiredPoseCallBack, this);
		sub_brain = nh.subscribe<std_msgs::Int32>("/brain_state", 1, &StraightLines::brainStateCallBack, this);
		sub_goal = nh.subscribe<geometry_msgs::Pose2D>("/global_desired_pose", 10, &StraightLines::globalDesiredPoseCallBack, this);


		pub_close_enough = nh.advertise<std_msgs::Bool>("/close_enough", 1);
		pub_velocity = nh.advertise<geometry_msgs::Twist>("/motor_controller/velocity", 1);
		pub_desired_pose = nh.advertise<visualization_msgs::Marker>("/visualization_marker", 1);
		pub_has_reached_goal = nh.advertise<std_msgs::Bool>("/has_reached_goal", 1);
		pub_emergency_break = nh.advertise<std_msgs::Bool>("/emergency_break", 1);

		brain_state = -10;

		stopped = false;
		turn_flag = false;
		point_flag = false;
		same_point = false;
		other_angle = false;
		newInfoAboutGoal = false;
		previous_hasReachedGoal = true;

		control_frequency = control_frequency_;
		dt = 1.0 / control_frequency;

		every_lidar_value = every_lidar_value_;
		laser_distances = std::vector<double>(360, 10000);
		min_distance_to_obstacle = min_distance_to_obstacle_;

		pose = std::vector<double>(3, 0);
        pose_desired = std::vector<double>(3, 0);
		pose_goal = std::vector<double>(3, 0);
        pose_previous = std::vector<double>(3, 0);
        last_checkpoint = std::vector<double>(3, 0);

		// HAS TO BE THE SAME AS FOR STARTING POSITION IN ODOMETRY! TAKE FROM PARAM SERVER
		pose_desired[0] = 0.225;
		pose_desired[1] = 0.225;
		pose_desired[2] = M_PI / 2;

		pose_previous[0] = 0.225;
		pose_previous[1] = 0.225;
		pose_previous[2] = M_PI / 2;

        last_checkpoint[0] = 0.225;
        last_checkpoint[1] = 0.225;
        last_checkpoint[2] = M_PI / 2;

		pose_goal[0] = 20;
		pose_goal[1] = 20;
		pose_goal[2] = M_PI;

		degrees = 3;
		angle_threshold = degToRad(degrees);

		distance = 1000;
		desired_angle = 0;
		distance_threshold = 0.005;

		error_angle = M_PI;

		error_int_angle_translation = 0;
		error_previous_angle_translation = 0;

		gains_translation = std::vector<double>(3, 0);

		// TRANSLATION+ROTATION
		// Rotation, these gains are good!
		gains_translation[0] = 20.0;
		gains_translation[1] = 0.01;
		gains_translation[2] = 0;

		close_enough_msg.data = false;
		has_reached_goal_msg.data = false;
		emergency_break_msg.data = false;
		

		
	}

	void brainStateCallBack(const std_msgs::Int32::ConstPtr& brain_msg) {
		brain_state = brain_msg->data;
		if (brain_state == 7){ //The brain has solved the emergency break
			stopped = false;
		}
	}

	void lidarCallBack(const sensor_msgs::LaserScan::ConstPtr& lidar_msg) {
		for (int deg = 0; deg < 360; deg++) {
			double r = lidar_msg->ranges[deg];
			double lidar_to_robot_center = 0.06;
			std::vector<double> r_shifted(2, 0);
			r_shifted[0] = r * cos(M_PI + deg) - lidar_to_robot_center;
			r_shifted[1] = r * sin(M_PI + deg);

			laser_distances[deg] = sqrt(pow(r_shifted[0], 2) + pow(r_shifted[1], 2));
		}
	}

	void poseCallBack(const geometry_msgs::Pose2D::ConstPtr& pose_msg) {
		pose[0] = pose_msg->x;
		pose[1] = pose_msg->y;
		pose[2] = pose_msg->theta;
	}

	void desiredPoseCallBack(const geometry_msgs::Pose2D::ConstPtr& desired_pose_msg) {
		pose_desired[0] = desired_pose_msg->x;
		pose_desired[1] = desired_pose_msg->y;
		pose_desired[2] = desired_pose_msg->theta;
		bool x_close = fabs(pose_previous[0] - pose_desired[0]) < 1e-6;
		bool y_close = fabs(pose_previous[1] - pose_desired[1]) < 1e-6;
		same_point = (x_close && y_close);
		bool angle_close = fabs(pose_desired[2] - pose_previous[2]) < 1e-6;
		other_angle = !angle_close;

		pose_previous[0] = pose_desired[0];
		pose_previous[1] = pose_desired[1];
		pose_previous[2] = pose_desired[2];

		ROS_INFO("Local Pose Callback");

		show_desired_pose();
	}

	void globalDesiredPoseCallBack(const geometry_msgs::Pose2D::ConstPtr& global_desired_pose_msg) {
		pose_goal[0] = global_desired_pose_msg->x;
		pose_goal[1] = global_desired_pose_msg->y;
		pose_goal[2] = global_desired_pose_msg->theta;

		ROS_INFO("Global Pose Callback");
		ROS_INFO("Point: %f %f %f", pose_goal[0], pose_goal[1], pose_goal[2]);
		newInfoAboutGoal = true;
		has_reached_goal_msg.data = false;
		previous_hasReachedGoal = has_reached_goal_msg.data;

		// bool x_close = fabs(pose_previous[0] - pose_desired[0]) < 1e-6;
		// bool y_close = fabs(pose_previous[1] - pose_desired[1]) < 1e-6;
		// same_point = (x_close && y_close);
		// bool angle_close = fabs(pose_desired[2] - pose_previous[2]) < 1e-6;
		// other_angle = !angle_close;

	}

	void turnOnSpot() {
		close_enough_msg.data = false;
		has_reached_goal_msg.data = false;
		if (same_point && other_angle) {
			turn_flag = true;
			resetErrors();
		}

		if (turn_flag) {
			desired_angle = pose_desired[2];
			error_angle = getErrorAngle(desired_angle);

			if (fabs(error_angle) > angle_threshold) {
				rotate();
			}

			else {
				turn_flag = false;
			}

		}

	}

	void move() {

		bool obstacle_in_the_way = obstacleCheck();
		if (obstacle_in_the_way) {
			//ROS_INFO("obstacle in the way");
			stop();
		}

		else {
			moveToPoint();
		}

		// ROS_INFO("last checkpoint: %f, %f, %f", last_checkpoint[0], last_checkpoint[1], last_checkpoint[2]);
		// ROS_INFO("v : %f", velocity_msg.linear.x);
		// ROS_INFO("w : %f", velocity_msg.angular.z);
		// ROS_INFO("close Enough: %d", close_enough_msg.data);

		pub_velocity.publish(velocity_msg);
		pub_close_enough.publish(close_enough_msg);
		ROS_INFO("New info? %d", newInfoAboutGoal);

		if(newInfoAboutGoal){
		 	pub_has_reached_goal.publish(has_reached_goal_msg);
	 	}
		newInfoAboutGoal = false;
		
		// ROS_INFO("=============================================");
	}

	void moveToPoint() {

		if (!turn_flag) {

			updateErrors();
			// ROS_INFO("distance error: %f", distance);

			if ((fabs(error_angle) > angle_threshold) && (distance > distance_threshold) ) {
				// ROS_INFO("first turn");
				rotate();
			}

			else if (distance > distance_threshold) {
				// ROS_INFO("translation");
				translate(distance);
			}

			else {
				closeEnough();
				hasReachedGoal();
			}
		}
	}

	void rotate() {

		//ROS_INFO("IN ROTATE!!!!!!!!!!!!!!!");
		
		double sign = error_angle / fabs(error_angle);

		double w;
		double w_max = 2.00;
		double w_min = 1.6;
		double slow_degrees = 15.0; // slowing down distance
		double slow_rads = degToRad(slow_degrees);

		double angle_travelled = fabs(last_checkpoint[2] - pose[2]);


        if (angle_travelled > M_PI) {
            angle_travelled -= M_PI;
        }



		//ROS_INFO("angle travelled: %f", angle_travelled);

		bool just_started = fabs(error_angle) > slow_rads;
		bool short_drive = (fabs(error_angle) < slow_rads && angle_travelled < (slow_rads + angle_threshold));

		// To start slowly. w: w_min --> w_max, angle_travelled: 0 --> slow_rads.
		if (just_started) {
			//ROS_INFO("Slow start");
			w = sign * (w_min + (w_max - w_min) * (angle_travelled / slow_rads));
		}

			// When just driving a short distance, drive slowly
		else if (short_drive) {
			//ROS_INFO("Short drive");
			w = sign * w_min;
		}

			// To slow down in the end. w: w_max --> w_min, error_angle: slow_rads --> 0.
		else {
			//ROS_INFO("Slowing down");
			w = sign * (w_max - (w_max - w_min) * (((slow_rads + angle_threshold) - fabs(error_angle)) / (slow_rads + angle_threshold)));
		}

		//ROS_INFO("error angle : %f", error_angle);

		//ROS_INFO("w : %f", w);
		velocity_msg.linear.x = 0;
		velocity_msg.angular.z = sign * 1.2; // 1.2 is a okay value
	}

	void translate(double distance) {

		double derror_angle = (error_angle - error_previous_angle_translation) * control_frequency;
		error_int_angle_translation = error_int_angle_translation + error_angle;
		error_previous_angle_translation = error_angle;

		double PW = gains_translation[0] * error_angle;
		double IW = gains_translation[1] * error_int_angle_translation;
		double DW = gains_translation[2] * derror_angle;

		double w = PW + IW + DW;

		double v;
		double v_max = 0.35;
		double v_min = 0.2;
		double slow_dist = 0.15;

		double dx = last_checkpoint[0] - pose[0];
		double dy = last_checkpoint[1] - pose[1];
		double distance_travelled = sqrt(pow(dx, 2) + pow(dy, 2));

		// ROS_INFO("dist travelled: %f", distance_travelled);

		bool just_started = distance > slow_dist;
		bool short_drive = (distance < slow_dist && distance_travelled < slow_dist);

		// To start slowly. v: v_min --> v_max, distance_travelled: 0 --> slow_dist.
		if (just_started) { // IS THE IF STATEMENT CORRECT?
			// ROS_INFO("Slow start");
			v = v_min + (v_max - v_min) * (distance_travelled / slow_dist);
		}

			// When just driving a short distance, drive slowly
		else if (short_drive) {
			// ROS_INFO("Short drive");
			v = v_min;
		}

			// To slow down in the end. v: v_max --> v_min, distance: slow_dist --> 0.
		else {
			// ROS_INFO("Slowing down");
			v = v_max - (v_max - v_min) * ((slow_dist - distance) / slow_dist);
		}

		velocity_msg.linear.x = v;
		velocity_msg.angular.z = w;
	}

	bool obstacleCheck() {
		double lidar_dist;
		for (int deg = 135; deg < 225; deg += every_lidar_value) {
			lidar_dist = laser_distances[deg];
			if (lidar_dist < min_distance_to_obstacle) {
				return true;
			}
		}
		return false;
	}

	double radToDeg(double radians) {
		return radians * 180 / M_PI;
	}

	double degToRad(double degrees) {
		return degrees * M_PI / 180;
	}

	void updateErrors(){
		double dx = pose_desired[0] - pose[0];
		double dy = pose_desired[1] - pose[1];
		distance = sqrt(pow(dx, 2) + pow(dy, 2));
		desired_angle = atan2(dy, dx); // aim to goal point
        error_angle = getErrorAngle(desired_angle);
	}

	void resetErrors() {
		error_previous_angle_translation = 0;
		error_int_angle_translation = 0;
		last_checkpoint[0] = pose[0];
	    last_checkpoint[1] = pose[1];
	    last_checkpoint[2] = pose[2];
	}

	void closeEnough() {
		velocity_msg.linear.x = 0;
		velocity_msg.angular.z = 0;
		resetErrors();
        close_enough_msg.data = true;
		//ROS_INFO("Close Enough");

	}

	void hasReachedGoal() {
		double dist_to_goal = sqrt(pow(pose_goal[0] - pose[0], 2) + pow(pose_goal[1] - pose[1], 2));
		bool close_enough_to_goal = dist_to_goal < distance_threshold;

		if((pose_goal[0] == pose_desired[0]) && (pose_goal[1] == pose_desired[1]))
		// if (close_enough_to_goal)
		{
			has_reached_goal_msg.data = true;
			//pub_has_reached_goal.publish(has_reached_goal_msg); //ADDED
			ROS_INFO("hasReachedGoal");
		}

		if(has_reached_goal_msg.data != previous_hasReachedGoal){
			newInfoAboutGoal = true;
		}
		else{
			newInfoAboutGoal = false;
		}
		previous_hasReachedGoal = has_reached_goal_msg.data;

	}

	void stop() {
		velocity_msg.linear.x = 0;
		velocity_msg.angular.z = 0;
		stopped = true;
		emergency_break_msg.data = true;
		pub_emergency_break.publish(emergency_break_msg);
        ROS_INFO("Has Stopped");
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

	double getErrorAngle(double desired_angle) {
        error_angle = desired_angle - pose[2];
        if (error_angle <= -M_PI) {
            error_angle += 2*M_PI;
        }

        else if (error_angle > M_PI) {
            error_angle -= 2*M_PI;
        }

        return error_angle;
	}

	int getBrainState(){
		return brain_state;
	}

private:

	double dt;
	bool stopped;
	bool turn_flag;
	bool point_flag;
	bool same_point;
	bool other_angle;
	int control_frequency;
	int brain_state;
	bool newInfoAboutGoal;
	bool previous_hasReachedGoal;

	double degrees;
	double distance;
	double desired_angle;
	double angle_threshold;
	double distance_threshold;

	std_msgs::Bool close_enough_msg;
	std_msgs::Bool has_reached_goal_msg;
	std_msgs::Bool emergency_break_msg;
	geometry_msgs::Twist velocity_msg;

	int every_lidar_value;
	double min_distance_to_obstacle;
	std::vector<double> laser_distances;

	std::vector<double> pose;
	std::vector<double> pose_desired;
	std::vector<double> pose_previous;
	std::vector<double> pose_goal;
	std::vector<double> last_checkpoint;

    double error_angle;
	double error_int_angle_translation;
	double error_previous_angle_translation;

	std::vector<double> gains_translation;

};

int main(int argc, char** argv) {

	int control_frequency = 125;
	int check_every_laser = 2;
	double min_distance_to_obstacles = 0.16;

	ros::init(argc, argv, "path_follower");
	StraightLines sl(control_frequency, min_distance_to_obstacles, check_every_laser);
	ros::Rate rate(control_frequency);

	while (sl.nh.ok()) {
		ros::spinOnce();
		if (!sl.has_stopped()) {
			if(sl.getBrainState() == 1) {
				sl.turnOnSpot();
				sl.move();
			}

			rate.sleep();
		}
	}

	return 0;
}
