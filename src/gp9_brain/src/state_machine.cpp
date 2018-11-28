#include "ros/ros.h"
#include <math.h>
#include <vector>
#include <std_msgs/Int32.h>
#include <std_msgs/Bool.h>
#include <geometry_msgs/Pose2D.h>
#include <geometry_msgs/Twist.h>
#include <iostream>
#include <fstream>
#include <string>

#define STATE_READY -1
#define STATE_NEXT_POSE 0
#define STATE_MOVING 1
#define STATE_GO_HOME 2
#define STATE_STOP 3
#define STATE_OPEN_GRIPPERS 4
#define STATE_ROTATING 5
#define STATE_CLOSE_GRIPPERS 6
#define STATE_MOVING_BACK 7

class StateMachine{

public: /* ros */
	ros::NodeHandle nh;
	
	ros::Publisher pub_currentState;
	ros::Publisher pub_globalDesiredPose;
	ros::Publisher pub_grab;
	ros::Publisher pub_velocity;

	ros::Subscriber sub_has_reached_goal;
	ros::Subscriber sub_has_reached_orientation;
	// ros::Subscriber sub_has_reached_grab;
	ros::Subscriber sub_emergency_break;

	ros::Time current_time;
    ros::Time arrival_time;


	StateMachine(){
		currentState = STATE_READY;
		hasReachedGoal = false;
		has_reached_orientation = false;
		// has_reached_grab = false;
		open_grippers = false;
		emergency_break = false;
		print_again = false;

		nextPose = 0;
		stop_seconds = 2;
		moving_back_seconds = 1;

		num_points = countObjects();
		ROS_INFO("num points: %d", num_points);

		global_pose = std::vector<double>(3, 0);
		previous_pose = std::vector<double>(3, 0);
		pose_sequence = std::vector<std::vector<double> >(num_points, std::vector<double>(4, 0));
		//The fourth value of the row could be:
		// 0 if there is nothing to grab;
		// 1 if it is an object pose.

		global_pose[0] = 0.225;
		global_pose[1] = 0.225;
		global_pose[2] = M_PI / 2;

		previous_pose[0] = 0.225;
		previous_pose[1] = 0.225;
		previous_pose[2] = M_PI / 2;

		pub_currentState = nh.advertise<std_msgs::Int32>("/brain_state", 1);
		pub_globalDesiredPose = nh.advertise<geometry_msgs::Pose2D>("/global_desired_pose", 1);
		pub_grab = nh.advertise<std_msgs::Int32>("/grab", 1);
		pub_velocity = nh.advertise<geometry_msgs::Twist>("/motor_controller/velocity", 1);


		sub_has_reached_goal = nh.subscribe<std_msgs::Bool>("/has_reached_goal", 1, &StateMachine::hasReachedGoalCallBack, this);
		sub_has_reached_orientation = nh.subscribe<std_msgs::Bool>("/has_reached_orientation", 1, &StateMachine::hasReachedOrientationCallBack, this);
		// sub_has_reached_grab = nh.subscribe<std_msgs::Bool>("/has_reached_grab_goal", 1, &StateMachine::hasReachedGrabCallBack, this);
		sub_emergency_break = nh.subscribe<std_msgs::Bool>("/emergency_break", 1, &StateMachine::emergencyBreakCallBack, this);
		
	};

	void hasReachedGoalCallBack(const std_msgs::Bool::ConstPtr& hasReachedGoal_msg) {
		hasReachedGoal = hasReachedGoal_msg->data;
		ROS_INFO("In hasReachedGoal Callback.");
	}

	void hasReachedOrientationCallBack(const std_msgs::Bool::ConstPtr& hasReachedOrientation_msg) {
		has_reached_orientation = hasReachedOrientation_msg->data;
		ROS_INFO("In hasReachedOrientation Callback.");
	}

	void emergencyBreakCallBack(const std_msgs::Bool::ConstPtr& emergencyBreak_msg) {
		emergency_break = emergencyBreak_msg->data;
		ROS_INFO("In emergencyBreak Callback.");
	}

	// void hasReachedGrabCallBack(const std_msgs::Bool::ConstPtr& hasReachedOGrab_msg) {
	// 	has_reached_grab = hasReachedOGrab_msg->data;
	// 	ROS_INFO("In hasReachedGrab Callback.");
	// }

	void run(){
		switch(currentState){
			case STATE_READY: //Needed to give time to the other nodes to listen to the topics
				readExplorePosition();  // for phase 1
				currentState = STATE_NEXT_POSE;
				break;

			case STATE_NEXT_POSE: //Take A Pose
				ROS_INFO("NEXT POSE");
				if(nextPose < num_points){
					ROS_INFO("Taking a new position");
					global_pose[0] = pose_sequence[nextPose][0];
					global_pose[1] = pose_sequence[nextPose][1];
					global_pose[2] = pose_sequence[nextPose][2];
					
					bool same_x = fabs(previous_pose[0] - global_pose[0]) < 1e-6;
					bool same_y = fabs(previous_pose[1] - global_pose[1]) < 1e-6;
					if (same_x && same_y){
						currentState = STATE_ROTATING;
					}
					else{
						currentState = STATE_MOVING;
					}
					open_grippers = false;
					nextPose += 1;
				}
				else{
					ROS_INFO("Taking a new position");
					currentState = STATE_GO_HOME;
				}
				break;

			case STATE_MOVING:
				ROS_INFO("MOVING");
				if(hasReachedGoal){
					currentState = STATE_STOP;
					hasReachedGoal = false;
					arrival_time = ros::Time::now();
				}
				if(emergency_break){
					currentState = STATE_MOVING_BACK;
					emergency_break = false;
					arrival_time = ros::Time::now();
				}
				if ((!open_grippers) && (fabs(pose_sequence[nextPose-1][3]-1) < 1e-6)){
						objectPosition();
						open_grippers = true;
						currentState = STATE_OPEN_GRIPPERS;
				}
				break;

			case STATE_GO_HOME:	//Go Home
				ROS_INFO("GO HOME");
				global_pose[0] = 0.225;
				global_pose[1] = 0.225;
				global_pose[2] = 0.0;
				currentState = STATE_MOVING;
				break;

			case STATE_ROTATING:
				ROS_INFO("ROTATING");
				if(has_reached_orientation){
					currentState = STATE_STOP;
					has_reached_orientation = false;
					arrival_time = ros::Time::now();
				}
				if ((!open_grippers) && (fabs(pose_sequence[nextPose-1][3]-1) < 1e-6)){
						objectPosition();
						open_grippers = true;
						currentState = STATE_OPEN_GRIPPERS;
				}
				break;

			case STATE_STOP:	//Stop
				ROS_INFO("STOP");

				current_time = ros::Time::now();
				if ((current_time - arrival_time).toSec() > stop_seconds){
					if ((open_grippers) && (fabs(pose_sequence[nextPose-1][3]-1) < 1e-6)){
						currentState = STATE_CLOSE_GRIPPERS;
					}
					else{
						currentState = STATE_NEXT_POSE;
					}
					
				}
				break;

			case STATE_MOVING_BACK:	//Stop
				ROS_INFO("MOVING BACK");

				current_time = ros::Time::now();
				if ((current_time - arrival_time).toSec() > moving_back_seconds){
					print_again = true;
					velocity_msg.linear.x = 0;
            		velocity_msg.angular.z = 0; // 1.2 is a okay value
            		pub_velocity.publish(velocity_msg);
					currentState = STATE_MOVING;
				}
				else{
					velocity_msg.linear.x = -0.2;
            		velocity_msg.angular.z = 0.2; // 1.2 is a okay value
            		pub_velocity.publish(velocity_msg);
				}
				break;

			case STATE_OPEN_GRIPPERS:
				ROS_INFO("OPEN GRIPPERS");
				// if(has_reached_grab){
				// 	currentState = STATE_STOP;
				// 	has_reached_grab = false;
				// }
        		msg.data = 1;
        		pub_grab.publish(msg);
				currentState = STATE_MOVING;
				break;
			
			case STATE_CLOSE_GRIPPERS:
				ROS_INFO("CLOSE GRIPPERS");
				ROS_INFO("======================================================");
				// if(has_reached_grab){
				// 	currentState = STATE_STOP;
				// 	has_reached_grab = false;
				// }
				msg.data = 0;
            	pub_grab.publish(msg);
				currentState = STATE_GO_HOME;
        		
				break;
		}
		
	}

	void publishNewPose(){
		// ROS_INFO("Global Desired Pose: \t%f, \t%f, \t%f", global_pose[0], global_pose[1], global_pose[2]);
		// ROS_INFO("Previous Pose: \t%f, \t%f, \t%f", previous_pose[0], previous_pose[1], previous_pose[2]);
	
		bool same_x = fabs(previous_pose[0] - global_pose[0]) < 1e-6;;
		bool same_y = fabs(previous_pose[1] - global_pose[1]) < 1e-6;;
		bool same_angle = fabs(previous_pose[2] - global_pose[2]) < 1e-6;
		bool same_point = (same_x && same_y && same_angle);

		if((!same_point)||(print_again)){
			global_desired_pose.x = global_pose[0];
			global_desired_pose.y = global_pose[1];
			global_desired_pose.theta = global_pose[2];
			pub_globalDesiredPose.publish(global_desired_pose);
			previous_pose[0] = global_pose[0];
			previous_pose[1] = global_pose[1];
			previous_pose[2] = global_pose[2];
			print_again = false;
		}
		ROS_INFO("Has Reached Goal? %d", hasReachedGoal);
		ROS_INFO("Has Reached Orientation? %d", has_reached_orientation);
		ROS_INFO("---------------------------------------------------------------------------------");
	}

	int getCurrentState(){
		return currentState;
	}

	void objectPosition(){
		double distance_x;
		double distance_y;
		distance_x = 0.4 * cos(global_pose[2]);
		distance_y = 0.4 * sin(global_pose[2]);
		global_pose[0] += distance_x;
		global_pose[1] += distance_y;
	}

	int countObjects(){
        std::fstream fin("/home/ras19/catkin_ws/src/gp9_path_planning/scripts/ShortestPath.txt");
        int num_points = 0;
		if (fin){
            double x, y;
            while(fin>>x>>y) {
                num_points++;
            }
        }
        return num_points;
    }

	void readExplorePosition(){	// read the position we need to explore for phase 1
		std::fstream fin("/home/ras19/catkin_ws/src/gp9_path_planning/scripts/ShortestPath.txt");
		int num_exploration_angles = 12;
		ROS_INFO("In reading file");
		if (fin){
			double x, y;
			unsigned point_count = 0;
			while(fin>>x>>y){
				
				pose_sequence[point_count][0] = x;
				pose_sequence[point_count][1] = y;
				pose_sequence[point_count][2] = 0;
				pose_sequence[point_count][3] = 0;

				// for (int i = 1; i < 4; i++) {
				// 	double angle = (1 + i) * (M_PI / 2);
				// 	if (angle > 2 * M_PI) {
				// 		angle -= 2 * M_PI;
				// 	}
				// 	pose_sequence[i][0] = 0.525;
				// 	pose_sequence[i][1] = 1.70;
				// 	pose_sequence[i][2] = angle;
				// 	pose_sequence[i][3] = 0;
				// }

				ROS_INFO("[Explore Pose] x:%f, y:%f, theta:%f, flag:%f", pose_sequence[point_count][0], pose_sequence[point_count][1], pose_sequence[point_count][2], pose_sequence[point_count][3]);
				
				point_count += 1;
			}
		}
	}


private:
	int currentState;

	int nextPose;
	int num_points;

	int stop_seconds;
	int moving_back_seconds;

	geometry_msgs::Pose2D global_desired_pose;
	std_msgs::Int32 msg;
	geometry_msgs::Twist velocity_msg;

	std::vector<double> global_pose;
	std::vector<double> previous_pose;

	std::vector< std::vector<double> > pose_sequence;
	std::vector< std::vector<double> > obj_pose_sequence;
	std::vector< std::vector<double> > explore_pose_sequence;

	
	bool hasReachedGoal;
	bool has_reached_orientation;
	bool emergency_break;
	bool print_again;
	// bool has_reached_grab;
	bool open_grippers;
};



int main(int argc, char** argv) 
{	

	ros::init(argc, argv, "state_machine");
	StateMachine st;

	std_msgs::Int32 currentState_msg;
	ros::Rate rate(5);
	
	while (st.nh.ok()) {
        
		ros::spinOnce();
		// fillPoseSequence();
		currentState_msg.data = st.getCurrentState();
		st.pub_currentState.publish(currentState_msg);
		st.publishNewPose();
		st.run();

		rate.sleep();
	}
	return 0;
}
