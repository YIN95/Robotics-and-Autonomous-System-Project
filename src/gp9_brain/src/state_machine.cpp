#include "ros/ros.h"
#include <math.h>
#include <vector>
#include <std_msgs/Int32.h>
#include <std_msgs/Bool.h>
#include <geometry_msgs/Pose2D.h>

class StateMachine{

public: /* ros */
	ros::NodeHandle nh;
	
	ros::Publisher pub_currentState;
	ros::Publisher pub_globalDesiredPose;

	ros::Subscriber sub_close_enough;

    
	StateMachine(){
		currentState = 2;
		closeEnough = false;

		global_desired_pose.x = 2.0;
		global_desired_pose.y = 0.225;
		global_desired_pose.theta = 0.0;

		pub_currentState = nh.advertise<std_msgs::Int32>("/brain_state", 1);
		pub_globalDesiredPose = nh.advertise<geometry_msgs::Pose2D>("/global_desired_pose", 1);

		sub_close_enough = nh.subscribe<std_msgs::Bool>("/close_enough", 1, &StateMachine::closeEnoughCallBack, this);
	};

	void closeEnoughCallBack(const std_msgs::Bool::ConstPtr& closeEnough_msg) {
		closeEnough = closeEnough_msg->data;
	}

	void run(){
		switch(currentState){
			case 0:
				pub_globalDesiredPose.publish(global_desired_pose);
				currentState = 1;
				break;
			case 1:
				if(closeEnough){
					currentState = 2;
				}
				break;
			case 2:	//Go Home
				global_desired_pose.x = 2.0;
				global_desired_pose.y = 0.225;
				global_desired_pose.theta = 0.0;
				currentState = 0;
				break;
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
	unsigned int currentState;

	geometry_msgs::Pose2D global_desired_pose;

	bool closeEnough;
};



int main(int argc, char** argv) 
{	

	ros::init(argc, argv, "state_machine");
	StateMachine st;

	std_msgs::Int32 currentState_msg;
	ros::Rate rate(10);
	
	while (st.nh.ok()) {
        
		ros::spinOnce();
		st.run();
		currentState_msg.data = st.getCurrentState();
		st.pub_currentState.publish(currentState_msg);
		rate.sleep();
	}
	return 0;
}
