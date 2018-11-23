#include "ros/ros.h"
#include <math.h>
#include <vector>
#include <std_msgs/Int32.h>
#include <std_msgs/Bool.h>
#include <geometry_msgs/Pose2D.h>
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

class StateMachine{

public: /* ros */
	ros::NodeHandle nh;
	
	ros::Publisher pub_currentState;
	ros::Publisher pub_globalDesiredPose;
	ros::Publisher pub_grab;

	ros::Subscriber sub_has_reached_goal;
	ros::Subscriber sub_has_reached_orientation;
	ros::Subscriber sub_has_reached_grab;

	ros::Time current_time;
    ros::Time arrival_time;


	StateMachine(){
		currentState = STATE_READY;
		hasReachedGoal = false;
		has_reached_orientation = false;
		has_reached_grab = false;
		open_grippers = false;

		nextPose = 0;
		numberOfPoses = 4;
		stop_seconds = 2;

		global_pose = std::vector<double>(3, 0);
		previous_pose = std::vector<double>(3, 0);
		pose_sequence = std::vector<std::vector<double> >(numberOfPoses, std::vector<double>(4, 0)); 
		obj_pose_sequence = std::vector<std::vector<double> >(numberOfPoses, std::vector<double>(4, 0)); 
		explore_pose_sequence = std::vector<std::vector<double> >(numberOfPoses, std::vector<double>(4, 0));
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

		pose_sequence[0][0] = 0.225;
		pose_sequence[0][1] = 1.70;
		pose_sequence[0][2] = 0.0;
		pose_sequence[0][3] = 0;

		pose_sequence[1][0] = 0.225;
		pose_sequence[1][1] = 1.50;
		pose_sequence[1][2] = 0.0;
		pose_sequence[1][3] = 0;

		pose_sequence[2][0] = 0.225;
		pose_sequence[2][1] = 1.50;
		pose_sequence[2][2] = 0.0;
		pose_sequence[2][3] = 1;

		// pose_sequence[2][0] = 0.225;
		// pose_sequence[2][1] = 0.725;
		// pose_sequence[2][2] = 0.0;
		// pose_sequence[2][3] = 0;

		pose_sequence[3][0] = 0.225;
		pose_sequence[3][1] = 0.725;
		pose_sequence[3][2] = M_PI / 2;
		pose_sequence[3][3] = 0;

		pub_currentState = nh.advertise<std_msgs::Int32>("/brain_state", 1);
		pub_globalDesiredPose = nh.advertise<geometry_msgs::Pose2D>("/global_desired_pose", 1);
		pub_grab = nh.advertise<std_msgs::Int32>("/grab", 1);

		sub_has_reached_goal = nh.subscribe<std_msgs::Bool>("/has_reached_goal", 1, &StateMachine::hasReachedGoalCallBack, this);
		sub_has_reached_orientation = nh.subscribe<std_msgs::Bool>("/has_reached_orientation", 1, &StateMachine::hasReachedOrientationCallBack, this);
		sub_has_reached_grab = nh.subscribe<std_msgs::Bool>("/has_reached_grab_goal", 1, &StateMachine::hasReachedGrabCallBack, this);

	};

	void hasReachedGoalCallBack(const std_msgs::Bool::ConstPtr& hasReachedGoal_msg) {
		hasReachedGoal = hasReachedGoal_msg->data;
		ROS_INFO("In hasReachedGoal Callback.");
	}

	void hasReachedOrientationCallBack(const std_msgs::Bool::ConstPtr& hasReachedOrientation_msg) {
		has_reached_orientation = hasReachedOrientation_msg->data;
		ROS_INFO("In hasReachedOrientation Callback.");
	}

	void hasReachedGrabCallBack(const std_msgs::Bool::ConstPtr& hasReachedOGrab_msg) {
		has_reached_grab = hasReachedOGrab_msg->data;
		ROS_INFO("In hasReachedGrab Callback.");
	}

	void run(){
		switch(currentState){
			case STATE_READY: //Needed to give time to the other nodes to listen to the topics
				readExplorePosition();  // for phase 1
				readObjectPosition();   // for phase 2
				currentState = STATE_NEXT_POSE;
				break;

			case STATE_NEXT_POSE: //Take A Pose
				ROS_INFO("NEXT POSE");
				if(nextPose < numberOfPoses){
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

	void objectPosition(){
		double distance_x;
		double distance_y;
		distance_x = 0.2 * cos(global_pose[2]);
		distance_y = 0.2 * sin(global_pose[2]);
		global_pose[0] += distance_x;
		global_pose[1] += distance_y;
	}


	void readExplorePosition(){	// read the position we need to explore for phase 1
		std::fstream fin("/home/ras19/catkin_ws/src/gp9_path_planning/scripts/ShortestPath.txt");

		if (fin){
			double x, y;
			unsigned point_count = 0;
			while(fin>>x>>y){
				
				explore_pose_sequence[point_count][0] = x;
				explore_pose_sequence[point_count][1] = y;
				explore_pose_sequence[point_count][2] = 0;
			
				ROS_INFO("[Explore Pose] x:%f, y:%f, theta:%f, flag:%f", explore_pose_sequence[point_count][0], explore_pose_sequence[point_count][1], explore_pose_sequence[point_count][2], explore_pose_sequence[point_count][3]);
			}
		}
	}

	void readObjectPosition(){	// read the position of the object we detected in phase 1
		std::fstream fin("/home/ras19/catkin_ws/src/transforms/src/objposition.txt");

		if (fin){
			double x, y, theta;
			unsigned obj_count = 0;
			while(fin>>x>>y>>theta){
				
				obj_pose_sequence[obj_count][0] = x;
				obj_pose_sequence[obj_count][1] = y;
				obj_pose_sequence[obj_count][2] = theta;
				obj_pose_sequence[obj_count][3] = 1;
				ROS_INFO("[Object Pose] x:%f, y:%f, theta:%f, flag:%f", obj_pose_sequence[obj_count][0], obj_pose_sequence[obj_count][1], obj_pose_sequence[obj_count][2], obj_pose_sequence[obj_count][3]);
			}
		}

	}


	// void readPosition(){ //TAKEN FROM INTERSECTION --> MUST BE CHANGED AND RIADAPTED!
	// 	{

    //     const char* path_to_file = "/home/ras19/catkin_ws/src/gp9_localization/src/maze.txt";
        
    //     std::string line;
    //     std::string past_value;
    //     std::ifstream myfile;
    //     myfile.open(path_to_file, std::ifstream::in);

    //     if (myfile.is_open()) {

    //         std::deque<std::vector<double> > points;
    //         boost::char_separator<char> sep(" ");
    //         int i = 0;
    //         while(getline(myfile, line)){
                
    //             boost::tokenizer< boost::char_separator<char> > values(line, sep);
    //             BOOST_FOREACH (const std::string& value, values) {
    //                 i++;
    //                 if (i % 2 == 0){
    //                     double x = atof(past_value.c_str());
    //                     double y = atof(value.c_str());
    //                     Point p = Point(x, y);
    //                     points.push_back(p);
    //                 }
    //                 past_value = value;
    //             }
    //         }

    //         Point past_point;
    //         std::deque<Point>::iterator it = points.begin();
    //         i = 0;
    //         while (it != points.end()) {
    //             i++;
    //             Point point = *it++;
    //             if (i % 2 == 0){
    //                     Line l = Line(past_point, point);
    //                     walls.push_back(l);
    //                 }
    //             past_point = point;
    //         }

    //         myfile.close();
    //     }

    //     else std::cout << "Unable to open file";
    // }
	// }

private:
	int currentState;

	int nextPose;
	int numberOfPoses;

	int stop_seconds;

	geometry_msgs::Pose2D global_desired_pose;
	std_msgs::Int32 msg;
	std::vector<double> global_pose;
	std::vector<double> previous_pose;

	std::vector< std::vector<double> > pose_sequence;
	std::vector< std::vector<double> > obj_pose_sequence;
	std::vector< std::vector<double> > explore_pose_sequence;

	
	bool hasReachedGoal;
	bool has_reached_orientation;
	bool has_reached_grab;
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
