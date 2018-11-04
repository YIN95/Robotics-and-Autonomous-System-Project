#include "gp9_localization/particle_filter.h"
#include <random_numbers/random_numbers.h>
#include <iostream>
#include <fstream>
#include <string>
#include <math.h>
#include <deque>
#include <boost/foreach.hpp>
#include <boost/tokenizer.hpp>
#include <std_msgs/Bool.h>

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

ParticleFilter::ParticleFilter() {
    dt = (current_time - last_time).toSec();
    n_measurements = 30;
    n_particles = 500;
    std_x = 0.5;
    std_y = 0.5;
    std_theta = 0.8;
    std_meas = 0.1;
    lambda = 0.0001;

    weight_sum = 1;


    current_time = ros::Time::now();
    last_time = ros::Time::now();
    v = 0;
    w = 0;

    start_pose[0] = 0.225;
    start_pose[1] = 0.225;
    start_pose[2] = 0.5*M_PI;

    global_flag =  false;

    sub_vel = nh.subscribe<geometry_msgs::Twist>("/velocity_estimate", 1, &ParticleFilter::velocityCallBack, this);
    sub_lidar = nh.subscribe<sensor_msgs::LaserScan>("/scan", 1, &ParticleFilter::lidarCallBack, this);
    pub_weight_pose = nh.advertise<geometry_msgs::Pose2D>("/corrected_pose", 1);
    initParticles();
}

void ParticleFilter::initParticles() {
    if(!global_flag) {
        for(int i = 0; i < n_particles; i++) {
            particles[0][i] = start_pose[0];
            particles[1][i] = start_pose[1];
            particles[2][i] = start_pose[2];
            particles[3][i] = 1/n_particles;
        }
    }
    //TODO global localization over whole map (need bounds)
}


void ParticleFilter::predict() {
    current_time = ros::Time::now();
    dt = (current_time - last_time).toSec();
    random_numbers::RandomNumberGenerator gen;
    for(int i = 0; i < n_particles; i++) {
        double theta = particles[2][i];
        particles[0][i] += gen.gaussian(dt*v*cos(theta), std_x);
        particles[1][i] += gen.gaussian(dt*v*sin(theta), std_y);
        particles[2][i] += gen.gaussian(dt*w, std_theta);
        if(particles[2][i] < 0) {
            particles[2][i] += 2*M_PI;
        } else if(particles[2][i] > 2*M_PI) {
            particles[2][i] -= 2*M_PI;
        }
    }
    last_time = current_time;
}

void ParticleFilter::associate() {
    Intersections intersections = Intersections();
    double psi[n_particles][n_measurements];
    double psi_means[n_measurements];
    bool outliers[n_measurements];
    for(int i = 0; i < n_particles; i++) {

        Pose pose = Pose(particles[0][i], particles[1][i], particles[2][i]);
        std::deque<double> z_hat = intersections.findIntersections(pose, n_measurements);
        for(int j = 0; j < n_measurements; j++) {
            if(isinf(measurements[j])) {
                psi[i][j] = 0;
            } else {
                double nu = measurements[j] - z_hat[j];
                //ROS_INFO("DIFFERENCE INNOVATION \n MODEL: %f \n MEASUREMENT: %f \n", z_hat[j],measurements[j]);
                psi[i][j] = exp(-(0.5*pow(nu, 2))/std_meas)/(std_meas*sqrt(2*M_PI));
            }
            psi_means[j] += psi[i][j]/n_particles;
        }
    }
    for(int i = 0; i < n_measurements; i++){
        if(psi_means[i] < lambda) {
            outliers[i] = true;
            ROS_INFO("OUTLIER");
        } else {
            outliers[i] = false;
        }
    }

    weight_sum = 0;
    for(int i = 0; i < n_particles; i++) {
        double prod_psi = 1;
        for(int j = 0; j < n_measurements; j++) {
            if (!outliers[j] && psi[i][j]!=0) {
                prod_psi *= psi[i][j];
            }
        }
        weight_sum += prod_psi;
        particles[3][i] = prod_psi;
    }
    ROS_INFO("WEIGHT SUM: %f", weight_sum);
    for(int i = 0; i < n_particles; i++) {
        particles[3][i] /= weight_sum;
    }

}


void ParticleFilter::systematicResample() {
    random_numbers::RandomNumberGenerator gen;

    double cumsum[n_particles];
    cumsum[0] = particles[3][0];
    for(int i = 1; i < n_particles ; i++) {
        cumsum[i] = cumsum[i-1] + particles[3][i];
    }
    double r_0 = gen.uniform01()/n_particles;
    int ind = 0;
    for(int i = 0; i < n_particles ; i++) {
        for(int j = 0; j < n_particles ; j++) {
            if(r_0 >= cumsum[j]) {
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
    
    //FIX THIS TO BE WITHOUT LOOP
    memcpy(particles, particles_res, sizeof(particles));
}

void ParticleFilter::MCL() {
    predict();
    associate();
    systematicResample();
    weightedAveragePosePublisher();
}


void ParticleFilter::velocityCallBack(const geometry_msgs::Twist::ConstPtr &msg) {
    v = msg->linear.x;
    w = msg->angular.z;
}

void ParticleFilter::lidarCallBack(const sensor_msgs::LaserScan::ConstPtr &msg) {
    int c = 0;
    int sz = msg->ranges.size()/n_measurements;
    for(int i = 0 ; i < msg->ranges.size() ; i++) {
        if (i % sz == 0) {
            measurements[c] = msg->ranges[i];
            c++;
        }
    }
}

void ParticleFilter::weightedAveragePosePublisher() {
    geometry_msgs::Pose2D pose;
    double w_sum = 0;
    for(int i = 0; i < n_particles; i++) {
        w_sum += particles[3][i];
    }

    double weight_pose[3];
    for(int i = 0 ; i < n_particles ; i++) {
        weight_pose[0] += particles[0][i]*particles[3][i]/w_sum;
        weight_pose[1] += particles[1][i]*particles[3][i]/w_sum;
        weight_pose[2] += particles[2][i]*particles[3][i]/w_sum;
    }

    pose.x = weight_pose[0];
    pose.y = weight_pose[1];
    pose.theta = weight_pose[2];

    pub_weight_pose.publish(pose);
}
