#include "ros/ros.h"
#include "sensor_msgs/LaserScan.h"
#include "geometry_msgs/Pose2D.h"
#include <math.h>
#include <vector>
#include <deque>


class ParticleFilter{
public: /* ros */
	ros::NodeHandle nh;
	/* Subscribers and publishers */
        ros::Subscriber sub_lidar;
        ros::Subscriber sub_pose;
        ros::Publisher pub_weight_pose;
        ros::Publisher pub_corrected_pose;

        ros::Time current_time;
        ros::Time last_time;



public: /* Functions */
	/* Constructor Functions */
        ParticleFilter();
        void initParticles();
        void MCL();
        void predict();
        void associate();
        void associate2();
        double calcInnovation();
        void systematicResample();
        void odometryCallBack(const geometry_msgs::Pose2D::ConstPtr &msg);
        void lidarCallBack(const sensor_msgs::LaserScan::ConstPtr &msg);
        void weightedAveragePosePublisher();
        void showPose(geometry_msgs::Pose2D &corrected_pose);

private:
        double frequency;
        double dt;

        int n_particles;
        int n_measurements;
        double measurements[30];
        std::vector<std::vector<double> > particles; // particles with [x, y, theta, w]
        std::vector<std::vector<double> > particles_res; // resampled particles
        double std_x;
        double std_y;
        double std_theta;
        double std_meas;
        double lambda;

        double x_old;
        double y_old;
        double theta_old;
        double dx;
        double dy;
        double dtheta;

        double start_pose[3];
        bool global_flag;

        std::deque<double> z_hat;
};
