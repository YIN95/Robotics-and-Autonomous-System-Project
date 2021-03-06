#include "ros/ros.h"
#include <math.h>
#include <vector>
#include <std_msgs/Int32.h>
#include <std_msgs/Bool.h>
#include <std_msgs/String.h>
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
	ros::Publisher pub_speak;
	ros::Publisher pub_timeover;

	ros::Subscriber sub_has_reached_goal;
	ros::Subscriber sub_has_reached_orientation;
	ros::Subscriber sub_emergency_break;
	
	ros::Subscriber sub_detection;

	ros::Time current_time;
    ros::Time arrival_time;
	ros::Time start_time;
	bool start = true;
	bool home = false;
	bool timeover = false;

	StateMachine(){
		nh.getParam("/robot/starting_position/x", start_x);
        nh.getParam("/robot/starting_position/y", start_y);
		nh.getParam("/robot/gohome_position/x", gohome_x);
        nh.getParam("/robot/gohome_position/y", gohome_y);
        nh.getParam("/robot/gohome_position/theta", gohome_theta);
        nh.getParam("/robot/starting_position/theta", start_theta);
		nh.getParam("/statemachine/stop_time", stop_seconds);

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
		desired_distance_from_object = 0;

        num_objects = countObjects();

		global_pose = std::vector<double>(3, 0);
		previous_pose = std::vector<double>(3, 0);
		pose_sequence = std::vector<std::vector<double> >(num_objects, std::vector<double>(4, 0));
		obj_pose_sequence = std::vector<std::vector<double> >(num_objects, std::vector<double>(2, 0));
		// The fourth value of the row could be:
		// 0 if there is nothing to grab;
		// 1 if it is an object pose;

		global_pose[0] = start_x;
		global_pose[1] = start_y;
		global_pose[2] = start_theta;

		previous_pose[0] = start_x;
		previous_pose[1] = start_y;
		previous_pose[2] = start_theta;

		pub_timeover = nh.advertise<std_msgs::Bool>("/timeover", 1);
		pub_currentState = nh.advertise<std_msgs::Int32>("/brain_state", 1);
		pub_globalDesiredPose = nh.advertise<geometry_msgs::Pose2D>("/global_desired_pose", 1);
		pub_grab = nh.advertise<std_msgs::Int32>("/grab", 1);
		pub_velocity = nh.advertise<geometry_msgs::Twist>("/motor_controller/velocity", 1);
		pub_speak = nh.advertise<std_msgs::String>("/espeak/string", 30);

		sub_has_reached_goal = nh.subscribe<std_msgs::Bool>("/has_reached_goal", 1, &StateMachine::hasReachedGoalCallBack, this);
		sub_has_reached_orientation = nh.subscribe<std_msgs::Bool>("/has_reached_orientation", 1, &StateMachine::hasReachedOrientationCallBack, this);
		sub_emergency_break = nh.subscribe<std_msgs::Bool>("/emergency_break", 1, &StateMachine::emergencyBreakCallBack, this);
		sub_detection = nh.subscribe<std_msgs::Bool>("/findObject", 1, &StateMachine::detectionCallBack, this);

		
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

	void detectionCallBack(const std_msgs::Bool::ConstPtr& detection_msg) {
		object_detected = detection_msg->data;
		ROS_INFO("In detection Callback.");
	}
	

	void run(){
		switch(currentState){
			case STATE_READY:
                msg.data = 0;
            	pub_grab.publish(msg);
				readObjectPosition();
				currentState = STATE_NEXT_POSE;
				break;

			case STATE_NEXT_POSE:

				if(start){
					std_msgs::String msg;
					msg.data = "Start";
					pub_speak.publish(msg);
					start=false;
					start_time = ros::Time::now();
				}
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
						objectPosition(nextPose-1);
						open_grippers = true;
						currentState = STATE_OPEN_GRIPPERS;
					}
				}
				if(emergency_break){
					currentState = STATE_MOVING_BACK;
					emergency_break = false;
					arrival_time = ros::Time::now();
				}

				current_time = ros::Time::now();
	
				if ((current_time - start_time).toSec() > 180){
					timeover = true;
					std_msgs::String msg;
					msg.data = "time over";
					pub_speak.publish(msg);

					std_msgs::Bool msg_timeover;
					msg_timeover.data = true;
					pub_timeover.publish(msg_timeover);
					currentState = STATE_END;
				}
				break;

			case STATE_GO_HOME:
				ROS_INFO("GO HOME");
				if(home == false){
					home = true;
					global_pose[0] = gohome_x;
					global_pose[1] = gohome_y;
					global_pose[2] = gohome_theta;
					currentState = STATE_MOVING;
				}
				if(home == true){
					std_msgs::String msg;
					msg.data = "Start";
					pub_speak.publish(msg);
					home = false;
					global_pose[0] = start_x;
					global_pose[1] = start_y;
					global_pose[2] = start_theta;
					open_grippers = false;
					retrieving_object = true;
					currentState = STATE_MOVING;
				}
				break;

			case STATE_ROTATING:
				ROS_INFO("ROTATING");
				if(has_reached_orientation){
					currentState = STATE_STOP;
					has_reached_orientation = false;
					arrival_time = ros::Time::now();
					if ((!open_grippers) && (fabs(pose_sequence[nextPose-1][3]-1) < 1e-6)){
						objectPosition(nextPose-1);
						open_grippers = true;
						currentState = STATE_OPEN_GRIPPERS;
					}
				}
				if(object_detected){
					arrival_time = ros::Time::now();
					coming_from_rotating = true;
					currentState = STATE_STOP;
					ROS_INFO("Stopping from rotating");
					object_detected = false;
				}
				
				break;

			case STATE_STOP:
				ROS_INFO("STOP");

				current_time = ros::Time::now();
				if ((current_time - arrival_time).toSec() > stop_seconds){
					if ((open_grippers) && (fabs(pose_sequence[nextPose-1][3]-1) < 1e-6)){
						currentState = STATE_CLOSE_GRIPPERS;
					}
					else{
						if(home == false){
							currentState = STATE_NEXT_POSE;
						}
						if(home == true){
							currentState = STATE_GO_HOME;
						}
					}
					if(coming_from_moving){
						currentState = STATE_MOVING;
						coming_from_moving = false;
					}
					else if(coming_from_rotating){
						currentState = STATE_ROTATING;
						coming_from_rotating = false;
					}
					if(retrieving_object){
						currentState = STATE_OPEN_GRIPPERS;
					}
					
				}
				break;

			case STATE_MOVING_BACK:
				ROS_INFO("MOVING BACK");

				current_time = ros::Time::now();
				if ((current_time - arrival_time).toSec() > moving_back_seconds){
					print_again = true;
					velocity_msg.linear.x = 0;
            		velocity_msg.angular.z = 0;
            		pub_velocity.publish(velocity_msg);
					currentState = STATE_MOVING;
					if(go_back_to_release){
						currentState = STATE_CLOSE_GRIPPERS;
						go_back_to_release = false;
						print_again = false;
					}
				}
				else{
					velocity_msg.linear.x = -0.2;
					std::srand(std::time(0));
					double flag = std::rand()%100/(double)101;
					if (flag>0.3){
						velocity_msg.angular.z = -0.3;
						velocity_msg.angular.z = -0.3;
						pub_velocity.publish(velocity_msg);
					}
					else{
						velocity_msg.angular.z = -0.3;
						velocity_msg.angular.z = 0.3;
						pub_velocity.publish(velocity_msg);
					}            		
				}
				break;

			case STATE_OPEN_GRIPPERS:
				ROS_INFO("OPEN GRIPPERS");
        		msg.data = 1;
        		pub_grab.publish(msg);
				velocity_msg.linear.x = 0;
            	velocity_msg.angular.z = 0;
            	pub_velocity.publish(velocity_msg);
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
				velocity_msg.linear.x = 0;
            	velocity_msg.angular.z = 0;
            	pub_velocity.publish(velocity_msg);
				currentState = STATE_GO_HOME;
				if(retrieving_object){
					retrieving_object = false;
					currentState = STATE_NEXT_POSE;
				}
        		
				break;

			case STATE_END:
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
		if((!same_point)||(print_again)){
			if((global_pose[0] != 0) && (global_pose[1] != 0)){
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
			
		}
	}

	int getCurrentState(){
		return currentState;
	}

	void objectPosition(int obj_count){ 
		
		double dx = obj_pose_sequence[obj_count][0] - global_pose[0];
		double dy = obj_pose_sequence[obj_count][1] - global_pose[1];
		double dist = sqrt(pow(dx, 2) + pow(dy, 2));
		double distance_x;
		double distance_y;
		distance_x = (dist - desired_distance_from_object) * cos(global_pose[2]);
		distance_y = (dist - desired_distance_from_object) * sin(global_pose[2]);

		global_pose[0] += distance_x;
		global_pose[1] += distance_y;


	}

    int countObjects(){
        std::fstream fin("/home/ras19/catkin_ws/src/transforms/src/objposition.txt");
        int num_points = 0;
		if (fin){
            double x, y, theta, xo, yo;
            while(fin>>x>>y>>theta>>xo>>yo) {
                num_points++;
            }
        }
        return 2*num_points;
    }

	void readObjectPosition(){
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

				// Object pose
				obj_pose_sequence[obj_count+1][0] = xo;
				obj_pose_sequence[obj_count+1][1] = yo;

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

	double start_x, start_y, start_theta;
	double gohome_x, gohome_y, gohome_theta;
	
	bool hasReachedGoal;
	bool has_reached_orientation;
	bool open_grippers;
	bool retrieving_object;
	bool go_back_to_release;
	bool emergency_break;
	bool print_again;
	bool object_detected;

	bool coming_from_moving;
	bool coming_from_rotating;

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
		if(st.timeover){
			break;
		}
		rate.sleep();
	}
	return 0;
}
