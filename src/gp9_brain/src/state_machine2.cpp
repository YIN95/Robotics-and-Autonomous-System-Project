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
#define STATE_END 8

class StateMachine{

public: /* ros */
	ros::NodeHandle nh;
	
	ros::Publisher pub_currentState;
	ros::Publisher pub_globalDesiredPose;
	ros::Publisher pub_grab;
	ros::Publisher pub_velocity;

	ros::Subscriber sub_has_reached_goal;
	ros::Subscriber sub_has_reached_orientation;
	ros::Subscriber sub_emergency_break;

	ros::Time current_time;
    ros::Time arrival_time;


	StateMachine(){
		currentState = STATE_READY;
		hasReachedGoal = false;
		has_reached_orientation = false;
		open_grippers = false;
		retrieving_object = false;
		go_back_to_release = false;
		emergency_break = false;
		print_again = false;

		nextPose = 0;
		stop_seconds = 2;
		moving_back_seconds = 1;
		desired_distance_from_object = 0.12;

        num_objects = countObjects();
		ROS_INFO("num of objects %d", num_objects);


		global_pose = std::vector<double>(3, 0);
		previous_pose = std::vector<double>(3, 0);
		pose_sequence = std::vector<std::vector<double> >(num_objects, std::vector<double>(4, 0));
		obj_pose_sequence = std::vector<std::vector<double> >(num_objects, std::vector<double>(2, 0));
		// The fourth value of the row could be:
		// 0 if there is nothing to grab;
		// 1 if it is an object pose;

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

	

	void run(){
		switch(currentState){
			case STATE_READY: //Needed to give time to the other nodes to listen to the topics
                msg.data = 0;
            	pub_grab.publish(msg);
				readObjectPosition_trial();
				currentState = STATE_NEXT_POSE;
				break;

			case STATE_NEXT_POSE: //Take A Pose
				ROS_INFO("NEXT POSE");
				if(nextPose < num_objects){
					ROS_INFO("Taking a new position");
					global_pose[0] = pose_sequence[nextPose][0];
					global_pose[1] = pose_sequence[nextPose][1];
					global_pose[2] = pose_sequence[nextPose][2];
					global_pose[3] = pose_sequence[nextPose][3];
					
					bool same_x = fabs(previous_pose[0] - global_pose[0]) < 1e-6;
					bool same_y = fabs(previous_pose[1] - global_pose[1]) < 1e-6;
					if (same_x && same_y){
						currentState = STATE_ROTATING;
					}
					else{
						currentState = STATE_MOVING;
					}
					open_grippers = false;
					retrieving_object = false;
					nextPose += 1;
				}
				else{
					ROS_INFO("RETRIEVING OBJECTS DONE.");
					currentState = STATE_END;
				}
				break;

			case STATE_MOVING:
				ROS_INFO("MOVING");
				if(hasReachedGoal){
					currentState = STATE_STOP;
					hasReachedGoal = false;
					arrival_time = ros::Time::now();
					if ((!open_grippers) && (fabs(pose_sequence[nextPose-1][3]-1) < 1e-6)){
						if(retrieving_object){
							break;
						}
						objectPosition_trial(nextPose-1);
						open_grippers = true;
						currentState = STATE_OPEN_GRIPPERS;
					}
				}
				if(emergency_break){
					currentState = STATE_MOVING_BACK;
					emergency_break = false;
					arrival_time = ros::Time::now();
				}
				break;

			case STATE_GO_HOME:	//Go Home
				ROS_INFO("GO HOME");
				global_pose[0] = 0.225;
				global_pose[1] = 0.225;
				global_pose[2] = 0.0;
				open_grippers = false;
				retrieving_object = true;
				currentState = STATE_MOVING;
				break;

			case STATE_ROTATING:
				ROS_INFO("ROTATING");
				if(has_reached_orientation){
					currentState = STATE_STOP;
					has_reached_orientation = false;
					arrival_time = ros::Time::now();
					if ((!open_grippers) && (fabs(pose_sequence[nextPose-1][3]-1) < 1e-6)){
						objectPosition_trial(nextPose-1);
						open_grippers = true;
						currentState = STATE_OPEN_GRIPPERS;
					}
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
					if(retrieving_object){
						currentState = STATE_OPEN_GRIPPERS;
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
					if(go_back_to_release){
						currentState = STATE_CLOSE_GRIPPERS;
						go_back_to_release = false;
						print_again = true;
					}
				}
				else{
					velocity_msg.linear.x = -0.2;
            		velocity_msg.angular.z = -0.2; // 1.2 is a okay value
            		pub_velocity.publish(velocity_msg);
				}
				break;

			case STATE_OPEN_GRIPPERS:
				ROS_INFO("OPEN GRIPPERS");
        		msg.data = 1;
        		pub_grab.publish(msg);
				currentState = STATE_MOVING;
				if(retrieving_object){
					currentState = STATE_MOVING_BACK;
					go_back_to_release = true;
					arrival_time = ros::Time::now();
				}
				break;
			
			case STATE_CLOSE_GRIPPERS:
				ROS_INFO("CLOSE GRIPPERS");
				ROS_INFO("======================================================");
				msg.data = 0;
            	pub_grab.publish(msg);
				currentState = STATE_GO_HOME;
				if(retrieving_object){
					retrieving_object = false;
					currentState = STATE_NEXT_POSE;
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
		bool same_x = fabs(previous_pose[0] - global_pose[0]) < 1e-6;
		bool same_y = fabs(previous_pose[1] - global_pose[1]) < 1e-6;
		bool same_angle = fabs(previous_pose[2] - global_pose[2]) < 1e-6;
		bool same_point = (same_x && same_y && same_angle);
		ROS_INFO("print_again %d", print_again);
		if((!same_point)||(print_again)){
			ROS_INFO("PUBLISH point %f %f %f", global_pose[0], global_pose[1], global_pose[2]);
			global_desired_pose.x = global_pose[0];
			global_desired_pose.y = global_pose[1];
			global_desired_pose.theta = global_pose[2];
			pub_globalDesiredPose.publish(global_desired_pose);
			previous_pose[0] = global_pose[0];
			previous_pose[1] = global_pose[1];
			previous_pose[2] = global_pose[2];
			print_again = false;
			
		}
		//ROS_INFO("Has Reached Goal? %d", hasReachedGoal);
		//ROS_INFO("Has Reached Orientation? %d", has_reached_orientation);
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

	void objectPosition_trial(int obj_count){ 
		//To close the grippers at desired distance from object instead of the object position
		
		double dx = obj_pose_sequence[obj_count][0] - global_pose[0];
		double dy = obj_pose_sequence[obj_count][1] - global_pose[1];
		double dist = sqrt(pow(dx, 2) + pow(dy, 2));
		double distance_x;
		double distance_y;

		ROS_INFO("distance: %f", dist - desired_distance_from_object);
		ROS_INFO("global x: %f", global_pose[0]);
		ROS_INFO("object x: %f", obj_pose_sequence[obj_count][0]);
		distance_x = (dist - desired_distance_from_object) * cos(global_pose[2]);
		distance_y = (dist - desired_distance_from_object) * sin(global_pose[2]);

		global_pose[0] += distance_x;
		global_pose[1] += distance_y;


	}


    int countObjects(){
        std::fstream fin("/home/ras19/catkin_ws/src/transforms/src/objposition.txt");
        int num_points = 0;
		if (fin){
            double x, y, theta;
            while(fin>>x>>y>>theta) {
                num_points++;
            }
        }
        return 2*num_points;
    }

	void readObjectPosition(){	// read the position of the object we detected in phase 1
		std::fstream fin("/home/ras19/catkin_ws/src/transforms/src/objposition.txt");

		if (fin){

            double x, y, theta, xo, yo;
			unsigned obj_count = 0;

			while(fin>>x>>y>>theta>>xo>>yo){
				
				pose_sequence[obj_count][0] = x;
				pose_sequence[obj_count][1] = y;
				pose_sequence[obj_count][2] = theta;
				pose_sequence[obj_count][3] = 0;
                pose_sequence[obj_count+1][0] = x;
				pose_sequence[obj_count+1][1] = y;
				pose_sequence[obj_count+1][2] = theta;
				pose_sequence[obj_count+1][3] = 1;

				// ROS_INFO("[Object Pose] x:%f, y:%f, theta:%f, flag:%f", pose_sequence[obj_count][0], pose_sequence[obj_count][1], pose_sequence[obj_count][2], pose_sequence[obj_count][3]);
                // ROS_INFO("counter: %d", obj_count);
                obj_count += 2;
			}
			
		}

	}

	void readObjectPosition_trial(){	// read the position of the object we detected in phase 1
		std::fstream fin("/home/ras19/catkin_ws/src/transforms/src/objposition.txt");

		if (fin){

            double x, y, theta, xo, yo;
			unsigned obj_count = 0;

			while(fin>>x>>y>>theta>>xo>>yo){
				
				// Robot pose when the object has been detected
				pose_sequence[obj_count][0] = x;
				pose_sequence[obj_count][1] = y;
				pose_sequence[obj_count][2] = theta;
				pose_sequence[obj_count][3] = 0;
                pose_sequence[obj_count+1][0] = x;
				pose_sequence[obj_count+1][1] = y;
				pose_sequence[obj_count+1][2] = theta;
				pose_sequence[obj_count+1][3] = 1;

				// Object pose
				obj_pose_sequence[obj_count+1][0] = xo;
				obj_pose_sequence[obj_count+1][1] = yo;

				// ROS_INFO("[Object Pose] x:%f, y:%f, theta:%f, flag:%f", pose_sequence[obj_count][0], pose_sequence[obj_count][1], pose_sequence[obj_count][2], pose_sequence[obj_count][3]);
                // ROS_INFO("counter: %d", obj_count);
                obj_count += 2;
			}
			
		}

	}

private:
	int currentState;

	int nextPose;
	int num_objects;

	int stop_seconds;
	int moving_back_seconds;
	double desired_distance_from_object;

	geometry_msgs::Pose2D global_desired_pose;
	std_msgs::Int32 msg;
	geometry_msgs::Twist velocity_msg;

	std::vector<double> global_pose;
	std::vector<double> previous_pose;

	std::vector< std::vector<double> > pose_sequence;
	std::vector< std::vector<double> > obj_pose_sequence;

	
	bool hasReachedGoal;
	bool has_reached_orientation;
	bool open_grippers;
	bool retrieving_object;
	bool go_back_to_release;
	bool emergency_break;
	bool print_again;

};



int main(int argc, char** argv) 
{	

	ros::init(argc, argv, "state_machine2");
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
