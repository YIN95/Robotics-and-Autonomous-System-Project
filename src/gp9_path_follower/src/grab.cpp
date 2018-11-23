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


class Grab {

public:
    ros::NodeHandle nh;
	ros::Subscriber sub_pose;
	ros::Subscriber sub_brain;
	ros::Subscriber sub_goal;

    ros::Publisher pub_close_enough;
	ros::Publisher pub_velocity;
	ros::Publisher pub_has_reached_goal;
    ros::Publisher pub_grab;

    Grab(int control_frequency_) {
        nh = ros::NodeHandle("~");

        control_frequency = control_frequency_;
		sub_pose = nh.subscribe<geometry_msgs::Pose2D>("/pose", 1, &Grab::poseCallBack, this);
		sub_brain = nh.subscribe<std_msgs::Int32>("/brain_state", 1, &Grab::brainStateCallBack, this);
		sub_goal = nh.subscribe<geometry_msgs::Pose2D>("/global_desired_pose", 10, &Grab::globalDesiredPoseCallBack, this);

		pub_close_enough = nh.advertise<std_msgs::Bool>("/close_enough", 1);
		pub_velocity = nh.advertise<geometry_msgs::Twist>("/motor_controller/velocity", 1);
		pub_has_reached_goal = nh.advertise<std_msgs::Bool>("/has_reached_grab_goal", 1);

        pub_grab = nh.advertise<std_msgs::Int32>("/grab", 1);

        reached_goal_msg.data = false;
        previous_hasReachedGoal = true;
        newInfoAboutGoal = false;
        stopped = false;

        brain_state = -10;
        current_angle = M_PI / 2;
        desired_angle = M_PI / 2;

        current_x = 0;
        current_y = 0;
        desired_x = 0;
        desired_y = 0;


        double threshold_deg = 1;
        angle_threshold = degToRad(threshold_deg);
        distance_threshold = 0.08;
    }

    void brainStateCallBack(const std_msgs::Int32::ConstPtr& brain_msg) {
		brain_state = brain_msg->data;
	}

	void poseCallBack(const geometry_msgs::Pose2D::ConstPtr& pose_msg) {
		current_angle = pose_msg->theta;
        current_x = pose_msg->x;
        current_y = pose_msg->y;
	}

	void globalDesiredPoseCallBack(const geometry_msgs::Pose2D::ConstPtr& global_desired_pose_msg) {
		desired_angle = global_desired_pose_msg->theta;
        desired_x = global_desired_pose_msg->x;
        desired_y = global_desired_pose_msg->y;
        stopped = false;
	}

    double degToRad(double degrees) {
		return degrees * M_PI / 180;
	}

    double getErrorAngle() {
        double error_angle = desired_angle - current_angle;

        // Remap to [0, 2pi]
        if (error_angle <= -M_PI) {
            error_angle += 2*M_PI;
        }
        else if (error_angle > M_PI) {
            error_angle -= 2*M_PI;
        }

        return error_angle;
	}

    double getErrorDistance(){
        double lx = current_x-desired_x;
        double ly = current_y-desired_y;
        double error_distance = sqrt(lx*lx + ly*ly);

        return error_distance;
    }

    void grab() {

        reached_goal_msg.data = false;

        double error_distance = getErrorDistance();
		double sign = error_distance / fabs(error_distance);

        std_msgs::Int32 msg;
        msg.data = 1;
        pub_grab.publish(msg);
        if (fabs(error_distance) > distance_threshold) {
            ROS_INFO("Giving signal to motor");
            velocity_msg.linear.x = sign * 0.5;
            velocity_msg.angular.z = 0; // 1.2 is a okay value
            pub_velocity.publish(velocity_msg);
        }

        else {
            ROS_INFO("stopping, i.e. close enough");

            stop();
            msg.data = 0;
            pub_grab.publish(msg);
        }

        updateGoalInfo();
        if(newInfoAboutGoal){
			pub_has_reached_goal.publish(reached_goal_msg);
		}
		
	}

    void updateGoalInfo() {
		if(reached_goal_msg.data != previous_hasReachedGoal){
			newInfoAboutGoal = true;
		}
		else{
			newInfoAboutGoal = false;
		}
		previous_hasReachedGoal = reached_goal_msg.data;

	}
    
    void stop() {
		velocity_msg.linear.x = 0;
		velocity_msg.angular.z = 0;
        pub_velocity.publish(velocity_msg);
        stopped = true;
        reached_goal_msg.data = true;
        
	}

    bool has_stopped() {
		return stopped;
	}

    int getBrainState() {
        return brain_state;
    }


private:

    int control_frequency;
    int brain_state;
    bool stopped;
    double current_angle;
    double desired_angle;
    double angle_threshold;
    double distance_threshold;
    double current_x;
    double current_y;
    double desired_x;
    double desired_y;

    bool previous_hasReachedGoal;
    bool newInfoAboutGoal;

    geometry_msgs::Twist velocity_msg;
    std_msgs::Bool reached_goal_msg;
    
};

int main(int argc, char** argv) {

	int control_frequency = 125;

	ros::init(argc, argv, "grab");
    Grab grab(control_frequency);
	ros::Rate rate(control_frequency);

	while (grab.nh.ok()) {
		ros::spinOnce();
		if (!grab.has_stopped()) {
            if(grab.getBrainState() == 4) {
                ROS_INFO("Going into grab.grab()!");
                grab.grab();
            }
        
            rate.sleep();
        }
		
	}

	return 0;
}