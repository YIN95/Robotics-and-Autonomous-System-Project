#include <ros/ros.h>
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

        const char* path_to_maze = "/home/ras19/catkin_ws/src/gp9_path_planning/maps/maze2018.txt";
        
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


int main (int argc, char** argv) {

    ros::init(argc, argv, "localizer");
    ros::NodeHandle nh;
    ros::Rate rate(10);


    Intersections intersections = Intersections();

    Pose pose = Pose(1.225, 1.225, M_PI);
    int n_particles = 1000;

    
    while (nh.ok()) {

        for (int j = 0; j < n_particles; j++) {
            std::deque<double> d = intersections.findIntersections(pose, 30);
        }

        rate.sleep();

    }

    return 0;
}