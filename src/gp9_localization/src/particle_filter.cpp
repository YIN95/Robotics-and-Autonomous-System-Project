//#include "gp9_localization/particle_filter.h"
#include "ros/ros.h"
#include "sensor_msgs/LaserScan.h"
#include "geometry_msgs/Pose2D.h"
#include <std_msgs/Bool.h>
#include <math.h>
#include <vector>
#include <deque>
#include <visualization_msgs/Marker.h>
#include <visualization_msgs/MarkerArray.h>
#include <random_numbers/random_numbers.h>
#include <iostream>
#include <fstream>
#include <string>
#include <math.h>
#include <deque>
#include <tf/transform_broadcaster.h>
#include <boost/foreach.hpp>
#include <boost/tokenizer.hpp>
#include <std_msgs/Bool.h>
#include <time.h>

class Point{
    public:

        Point() {
            x = 0;
            y = 0;
        }
 
        Point(double x_, double y_) {
            x = x_;
            y = y_;
        }

        Point operator-(Point &p) {
            Point result;
            result.x = x - p.x;
            result.y = y - p.y;
            return result;
        }

        Point operator+(Point &p) {
            Point result;
            result.x = x + p.x;
            result.y = y + p.y;
            return result;
        }

        Point mult(double scalar) {
            return Point(scalar * x, scalar * y);
        }

        double norm() {
            return sqrt(pow(x, 2) + pow(y, 2));
        }

        double dist(Point &other) {
            double dist = sqrt(pow((other.x - x), 2) + pow((other.y - y), 2));
            return sqrt(pow((other.x - x), 2) + pow((other.y - y), 2));;
        }

        double cross(Point &other) {
            return x * other.y - y * other.x;
        }

        void print() {
            std::cout << "Point: (" << x << ", " << y << ")" << '\n';
        }


    private:
        double x;
        double y;

};

class Line{
    public:

        Line(Point p1_, Point p2_){
            p1 = p1_;
            p2 = p2_;
        }

        double intersect_dist(Line &other, bool &intersects) {
            Point r = p2 - p1;

            //First line is parameterized: q + u * s for u in [0, 1]
            Point s = other.p2 - other.p1;
            double rs = r.cross(s);

            if (rs == 0) {
                return 0;
            }

            Point qp = other.p1 - p1;

            double t = qp.cross(s) / rs;
            double u = qp.cross(r) / rs;

            bool t_in_interval = ((0 <= t) && (t <= 1));
            bool u_in_interval = ((0 <= u) && (u <= 1));

            if (t_in_interval && u_in_interval) {
                intersects = true;
                return t * r.norm();
            }

            return 0;

        }

        void print() {
            p1.print();
            p2.print();
            std::cout << "=====" << std::endl;
        }

    private:
        Point p1;
        Point p2;
};

class Pose{

    public:
 
        Pose(double x_, double y_, double theta_) {
            x = x_;
            y = y_;
            theta = theta_;
        }

        void print() {
            std::cout << "Pose: (" << x << ", " << y << ", " << theta << ")" << '\n';
        }

        double _getX() {
            return x;
        }

        double _getY() {
            return y;
        }

        double _getTheta() {
            return theta;
        }

    private:
        double x;
        double y;
        double theta;

};

class Intersections {
public:

    Intersections() {

        const char* path_to_maze = "/home/ras19/catkin_ws/src/gp9_localization/src/maze.txt";
        
        std::string line;
        std::string past_value;
        std::ifstream myfile;
        myfile.open(path_to_maze, std::ifstream::in);

        if (myfile.is_open()) {

            std::deque<Point> points;
            boost::char_separator<char> sep(" ");
            int i = 0;
            while(getline(myfile, line)){
                
                boost::tokenizer< boost::char_separator<char> > values(line, sep);
                BOOST_FOREACH (const std::string& value, values) {
                    i++;
                    if (i % 2 == 0){
                        double x = atof(past_value.c_str());
                        double y = atof(value.c_str());
                        Point p = Point(x, y);
                        points.push_back(p);
                    }
                    past_value = value;
                }
            }

            Point past_point;
            std::deque<Point>::iterator it = points.begin();
            i = 0;
            while (it != points.end()) {
                i++;
                Point point = *it++;
                if (i % 2 == 0){
                        Line l = Line(past_point, point);
                        walls.push_back(l);
                    }
                past_point = point;
            }

            myfile.close();
        }

        else std::cout << "Unable to open file";
    }

    void printWalls() {
        std::deque<Line>::iterator it = walls.begin();
        while (it != walls.end()) {
            Line wall = *it++;
            wall.print();
        }
    }

    Line extendLine(Pose &pose, double dtheta) {
        double line_range = 100;
        double pose_x = pose._getX();
        double pose_y = pose._getY();
        double pose_theta = pose._getTheta();
        double ray_angle = pose_theta + dtheta;

        double x2 = pose_x + line_range * cos(ray_angle);
        double y2 = pose_y + line_range * sin(ray_angle);

        Point p1(pose_x, pose_y);
        Point p2(x2, y2);
        return Line(p1, p2);
    }

    std::deque<double> findIntersections(Pose &pose, int num_measurements) {
        Point pose_point = Point(pose._getX(), pose._getY());
        std::deque<double> intersection_distances;

        double delta_angle = 2 * M_PI / num_measurements;

        for (double angle = M_PI; angle < 3 * M_PI; angle += delta_angle) {
            Line extended_line = extendLine(pose, angle);
            double min_distance = 1000;


            std::deque<Line>::iterator it = walls.begin();
            while (it != walls.end()) {
                
                Line wall = *it++;
                bool intersects = false;
                double distance = extended_line.intersect_dist(wall, intersects);
                if (intersects && distance < min_distance) {
                    min_distance = distance;
                } 
            }
            intersection_distances.push_back(min_distance);
        }
        return intersection_distances;
    }


    void loopThroughDeque(std::deque<double> &distances) {
        // Example code for how to loop through a deque
        int num_measurements = 30;
        double theta_robot = 0;

        double delta_angle = 2 * M_PI / num_measurements;
        int j = 0;
        std::deque<double>::iterator it = distances.begin();
        while (it != distances.end()) {
            double distance = *it++;
            double angle = theta_robot + j * delta_angle;
            std::cout << "Distance: " << distance << std::endl;
            std::cout << "Angle   : " << angle << std::endl;
            j++;
        }
    }

    private:

        std::deque<Line> walls;

};
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////

class ParticleFilter {
public:
    /* ros */
	ros::NodeHandle nh;
	/* Subscribers and publishers */
    ros::Subscriber sub_lidar;
    ros::Subscriber sub_pose;
    ros::Subscriber sub_emergency;
    ros::Publisher pub_weight_pose;
    ros::Publisher pub_corrected_pose;
    ros::Publisher pub_object_marker_array;
    visualization_msgs::Marker marker;
    visualization_msgs::MarkerArray marker_array;

    ParticleFilter() {
        n_measurements = 30;
        n_particles = 500;
        particles = std::vector<std::vector<double> >(4, std::vector<double>(n_particles, 0));
        particles_res = std::vector<std::vector<double> >(4, std::vector<double>(n_particles, 0));
        std_x = 0.05;
        std_y = 0.05;
        std_theta = 0.2;
        std_meas = 0.000001;
        lambda = -1;//0.0001;

        start_pose[0] = 0.225;
        start_pose[1] = 0.225;
        start_pose[2] = 0.5*M_PI;

        last_pose[0] = 0.225;
        last_pose[1] = 0.225;
        last_pose[2] = 0.5*M_PI;

        x_old = start_pose[0];
        y_old = start_pose[1];
        theta_old = start_pose[2];
        dx = 0;
        dy = 0;
        dtheta = 0;

        lidar_offset = -0.06;
        emergency = false;
        init_flag =  0;

        sub_pose = nh.subscribe<geometry_msgs::Pose2D>("/pose", 1, &ParticleFilter::odometryCallBack, this);
        sub_lidar = nh.subscribe<sensor_msgs::LaserScan>("/scan", 1, &ParticleFilter::lidarCallBack, this);
        sub_emergency = nh.subscribe<std_msgs::Bool>("/emergency_break", 1, &ParticleFilter::emergencyCallBack, this);
        pub_weight_pose = nh.advertise<geometry_msgs::Pose2D>("/corrected_pose", 1);
        pub_corrected_pose = nh.advertise<visualization_msgs::Marker>("/visualization_filter", 1);
        pub_object_marker_array = nh.advertise<visualization_msgs::Marker>("/particle/points", 100);
        initParticles();
    }

    void initParticles() {
        random_numbers::RandomNumberGenerator gen;

        if(init_flag == 0) {
            n_particles = 500;
            particles = std::vector<std::vector<double> >(4, std::vector<double>(n_particles, 0));
            particles_res = std::vector<std::vector<double> >(4, std::vector<double>(n_particles, 0));
            for(int i = 0; i < n_particles; i++) {
                particles[0][i] = start_pose[0];
                particles[1][i] = start_pose[1];
                particles[2][i] = start_pose[2];
                particles[3][i] = 1.0/n_particles;
            }
        }
        else if(init_flag == 1) {
            n_particles = 1000;
            particles = std::vector<std::vector<double> >(4, std::vector<double>(n_particles, 0));
            particles_res = std::vector<std::vector<double> >(4, std::vector<double>(n_particles, 0));
            for(int i = 0; i < n_particles; i++) {
                particles[0][i] = gen.uniform01()-0.5+last_pose[0];
                particles[1][i] = gen.uniform01()-0.5+last_pose[1];
                particles[2][i] = gen.uniform01()-0.5+last_pose[2];
                particles[3][i] = 1.0/n_particles;
            }
        }
        else {
            n_particles = 2000;
            particles = std::vector<std::vector<double> >(4, std::vector<double>(n_particles, 0));
            particles_res = std::vector<std::vector<double> >(4, std::vector<double>(n_particles, 0));
            for(int i = 0; i < n_particles; i++) {
                particles[0][i] = gen.uniform01()*2.4;
                particles[1][i] = gen.uniform01()*2.4;
                particles[2][i] = gen.uniform01()*2*M_PI;
                particles[3][i] = 1.0/n_particles;
            }
        }
    }


    void predict() {
        random_numbers::RandomNumberGenerator gen;
        for(int i = 0; i < n_particles; i++) {
            particles[0][i] += gen.gaussian(dx, std_x);
            if (particles[0][i] < 0) {
                particles[0][i] = 0.0001;
            }
            else if (particles[0][i] > 2.4) {
                particles[0][i] = 2.3999;
            }

            particles[1][i] += gen.gaussian(dy, std_y);
            if (particles[1][i] < 0) {
                particles[1][i] = 0.0001;
            }
            else if (particles[1][i] > 2.4) {
                particles[1][i] = 2.3999;
            }

            particles[2][i] += gen.gaussian(dtheta, std_theta);
            if(particles[2][i] < 0) {
                particles[2][i] += 2*M_PI;
            } 
            else if(particles[2][i] > 2*M_PI) {
                particles[2][i] -= 2*M_PI;
            }
        }
    }

    void associate() {
        double psi[n_particles][n_measurements];
        std::vector<double> psi_means = std::vector<double>(n_measurements, 0);
        bool outliers[n_measurements];
        for(int i = 0; i < n_particles; i++) {
            Pose pose = Pose(particles[0][i]+lidar_offset*cos(particles[2][i]), particles[1][i]+lidar_offset*sin(particles[2][i]), particles[2][i]);
            std::deque<double> z_hat = intersections.findIntersections(pose, n_measurements);
            for(int j = 0; j < n_measurements; j++) {
                if(isinf(measurements[j])) {
                    psi[i][j] = 0;
                } else {
                    double nu = measurements[j] - z_hat[j];
                    //ROS_INFO("DIFFERENCE INNOVATION \n MODEL: %f \n MEASUREMENT: %f \n", z_hat[j],measurements[j]);
                    psi[i][j] = exp(-(0.5*pow(nu, 2))/std_meas);///(std_meas*sqrt(2*M_PI));
                }
                psi_means[j] += psi[i][j]/n_particles;
            }
        }
        int n_outliers = 0;
        for(int i = 0; i < n_measurements; i++){
            if(psi_means[i] < lambda) {
                outliers[i] = true;
                n_outliers++;
            } else {
                outliers[i] = false;
            }
        }
        ROS_INFO("NUM OUTLIERS: %i", n_outliers);

        double weight_sum = 0;
        for(int i = 0; i < n_particles; i++) {
            double sum_psi = 0;
            for(int j = 0; j < n_measurements; j++) {
                if (!outliers[j]) {
                    sum_psi += psi[i][j];
                }
            }
            weight_sum += sum_psi;
            particles[3][i] = sum_psi;
            //ROS_INFO("WEIGHT: %lf", particles[3][i]);
        }

        //ROS_INFO("WEIGHT SUM: %f", prod_sum);
        
        for(int i = 0; i < n_particles; i++) {
            particles[3][i] /= weight_sum;
        }
    }

    void associate2() {
        double psi[n_particles];
        for(int i = 0; i < n_particles; i++) {
            Pose pose = Pose(particles[0][i], particles[1][i], particles[2][i]);
            z_hat = intersections.findIntersections(pose, n_measurements);
            double nu = calcInnovation();
            if (nu == 0) {
                psi[i] = 0;
            } else {
                psi[i] = pow(10, 20)*exp(-0.5*pow(nu, 2)/std_meas);
                //ROS_INFO("PSI %f",  psi[i]);
            }   
            
        }
        double norm_sum = 0;
        for(int i = 0; i < n_particles; i++) {
            norm_sum += psi[i];
            particles[3][i] = psi[i];
            //ROS_INFO("WEIGHT: %f", particles[3][i]);
        }
        
        //ROS_INFO("NORM %f", norm_sum);
        for(int i = 0; i < n_particles; i++) {
            particles[3][i] /= norm_sum;
            //ROS_INFO("x: %f, y: %f, theta: %f, w: %lf", particles[0][i], particles[1][i], particles[2][i], particles[3][i]);
        }
    }

    double calcInnovation() {
        double nu = 0;
        for(int j = 0; j < n_measurements; j++) {
            if(!isinf(measurements[j])) {
                nu += pow(measurements[j]-z_hat[j], 2);
                //ROS_INFO("DIFFERENCE INNOVATION MODEL AND MEASUREMENT: %f \n", measurements[j]-z_hat[j]);
            }
        }
        nu = sqrt(nu);
        return nu;
    }

    void systematicResample() {
        double cumsum[n_particles];
        cumsum[0] = particles[3][0];
        for(int i = 1; i < n_particles ; i++) {
            cumsum[i] = cumsum[i-1] + particles[3][i];
        }

        srand(time(0));
        double r_0 = (rand()%100 / (double)101) /n_particles;
        //ROS_INFO("R0: %f", r_0);
        int ind = 0;
        for(int i = 0; i < n_particles ; i++) {
            for(int j = 0; j < n_particles ; j++) {
                if(cumsum[j] >= r_0) {
                    ind = j;
                    break;
                }
            }
            for(int j = 0 ; j < 3 ; j++) {
                particles_res[j][i] = particles[j][ind];
            }
            particles_res[3][i] = 1.0/n_particles;
            r_0 += 1.0/n_particles;
        }
        
        particles = particles_res;
        
    }

    void MCL() {
        //if(!emergency) {
            predict();
            associate();
            pubParticles(0);
            systematicResample();
            pubParticles(1);
            weightedAveragePosePublisher();
        //}
        //else {
            //init_flag = 1;
            //initParticles();
            //emergency = false;
        //}
    }


    void odometryCallBack(const geometry_msgs::Pose2D::ConstPtr &msg) {
        double x_new = msg->x;
        double y_new = msg->y;
        double theta_new = msg->theta;

        dx = x_new - x_old;
        dy = y_new - y_old;
        dtheta = theta_new - theta_old;
        x_old = x_new;
        y_old = y_new;
        theta_old = theta_new;
    }

    void lidarCallBack(const sensor_msgs::LaserScan::ConstPtr &msg) {
        int c = 0;
        int sz = msg->ranges.size()/n_measurements;
        for(int i = 0 ; i < msg->ranges.size() ; i++) {
            if (i % sz == 0) {
                measurements[c] = msg->ranges[i];
                c++;
            }
        }
    }

    void emergencyCallBack(const std_msgs::Bool::ConstPtr &msg) {
        emergency = msg->data;
    }

    void weightedAveragePosePublisher() {
        geometry_msgs::Pose2D pose;
        pose.x = 0;
        pose.y = 0;
        pose.theta = 0;

        double sum_sin = 0;
        double sum_cos = 0;

        for(int i = 0 ; i < n_particles ; i++) {
            pose.x += particles[0][i];
            pose.y += particles[1][i];

            sum_sin += sin(particles[2][i]);
            sum_cos += cos(particles[2][i]);
            // ROS_INFO("x: %f, y: %f, theta: %f, w: %lf", particles[0][i], particles[1][i], particles[2][i], particles[3][i]);
        }
        pose.theta = atan2(sum_sin, sum_cos);
        if(pose.theta < 0) {
            pose.theta += 2*M_PI;
        }

        pose.x /= n_particles;
        pose.y /= n_particles;

        last_pose[0] = pose.x;
        last_pose[1] = pose.y;
        last_pose[2] = pose.theta;

        pub_weight_pose.publish(pose);
        showPose(pose);
    }

    void showPose(geometry_msgs::Pose2D &corrected_pose) {

        visualization_msgs::Marker marker;
        geometry_msgs::Quaternion odom_quat = tf::createQuaternionMsgFromYaw(corrected_pose.theta);
        
        marker.header.frame_id = "map";
        marker.header.stamp = ros::Time();
        marker.ns = "my_namespace";
        marker.id = 0;
        marker.type = visualization_msgs::Marker::ARROW;
        marker.action = visualization_msgs::Marker::ADD;
        marker.pose.position.x = corrected_pose.x;
        marker.pose.position.y = corrected_pose.y;
        marker.pose.position.z = 0;
        marker.pose.orientation = odom_quat;
        marker.scale.x = 0.2;
        marker.scale.y = 0.05;
        marker.scale.z = 0.05;
        marker.color.a = 0.9; // Don't forget to set the alpha!
        marker.color.r = 0.0;
        marker.color.g = 1.0;
        marker.color.b = 0.2;
        pub_corrected_pose.publish(marker);
    }


    void pubParticles(int before){

        visualization_msgs::Marker points;
        points.header.frame_id = "map";
        points.header.stamp = ros::Time::now();
        points.ns = "points_and_lines";
        points.action = visualization_msgs::Marker::ADD;
        points.pose.orientation.w = 1.0;

        points.id = 1;

        points.type = visualization_msgs::Marker::POINTS;

        points.scale.x = 0.02;
        points.scale.y = 0.02;
        if(before == 0){
            points.color.r = 1.0f;
            points.color.g = 1.0f;
            points.color.b = 1.0f;
        }
        if(before == 1){
            points.color.r = 0;
            points.color.g = 0;
            points.color.b = 1.0;
        }
        
        points.color.a = 0.2;
        
        

        for(int i = 0; i < n_particles ; i++) {
            geometry_msgs::Point p;
            p.x = particles_res[0][i];
            p.y = particles_res[1][i];
            p.z = 0;
            points.points.push_back(p);
            pub_object_marker_array.publish(points);
        } 
    }

private:
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
    double last_pose[3];

    double bounds[4];

    double lidar_offset;
    bool emergency;
    int init_flag;

    Intersections intersections;
    std::deque<double> z_hat;
};

int main(int argc, char** argv) {
    int control_frequency = 5;

    ros::init(argc, argv, "particle_filter");
    ParticleFilter pf;
    ros::Rate rate(control_frequency);
    
    while (pf.nh.ok()) {
        ros::spinOnce();
        pf.MCL();
        rate.sleep();
    }
    return 0;
}