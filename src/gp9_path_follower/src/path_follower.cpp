#include <ros/ros.h>
#include <tf/transform_broadcaster.h>
#include <vector>
#include <math.h>
#include <visualization_msgs/Marker.h>
#include <std_msgs/Bool.h>
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

    ros::Publisher pub_close_enough;
	ros::Publisher pub_desired_pose;
	ros::Publisher pub_velocity;

	StraightLines(int control_frequency_, double min_distance_to_obstacle_, int every_lidar_value_) {
		nh = ros::NodeHandle("~");

		sub_desired_pose = nh.subscribe<geometry_msgs::Pose2D>("/desired_pose", 1, &StraightLines::desiredPoseCallBack, this);
		sub_odom = nh.subscribe<geometry_msgs::Pose2D>("/pose", 1, &StraightLines::poseCallBack, this);
		sub_lidar = nh.subscribe<sensor_msgs::LaserScan>("/scan", 1, &StraightLines::lidarCallBack, this);

		pub_desired_pose = nh.advertise<visualization_msgs::Marker>("/visualization_marker", 1);
		pub_velocity = nh.advertise<geometry_msgs::Twist>("/motor_controller/velocity", 1);
		pub_close_enough = nh.advertise<std_msgs::Bool>("/close_enough", 1);


		point_flag = false;
		stopped = false;
		same_point = false;
		other_angle = false;
		turn_flag = false;
		control_frequency = control_frequency_;
		dt = 1 / control_frequency;

		laser_distances = std::vector<double>(360, 0);
		min_distance_to_obstacle = min_distance_to_obstacle_;
		every_lidar_value = every_lidar_value_;

		pose = std::vector<double>(3, 0);
        pose_desired = std::vector<double>(3, 0);
        pose_previous = std::vector<double>(3, 0);
        last_checkpoint = std::vector<double>(2, 0);

		// HAS TO BE THE SAME AS FOR STARTING POSITION IN ODOMETRY! TAKE FROM PARAM SERVER
		pose_desired[0] = 0.225;
		pose_desired[1] = 0.225;
		pose_desired[2] = M_PI / 2;

		pose_previous[0] = 0.225;
		pose_previous[1] = 0.225;
		pose_previous[2] = M_PI / 2;

        last_checkpoint[0] = 0.225;
        last_checkpoint[1] = 0.225;

		degrees = 5;
		angle_threshold = degrees * M_PI / 180;

       	        distance = 1000;
       		distance_threshold = 0.01;
		desired_angle = 0;

		error_angle = M_PI;

		error_int_angle = 0;
		error_previous_angle = 0;
		error_int_angle_translation = 0;
		error_previous_angle_translation = 0;

		// Gains
		gains_rotation = std::vector<double>(3, 0);
		gains_translation = std::vector<double>(3, 0);

		// ROTATION ONLY
		gains_rotation[0] = 10.0;	//3 more or less fine (value of yesterday)
		gains_rotation[1] = 0.01;	//0.5 more or less fine (value of yesterday)
		gains_rotation[2] = 0;

		// TRANSLATION+ROTATION
		
		// Rotation, these gains are good!
		gains_translation[0] = 20.0;
		gains_translation[1] = 0.01;
		gains_translation[2] = 0;
		
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

	void updateErrors(){
		double dx = pose_desired[0] - pose[0];
		double dy = pose_desired[1] - pose[1];
		distance = sqrt(pow(dx, 2) + pow(dy, 2));
		desired_angle = atan2(dy, dx); // aim to goal point
        error_angle = getErrorAngle(desired_angle);
	}

	void moveToPoint() {
		
		if (!turn_flag) {

			updateErrors();
			ROS_INFO("distance error: %f", distance);

			if ((fabs(error_angle) > angle_threshold) && (distance > distance_threshold) ) {
				ROS_INFO("first turn");
				PID_rotation();
			}

			else if (distance > distance_threshold) {
				ROS_INFO("translation");
				PID_translation(distance);
			}

			else {
				closeEnough();
			}
		}
	}

	void PID_rotation() {

		double derror_angle = (error_angle - error_previous_angle) * control_frequency;
		error_int_angle = error_int_angle + error_angle;
		error_previous_angle = error_angle;

		ROS_INFO("error angle : %f", error_angle);

		double P = gains_rotation[0] * error_angle;
		double I = gains_rotation[1] * error_int_angle;
		double D = gains_rotation[2] * derror_angle;

		ROS_INFO("w P part: %f", P);
		ROS_INFO("w D part: %f", D);
		ROS_INFO("w I part: %f", I);

		double w = P + I + D;
		velocity_msg.linear.x = 0;
		velocity_msg.angular.z = w;
	}

	void PID_translation(double distance) {

		double derror_angle = (error_angle - error_previous_angle_translation) * control_frequency;
		error_int_angle_translation = error_int_angle_translation + error_angle;
		error_previous_angle_translation = error_angle;

		double PW = gains_translation[0] * error_angle;
		double IW = gains_translation[1] * error_int_angle_translation;
		double DW = gains_translation[2] * derror_angle;

		double w = PW + IW + DW;

		double v;
		double v_max = 0.50;
		double v_min = 0.2;
		double slow_dist = 0.10;

		double dx = last_checkpoint[0] - pose[0];
		double dy = last_checkpoint[1] - pose[1];
		double distance_travelled = sqrt(pow(dx, 2) + pow(dy, 2));

		ROS_INFO("dist travelled: %f", distance_travelled);

		bool just_started = distance > slow_dist;
		bool short_drive = (distance < slow_dist && distance_travelled < slow_dist);

        // To start slowly. v: v_min --> v_max, distance_travelled: 0 --> slow_dist.
		if (just_started) { // IS THE IF STATEMENT CORRECT?
			ROS_INFO("Slow start");
		    v = v_min + (v_max - v_min) * (distance_travelled / slow_dist);
		}

		// When just driving a short distance, drive slowly
		else if (short_drive) {
			ROS_INFO("Short drive");
		    v = v_min;
		}

		// To slow down in the end. v: v_max --> v_min, distance: slow_dist --> 0.
		else {
			ROS_INFO("Slowing down");
		    v = v_max - (v_max - v_min) * ((slow_dist - distance) / slow_dist);
		}

		velocity_msg.linear.x = v;
		velocity_msg.angular.z = w;
	}

	void resetErrors() {
		error_previous_angle = 0;
		error_int_angle = 0;
		error_previous_angle_translation = 0;
		error_int_angle_translation = 0;
		last_checkpoint[0] = pose[0];
	    last_checkpoint[1] = pose[1];
	}

	void closeEnough() {
		velocity_msg.linear.x = 0;
		velocity_msg.angular.z = 0;
		resetErrors();
        close_enough_msg.data = true;
		ROS_INFO("Close Enough");
		
	}

	void stop() {
		velocity_msg.linear.x = 0;
		velocity_msg.angular.z = 0;
		stopped = true;
        ROS_INFO("Has Stopped");
	}

	void move() {

		bool obstacle_in_the_way = obstacleCheck();
		if (obstacle_in_the_way) {
			ROS_INFO("obstacle in the way");
			stop();
		}

		else {
			moveToPoint();
		}

		ROS_INFO("last checkpoint: %f, %f", last_checkpoint[0], last_checkpoint[1]);
		ROS_INFO("v : %f", velocity_msg.linear.x);
		ROS_INFO("w : %f", velocity_msg.angular.z);
		ROS_INFO("publishing");

		pub_velocity.publish(velocity_msg);
		pub_close_enough.publish(close_enough_msg);
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

	void turnOnSpot() {
	    close_enough_msg.data = false;
		ROS_INFO("same point:  %d", same_point);
		ROS_INFO("other angle: %d", other_angle);

		if (same_point && other_angle) {
			turn_flag = true;
			resetErrors();
		}

		ROS_INFO("turn flag: %d", turn_flag);

		if (turn_flag) {
            desired_angle = pose_desired[2];
            error_angle = getErrorAngle(desired_angle);

            if (fabs(error_angle) > angle_threshold) {
                PID_rotation();
            }

            else {
                ROS_INFO("turning off turn flag");
                turn_flag = false;
            }

        }
		
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


private:
    
	bool turn_flag;
	bool point_flag;
	bool stopped;
	bool same_point;
	bool other_angle;
	int control_frequency;
	double dt;

	double degrees;
	double angle_threshold;
    double distance;
    double distance_threshold;
	double desired_angle;
	
	geometry_msgs::Twist velocity_msg;
	std_msgs::Bool close_enough_msg;

	std::vector<double> laser_distances;
	double min_distance_to_obstacle;
	int every_lidar_value;

    std::vector<double> last_checkpoint;
	std::vector<double> pose;
	std::vector<double> pose_previous;
	std::vector<double> pose_desired;

    double error_angle;

	double error_int_angle;
	double error_previous_angle;

	double error_int_angle_translation;
	double error_previous_angle_translation;
	
	std::vector<double> gains_rotation;
	std::vector<double> gains_translation;

};

int main(int argc, char** argv) {

	int control_frequency = 125;
	int check_every_laser = 4;
	double min_distance_to_obstacles = 0.30;

	ros::init(argc, argv, "path_follower");
	StraightLines sl(control_frequency, min_distance_to_obstacles, check_every_laser);
	ros::Rate rate(control_frequency);

	while (sl.nh.ok()) {
		ros::spinOnce();
		if (!sl.has_stopped()) {
			sl.turnOnSpot();
			sl.move();
		}

		rate.sleep();
	}

	return 0;
}
