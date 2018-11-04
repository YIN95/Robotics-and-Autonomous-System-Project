#include "ros/ros.h"
#include "geometry_msgs/Twist.h"
#include "sensor_msgs/LaserScan.h"
#include "geometry_msgs/Pose2D.h"
#include <math.h>
#include <vector>


class ParticleFilter{
public: /* ros */
	ros::NodeHandle nh;
	/* Subscribers and publishers */
        ros::Subscriber sub_lidar;
        ros::Subscriber sub_vel;
        ros::Publisher pub_weight_pose;

        ros::Time current_time;
        ros::Time last_time;



public: /* Functions */
	/* Constructor Functions */
        ParticleFilter();
        void initParticles();
        void MCL();
        void predict();
        void associate();
        void systematicResample();
        void velocityCallBack(const geometry_msgs::Twist::ConstPtr &msg);
        void lidarCallBack(const sensor_msgs::LaserScan::ConstPtr &msg);
        void weightedAveragePosePublisher();

private:
        double dt;

        int n_particles;
        int n_measurements;
        double measurements[30];
        double particles[4][500]; // particles with [x, y, theta, w]
        double particles_res[4][500]; // resampled particles
        double std_x;
        double std_y;
        double std_theta;
        double std_meas;
        double lambda;


        double v;
        double w;

        double start_pose[3];
        bool global_flag;

        double weight_sum;

};
