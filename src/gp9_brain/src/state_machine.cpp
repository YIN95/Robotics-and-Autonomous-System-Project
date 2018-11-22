#include "ros/ros.h"
#include <math.h>
#include <vector>
#include <std_msgs/Int32.h>
#include <std_msgs/Bool.h>
#include <geometry_msgs/Pose2D.h>

#define STATE_READY -1
#define STATE_NEXT_POSE 0
#define STATE_MOVING 1
#define STATE_GO_HOME 2
#define STATE_STOP 3
#define STATE_GRIPPERS 4
#define STATE_ROTATING 5

class StateMachine{

public: /* ros */
	ros::NodeHandle nh;
	
	ros::Publisher pub_currentState;
	ros::Publisher pub_globalDesiredPose;

	ros::Subscriber sub_has_reached_goal;
	ros::Subscriber sub_has_reached_orientation;

	ros::Time current_time;
    ros::Time arrival_time;


	StateMachine(){
		currentState = STATE_READY;
		hasReachedGoal = false;
		has_reached_orientation = false;

		nextPose = 0;
		numberOfPoses = 3;
		stop_seconds = 2;

		global_pose = std::vector<double>(3, 0);
		previous_pose = std::vector<double>(3, 0);
		pose_sequence = std::vector<std::vector<double> >(numberOfPoses, std::vector<double>(3, 0)); 
		//The fourth value of the row could be:
		//- 0 if there is nothing to grab;
		//- 1 if it is an object pose;
		//- 2 if there is an obstacle to avoid.

		global_pose[0] = 0.225;
		global_pose[1] = 0.225;
		global_pose[2] = M_PI / 2;

		previous_pose[0] = 0.225;
		previous_pose[1] = 0.225;
		previous_pose[2] = M_PI / 2;

		pose_sequence[0][0] = 0.525;
		pose_sequence[0][1] = 2.15;
		pose_sequence[0][2] = 0.0;

		pose_sequence[1][0] = 0.225;
		pose_sequence[1][1] = 2.125;
		pose_sequence[1][2] = 0.0;

		pose_sequence[2][0] = 0.225;
		pose_sequence[2][1] = 0.725;
		pose_sequence[2][2] = 0.0;

		pub_currentState = nh.advertise<std_msgs::Int32>("/brain_state", 1);
		pub_globalDesiredPose = nh.advertise<geometry_msgs::Pose2D>("/global_desired_pose", 1);

		sub_has_reached_goal = nh.subscribe<std_msgs::Bool>("/has_reached_goal", 1, &StateMachine::hasReachedGoalCallBack, this);
		sub_has_reached_orientation = nh.subscribe<std_msgs::Bool>("/has_reached_orientation", 1, &StateMachine::hasReachedOrientationCallBack, this);
	};

	void hasReachedGoalCallBack(const std_msgs::Bool::ConstPtr& hasReachedGoal_msg) {
		hasReachedGoal = hasReachedGoal_msg->data;
		ROS_INFO("In hasReachedGoal Callback.");
	}

	void hasReachedOrientationCallBack(const std_msgs::Bool::ConstPtr& hasReachedOrientation_msg) {
		has_reached_orientation = hasReachedOrientation_msg->data;
		ROS_INFO("In hasReachedOrientation Callback.");
	}

	void run(){
		switch(currentState){
			case STATE_READY: //Needed to give time to the other nodes to listen to the topics
				currentState = STATE_NEXT_POSE;
				break;

			case STATE_NEXT_POSE: //Take A Pose
				ROS_INFO("NEXT POSE");
				if(nextPose < numberOfPoses){
					global_pose[0] = pose_sequence[nextPose][0];
					global_pose[1] = pose_sequence[nextPose][1];
					global_pose[2] = pose_sequence[nextPose][2];
					nextPose += 1;
					if ((global_pose[0] == previous_pose[0]) && (global_pose[1] == previous_pose[1])){
						currentState = STATE_ROTATING;
					}
					else{
						currentState = STATE_MOVING;
					}
					previous_pose[0] = global_pose[0];
					previous_pose[1] = global_pose[1];
				}
				else{
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
				break;

			case STATE_STOP:	//Stop
				ROS_INFO("STOP");

				current_time = ros::Time::now();
				if ((current_time - arrival_time).toSec() > stop_seconds){
					currentState = STATE_NEXT_POSE;
				};
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

		if(!same_point){
			global_desired_pose.x = global_pose[0];
			global_desired_pose.y = global_pose[1];
			global_desired_pose.theta = global_pose[2];
			pub_globalDesiredPose.publish(global_desired_pose);
			previous_pose[0] = global_pose[0];
			previous_pose[1] = global_pose[1];
			previous_pose[2] = global_pose[2];
		}
		ROS_INFO("Has Reached Goal? %d", hasReachedGoal);
		ROS_INFO("Has Reached Orientation? %d", has_reached_orientation);
		ROS_INFO("---------------------------------------------------------------------------------");
	}

	int getCurrentState(){
		return currentState;
	}

	// void fillPoseSequence();
private:
	int currentState;

	int nextPose;
	int numberOfPoses;

	int stop_seconds;

	geometry_msgs::Pose2D global_desired_pose;

	std::vector<double> global_pose;
	std::vector<double> previous_pose;

	std::vector< std::vector<double> > pose_sequence;

	bool hasReachedGoal;
	bool has_reached_orientation;
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
