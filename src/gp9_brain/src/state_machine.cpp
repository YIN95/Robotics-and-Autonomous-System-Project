#include "ros/ros.h"
#include <math.h>
#include <vector>
#include <std_msgs/Int32.h>
#include <std_msgs/Bool.h>
#include <geometry_msgs/Pose2D.h>

//THE PROBLEM IS: publish a new global pose only when it's different from the previous, 
//otherwise we got a lot of paths and we are unable to reach the next pose.

class StateMachine{

public: /* ros */
	ros::NodeHandle nh;
	
	ros::Publisher pub_currentState;
	ros::Publisher pub_globalDesiredPose;

	ros::Subscriber sub_has_reached_goal;

    
	StateMachine(){
		currentState = -1;
		hasReachedGoal = false;

		global_desired_pose.x = 0.225;
		global_desired_pose.y = 0.225;
		global_desired_pose.theta = M_PI / 2;

		previous_pose = std::vector<double>(3, 0);

		previous_pose[0] = 0.225;
		previous_pose[1] = 0.225;
		previous_pose[2] = M_PI / 2;

		// ROS_INFO("In constructor.");

		pub_currentState = nh.advertise<std_msgs::Int32>("/brain_state", 1);
		pub_globalDesiredPose = nh.advertise<geometry_msgs::Pose2D>("/global_desired_pose", 1);

		sub_has_reached_goal = nh.subscribe<std_msgs::Bool>("/has_reached_goal", 1, &StateMachine::hasReachedGoalCallBack, this);
	};

	void hasReachedGoalCallBack(const std_msgs::Bool::ConstPtr& hasReachedGoal_msg) {
		hasReachedGoal = hasReachedGoal_msg->data;
	}

	void run(){
		switch(currentState){
			case -1: //Initial Pose
				global_desired_pose.x = 1.0;
				global_desired_pose.y = 2.15;
				global_desired_pose.theta = 0.0;
				currentState = 1;
				break;

			// case 0:
			// 	pub_globalDesiredPose.publish(global_desired_pose);
			// 	currentState = 1;
			// 	break;

			case 1:
				if(hasReachedGoal){
					// decideNextPose();
					currentState = 2;
				}
				break;

			case 2:	//Go Home
				global_desired_pose.x = 0.225;
				global_desired_pose.y = 0.225;
				global_desired_pose.theta = 0.0;
				currentState = 1;
				break;
		}
		
	}

	void publishNewPose(){
		bool same_x = (global_desired_pose.x == previous_pose[0]);
		bool same_y = (global_desired_pose.y == previous_pose[1]);
		bool same_angle = (global_desired_pose.theta == previous_pose[3]);
		bool same_point = (same_x && same_y && same_angle);
		if(!same_point){
			pub_globalDesiredPose.publish(global_desired_pose);
			previous_pose[0] = global_desired_pose.x;
			previous_pose[1] = global_desired_pose.y;
			previous_pose[2] = global_desired_pose.theta;
		}
	}

	int getCurrentState(){
		return currentState;
	}
private:
    static const int ST_MOVING_AND_NO_DETECTION = 0;
    static const int ST_MOVING_AND_DETECT_SOMETHING = 1;
    static const int ST_STOP_NOT_DETECT_ANYTHING = 2;
    static const int ST_STUP_AND_DETECT_SOMETHING = 3;
	int currentState;

	geometry_msgs::Pose2D global_desired_pose;

	std::vector<double> previous_pose;

	bool hasReachedGoal;
};



int main(int argc, char** argv) 
{	

	ros::init(argc, argv, "state_machine");
	StateMachine st;

	std_msgs::Int32 currentState_msg;
	ros::Rate rate(10);
	
	while (st.nh.ok()) {
        
		ros::spinOnce();
		st.publishNewPose();
		st.run();
		currentState_msg.data = st.getCurrentState();
		st.pub_currentState.publish(currentState_msg);
		rate.sleep();
	}
	return 0;
}
