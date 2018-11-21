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


class Rotation {

public:
    ros::NodeHandle nh;

	ros::Subscriber sub_pose;
	ros::Subscriber sub_brain;
	ros::Subscriber sub_goal;

	ros::Publisher pub_velocity;

    Rotation(int control_frequency_) {
        nh = ros::NodeHandle("~");

        control_frequency = control_frequency_;
		sub_pose = nh.subscribe<geometry_msgs::Pose2D>("/pose", 1, &Rotation::poseCallBack, this);
		sub_goal = nh.subscribe<geometry_msgs::Pose2D>("/global_desired_pose", 10, &Rotation::globalDesiredPoseCallBack, this);

		pub_velocity = nh.advertise<geometry_msgs::Twist>("/motor_controller/velocity", 1);

        current_angle = M_PI / 2;
        desired_angle = M_PI / 2;

        double threshold_deg = 1;
        angle_threshold = degToRad(threshold_deg);
    }

	void poseCallBack(const geometry_msgs::Pose2D::ConstPtr& pose_msg) {
		current_angle = pose_msg->theta;
	}

	void globalDesiredPoseCallBack(const geometry_msgs::Pose2D::ConstPtr& global_desired_pose_msg) {
		desired_angle = global_desired_pose_msg->theta;
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

    void rotate() {

        double error_angle = getErrorAngle();
		double sign = error_angle / fabs(error_angle);

        if (fabs(error_angle) > angle_threshold) {
            ROS_INFO("Giving signal to motor");
            velocity_msg.linear.x = 0;
            velocity_msg.angular.z = sign * 1.2; // 1.2 is a okay value
            pub_velocity.publish(velocity_msg);
        }

        else {
            ROS_INFO("stopping, i.e. close enough");
            stop();
            // return the server bool
        }
		
	}

    
    void stop() {
		velocity_msg.linear.x = 0;
		velocity_msg.angular.z = 0;
        pub_velocity.publish(velocity_msg);
	}


private:

    int control_frequency;
    double current_angle;
    double desired_angle;
    double angle_threshold;

    geometry_msgs::Twist velocity_msg;

};

int main(int argc, char** argv) {

	int control_frequency = 125;

	ros::init(argc, argv, "rotation");
    Rotation rotation(control_frequency);
	ros::Rate rate(control_frequency);

	while (rotation.nh.ok()) {
		ros::spinOnce();
        ROS_INFO("Going into rotation.rotate()!");
        rotation.rotate();
        rate.sleep();
		
	}

	return 0;
}