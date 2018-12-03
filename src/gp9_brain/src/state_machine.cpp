#include "ros/ros.h"
#include <math.h>
#include <vector>
#include <std_msgs/Int32.h>
#include <std_msgs/String.h>
#include <std_msgs/Bool.h>
#include <geometry_msgs/Pose2D.h>
#include <geometry_msgs/Twist.h>
#include <iostream>
#include <fstream>
#include <string>
#include <time.h>

#define STATE_READY -1
#define STATE_NEXT_POSE 0
#define STATE_MOVING 1
#define STATE_GO_HOME 2
#define STATE_STOP 3
#define STATE_OPEN_GRIPPERS 4
#define STATE_ROTATING 5
#define STATE_CLOSE_GRIPPERS 6
#define STATE_MOVING_BACK 7
#define STATE_END 8

class StateMachine{

public: /* ros */
	ros::NodeHandle nh;
	
	ros::Publisher pub_currentState;
	ros::Publisher pub_globalDesiredPose;
	ros::Publisher pub_velocity;
	ros::Publisher pub_speak;

	ros::Subscriber sub_has_reached_goal;
	ros::Subscriber sub_has_reached_orientation;
	ros::Subscriber sub_emergency_break;
	ros::Subscriber sub_emergency_break_bt;

	ros::Subscriber sub_detection;

	ros::Time current_time;
    ros::Time arrival_time;

	bool start = true;
	bool home = false;


	StateMachine(){

		nh.getParam("/robot/starting_position/x", start_x);
        nh.getParam("/robot/starting_position/y", start_y);
		nh.getParam("/robot/gohome_position/x", gohome_x);
        nh.getParam("/robot/gohome_position/y", gohome_y);
        nh.getParam("/robot/gohome_position/theta", gohome_theta);


        nh.getParam("/robot/starting_position/theta", start_theta);
		nh.getParam("/maze/exploration", exploration_file_path);
		nh.getParam("/statemachine/stop_time", stop_seconds);

		currentState = STATE_READY;
		hasReachedGoal = false;
		has_reached_orientation = false;
		emergency_break = false;

		print_again = false;
		moving_back_seconds = 1;
		object_detected = false;

		coming_from_moving = false;
		coming_from_rotating = false;

		nextPose = 0;
		num_points = countObjects();
		
		ROS_INFO("num points: %d", num_points);

		global_pose = std::vector<double>(3, 0);
		previous_pose = std::vector<double>(3, 0);
		pose_sequence = std::vector<std::vector<double> >(num_points, std::vector<double>(3, 0));
		
		//The fourth value of the row could be:
		// 0 if there is nothing to grab;
		// 1 if it is an object pose.

		global_pose[0] = start_x;
		global_pose[1] = start_y;
		global_pose[2] = start_theta;

		previous_pose[0] = start_x;
		previous_pose[1] = start_y;
		previous_pose[2] = start_theta;

		pub_currentState = nh.advertise<std_msgs::Int32>("/brain_state", 1);
		pub_globalDesiredPose = nh.advertise<geometry_msgs::Pose2D>("/global_desired_pose", 1);
		pub_velocity = nh.advertise<geometry_msgs::Twist>("/motor_controller/velocity", 1);
		pub_speak = nh.advertise<std_msgs::String>("/espeak/string", 30);

		sub_has_reached_goal = nh.subscribe<std_msgs::Bool>("/has_reached_goal", 1, &StateMachine::hasReachedGoalCallBack, this);
		sub_has_reached_orientation = nh.subscribe<std_msgs::Bool>("/has_reached_orientation", 1, &StateMachine::hasReachedOrientationCallBack, this);
		sub_emergency_break = nh.subscribe<std_msgs::Bool>("/emergency_break", 1, &StateMachine::emergencyBreakCallBack, this);
		// sub_emergency_break_bt = nh.subscribe<geometry_msgs::Pose2D>("/findBattery", 1, &StateMachine::emergencyBreakCallBack_bt, this);
		sub_detection = nh.subscribe<std_msgs::Bool>("/findObject", 1, &StateMachine::detectionCallBack, this);

	} 

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

	void emergencyBreakCallBack_bt(const geometry_msgs::Pose2D::ConstPtr& emergencyBreak_msg) {
		emergency_break = true;
		ROS_INFO("In emergencyBreak Callback. battery ");
	}

	void detectionCallBack(const std_msgs::Bool::ConstPtr& detection_msg) {
		object_detected = detection_msg->data;
		ROS_INFO("In detection Callback.");
	}


	void run(){
		switch(currentState){
			case STATE_READY: //Needed to give time to the other nodes to listen to the topics
				
				readExplorePosition();  // for phase 1
				currentState = STATE_NEXT_POSE;
				
				break;

			case STATE_NEXT_POSE: //Take A Pose
				ROS_INFO("NEXT POSE");

				if (start){
					std_msgs::String msg;
					msg.data = "Start";
					pub_speak.publish(msg);
					start = false;
				}

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
					nextPose += 1;
				}
				else{
					ROS_INFO("EXPLORATION DONE.");
					currentState = STATE_END;
				}
				break;

			case STATE_MOVING:
				ROS_INFO("MOVING");
				if(hasReachedGoal){
					if(home == false){
						currentState = STATE_NEXT_POSE;
						hasReachedGoal = false;
						arrival_time = ros::Time::now();
					}
					if(home == true){
						currentState = STATE_GO_HOME;
						hasReachedGoal = false;
						arrival_time = ros::Time::now();
					}
				}
				if(emergency_break){
					currentState = STATE_MOVING_BACK;
					emergency_break = false;
					arrival_time = ros::Time::now();
				}
				if(object_detected){
					arrival_time = ros::Time::now();
					coming_from_moving = true;
					ROS_INFO("Stopping from moving");
					currentState = STATE_STOP;
					object_detected = false;
				}
				break;

			case STATE_GO_HOME:	//Go Home
				ROS_INFO("GO HOME");
				if(home == false){
					home = true;
					global_pose[0] = gohome_x;
					global_pose[1] = gohome_y;
					global_pose[2] = gohome_theta;
					currentState = STATE_MOVING;
				}
				if(home == true){
					home = false;
					global_pose[0] = start_x;
					global_pose[1] = start_y;
					global_pose[2] = start_theta;
					currentState = STATE_MOVING;
				}
				
				break;

			case STATE_ROTATING:
				ROS_INFO("ROTATING");
				if(has_reached_orientation){
					currentState = STATE_NEXT_POSE;
					has_reached_orientation = false;
					arrival_time = ros::Time::now();
				}
				if(object_detected){
					arrival_time = ros::Time::now();
					coming_from_rotating = true;
					currentState = STATE_STOP;
					ROS_INFO("Stopping from rotating");
					object_detected = false;
				}
				break;

			case STATE_STOP:	//Stop
				ROS_INFO("STOP");

				current_time = ros::Time::now();
				velocity_msg.linear.x = 0;
				velocity_msg.angular.z = 0;
				pub_velocity.publish(velocity_msg);

				if ((current_time - arrival_time).toSec() > stop_seconds){
					if(coming_from_moving){
						currentState = STATE_MOVING;
						coming_from_moving = false;
					}
					else if(coming_from_rotating){
						currentState = STATE_ROTATING;
						coming_from_rotating = false;
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
					std::srand(std::time(0));
					double flag = std::rand()%100/(double)101;
					if (flag>0.3){
						velocity_msg.angular.z = -0.3; // 1.2 is a okay value
						velocity_msg.angular.z = -0.3;
						pub_velocity.publish(velocity_msg);
					}
					else{
						velocity_msg.angular.z = -0.3; // 1.2 is a okay value
						velocity_msg.angular.z = 0.3;
						pub_velocity.publish(velocity_msg);
					}            		
				}
				break;

			case STATE_END:	//Stop
				ROS_INFO("END");

				velocity_msg.linear.x = 0;
				velocity_msg.angular.z = 0;
				pub_velocity.publish(velocity_msg);
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
        std::fstream fin(exploration_file_path.c_str());
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
		std::fstream fin(exploration_file_path.c_str());
		ROS_INFO("In reading file");
		if (fin){
			double x, y;
			unsigned point_count = 0;
			while(fin>>x>>y){
				pose_sequence[point_count][0] = x;
				pose_sequence[point_count][1] = y;
				pose_sequence[point_count][2] = 1.57;
				pose_sequence[point_count][3] = 0;

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

	std::string exploration_file_path;
	geometry_msgs::Pose2D global_desired_pose;
	std_msgs::Int32 grab_msg;
	geometry_msgs::Twist velocity_msg;

	std::vector<double> global_pose;
	std::vector<double> previous_pose;

	std::vector< std::vector<double> > pose_sequence;
	std::vector< std::vector<double> > obj_pose_sequence;
	std::vector< std::vector<double> > explore_pose_sequence;

	double start_x, start_y, start_theta;
	double gohome_x, gohome_y, gohome_theta;

	bool hasReachedGoal;
	bool has_reached_orientation;
	bool emergency_break;
	bool print_again;
	// bool has_reached_grab;
	bool open_grippers;
	bool object_detected;

	bool coming_from_moving;
	bool coming_from_rotating;
};



int main(int argc, char** argv) 
{	

	ros::init(argc, argv, "state_machine");
	StateMachine st;

	std_msgs::Int32 currentState_msg;
	ros::Rate rate(5);
	
	while (st.nh.ok()) {
        
		ros::spinOnce();
		currentState_msg.data = st.getCurrentState();
		st.pub_currentState.publish(currentState_msg);
		st.publishNewPose();
		st.run();

		rate.sleep();
	}
	return 0;
}