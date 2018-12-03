#include <ros/ros.h>
#include <deque>
#include <fstream>
#include <vector>

struct Pose{

    double x, y, theta;

    Pose() {
        x = 0;
        y = 0;
        theta = 0;
    }
    
    Pose(double x_, double y_, double theta_) {
        x = x_;
        y = y_;
        theta = theta_;
    }

    void print() {
        ROS_INFO("Pose: (%f, %f, %f)", x, y, theta);
    }
    
};

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

        Point(const Point &point){
            x = point.x;
            y = point.y;
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

        bool operator==(Point &p) {
            return (x == p.x && y == p.y);
        }

        Point mult(double scalar) {
            return Point(scalar * x, scalar * y);
        }

        double norm() {
            return sqrt(pow(x, 2) + pow(y, 2));
        }

        double dist(Point &other) {
            return sqrt(pow((other.x - x), 2) + pow((other.y - y), 2));
        }

        double cross(Point &other) {
            return x * other.y - y * other.x;
        }

        double dot(Point &other) {
            return x * other.x + y * other.y;
        }

        void print() {
            std::cout << "Point: (" << x << ", " << y << ")" << '\n';
            // ROS_INFO("Point: (%f, %f)", x, y);
        }

        double getX(){
            return x;
        }

        double getY(){
            return y;
        }

        int numberOfNeighbors(std::deque<Point> &points, double distanceThreshold) {

            int neighborCounter = 0;
            std::deque<Point>::iterator pointIterator = points.begin();
            while (pointIterator != points.end()) {
                Point point = Point(*pointIterator++);
                double distance = dist(point);
                if (distance < distanceThreshold) neighborCounter++;
            }
            return neighborCounter;
        }


    private:
        double x;
        double y;

};

class Segment{
    public:

        Segment() {
            p1 = Point();
            p2 = Point();
        }

        Segment(Point &p1_, Point &p2_) {
            p1 = p1_;
            p2 = p2_;
        }

        Segment(const Segment &segment){
            p1 = segment.p1;
            p2 = segment.p2;
            inliers = segment.inliers;
        }


        double distanceFromSegment(Point &point) {
            Point p3 = Point(p2 - p1);
            double tHat = (point - p1).dot(p3) / (pow(p3.norm(), 2));
            double tStar = std::min(std::max(tHat, 0.0), 1.0);
            Point p4 = Point(p3.mult(tStar));
            Point p5 = Point(p1 + p4 - point);
            double distance = p5.norm();
            return distance;
        }

        void findInliers(std::deque<Point> &points, double inlierThreshold) {
            std::deque<Point>::iterator pointIterator = points.begin();
            while (pointIterator != points.end()) {
                Point point = Point(*pointIterator++);
                double distance = distanceFromSegment(point);
                if (distance < inlierThreshold) {
                    inliers.push_back(point);
                }
            }
        }

        void printInliers() {
            std::cout << "Inliers : ";
            std::deque<Point>::iterator it = inliers.begin();
            while (it != inliers.end()) {
                Point point = Point(*it++);
                point.print();
            }
        }

        std::deque<Point> getInliers() {
            return inliers;
        }

        void print() {
            std::cout << "Segment: (" << p1.getX() << ", " << p1.getY() << ")" << "(" << p2.getX() << ", " << p2.getY() << ")" << '\n';
            // ROS_INFO("Point: (%f, %f)", x, y);
        }

        Point getP1(){
            return p1;
        }
        
        Point getP2(){
            return p2;
        }


    private:
        Point p1;
        Point p2;
        std::deque<Point> inliers;

};


class Measurements{
    public:

        Measurements(int numAngles_, double rangeThreshold_) {
            numAngles = numAngles_;
            rangeThreshold = rangeThreshold_;
            pathToMap = "/home/ras29/catkin_ws/src/gp9_map_representation/maps/maze_Trial.txt";
            pathToMeasurements = "/home/ras29/catkin_ws/src/gp9_mapping/measurements/updatetd_measuraments.txt";
            readMap();
            readMeasurements();
            fillInterestingPoints();
        }

        void readMap(){
            std::fstream fin(pathToMap.c_str());
            if (fin){
                double x1, y1, x2, y2;
                while(fin>>x1>>y1>>x2>>y2){
                    Point p1 = Point(x1, y1);
                    Point p2 = Point(x2, y2);
                    Segment wall = Segment(p1, p2);
                    walls.push_back(wall);
                    numWalls++;
                    if (x1 < minX) minX = x1;
                    if (x2 < minX) minX = x2;
                    if (x1 > maxX) maxX = x1;
                    if (x2 > maxX) maxX = x2;
                    if (y1 < minY) minY = y1;
                    if (y2 < minY) minY = y2;
                    if (y1 > maxY) maxY = y1;
                    if (y2 > maxY) maxY = y2;
                }
            }
        }

        void readMeasurements() {
            std::fstream fin(pathToMeasurements.c_str());
            std::vector<bool> indicesToUse(360, false);
            std::vector<double> pose(3,0);
            std::vector<double> ranges(numAngles, 0);
            std::string next_value;
            for (int i = 0; i < 360; i += 360/numAngles) indicesToUse[i] = true;
            
            if (fin){
                int indexOfValue = 0;
                int count = 0;
                while(fin>>next_value){
                    double value = atof(next_value.c_str());
                    if((indexOfValue % 363) == 0){
                        pose[indexOfValue % 363] = value;
                        count = 0;
                        indexOfValue = 0;
                    }
                    else if(((indexOfValue % 363) == 1) || ((indexOfValue % 363) == 2)){
                        pose[indexOfValue % 363] = value;
                    }
                    else if((indexOfValue % 363) == 3){
                        double x = pose[(indexOfValue % 363) - 3];
                        double y = pose[(indexOfValue % 363) - 2];
                        double theta = pose[(indexOfValue % 363) - 1];

                        Pose pose = Pose(x, y, theta);
                        poses.push_back(pose);
                        ranges[0] = value;
                        count ++;
                    }
                    else if((indexOfValue % 363) == 362){
                        measurements.push_back(ranges);
                    }
                    else{
                        if(indicesToUse[(indexOfValue - 3) % 360]) {
                                ranges[count] = value;
                                count ++;
                            }
                    }
                    indexOfValue ++;
                    
                }
                
            }
            int numberOfMeasuraments = measurements.size();
            int numberOfPoses = poses.size();
        }

        void fillInterestingPoints(){
            std::deque<Point> measurementPositions;
            double dAngle = (3 * M_PI - M_PI) / numAngles;

            int numMeasurements = measurements.size();
            for (int i = 0; i < numMeasurements; i++) {
                Pose pose = poses[i];
                std::vector<double> measures = measurements[i];
                for (int j = 0; j < numAngles; j++) {
                    double deltaAngle = M_PI + j*dAngle;
                    double range = measures[j];

                    if (range < 100){

                        double x = pose.x + range * cos(pose.theta + deltaAngle);
                        double y = pose.y + range * sin(pose.theta + deltaAngle);         
                        Point point = Point(x, y);
                        double minDistance = 100;
                        for (int k = 0; k < numWalls; k++) {
                            Segment wall = Segment(walls[k]);
                            double distance = wall.distanceFromSegment(point);
                            if (distance < minDistance) minDistance = distance;
                        }
                        measurementPositions.push_back(point);
                        
                        if(minDistance > rangeThreshold){
                            if ((point.getX() > minX) && (point.getX() < maxX) && (point.getY() > minY) && (point.getY() < maxY)){
                                interestingPoints.push_back(point);
                            }
                        }
                
                    }
                }
            }
        }

        std::deque<Point> getInterestingPoints() {
            return interestingPoints;
        }

    private:
        
        std::string pathToMap;
        std::string pathToMeasurements;
        int numAngles;
        int numWalls;
        double rangeThreshold;
        std::deque<Pose> poses;
        std::deque<Segment> walls;
        std::deque<std::vector<double> > measurements;
        std::deque<Point> interestingPoints;

        double minX, maxX, minY, maxY;

};


class Mapper{
    public:

        Mapper(double inlierDistanceThreshold_, int numInliersThreshold_) {
            inlierDistanceThreshold = inlierDistanceThreshold_;
            numInliersThreshold = numInliersThreshold_;
        }

        Segment RANSAC(std::deque<Point> &points) {
            int numPoints = points.size();
            int bestNumInliers = 0;
            Segment bestSegment = Segment();
            for (int i = 0; i < numPoints; i++) {
                for (int j = 0; j < numPoints; j++) {
                    Point p1 = Point(points[i]);
                    Point p2 = Point(points[j]);
                    if (p1 == p2) continue;

                    Segment segment = Segment(p1, p2);
                    segment.findInliers(points, inlierDistanceThreshold);
                    int numInliers = segment.getInliers().size();
                    if (numInliers > bestNumInliers) {
                        bestSegment = Segment(segment);
                        bestNumInliers = numInliers;
                    }
                }
            }
            int numInliers = bestSegment.getInliers().size();
            return bestSegment;
        }

        std::deque<Segment> sequentialRANSAC(std::deque<Point> &points, double neighborDistanceThreshold, int numNeighborsThreshold) {
            std::deque<Segment> segments;
            std::deque<Point> remainingPoints = points;
            int wallCounter = 0;

            while (true) {
                
                Segment segment = Segment(RANSAC(remainingPoints));
                std::deque<Point> segmentInliers = segment.getInliers();
                int numInliers = segmentInliers.size();
                if (numInliers < numInliersThreshold) break;
                wallCounter++;
                segments.push_back(segment);
                std::cout<<std::endl;
                int numRemainingPoints = remainingPoints.size();
                std::deque<Point> outliers;

                for (int i = 0; i < numRemainingPoints; i++) {
                    Point point = Point(remainingPoints[i]);
                    bool found = false;
                    for (int j = 0; j < numInliers; j++) {
                        Point inlierPoint = Point(segmentInliers[j]);
                        if (point == inlierPoint) found = true;
                    }

                    if (!found) outliers.push_back(point);
                }

                remainingPoints = outliers;
            }

            Segment segment;
            std::deque<Segment> newWalls;
            int numWalls_ = segments.size();
            std::cout<<"Num Walls : "<<numWalls_<<std::endl;
            for (int i = 0; i < numWalls_; i++){
                std::cout<<"Inside : "<<std::endl;
                segment = Segment(segments[i]);

                segment.print();
                Segment wall = Segment(getWall(segment, neighborDistanceThreshold, numNeighborsThreshold));
                    
                wall.print();
                newWalls.push_back(wall);
            }
                

            return newWalls;
        }


        Segment getWall(Segment &segment, double neighborDistanceThreshold, int numNeighborsThreshold) {
            std::deque<Point> points = segment.getInliers();
            std::cout<<"Number of inliers : "<<points.size()<<std::endl;

            std::deque<Point> clusteredPoints = findCluster(points, neighborDistanceThreshold, numNeighborsThreshold);
            std::cout<<"Number of clustered points : "<<clusteredPoints.size()<<std::endl;

            Segment wall = Segment(RANSAC(clusteredPoints));
            return wall;
        }

        std::deque<Point> findCluster(std::deque<Point> &points, double neighborDistanceThreshold, int numNeighborsThreshold) {
            
            int numPoints = points.size();
            std::deque<Point> pointsInCluster;
            for (int i = 0; i < numPoints; i++) {
                Point point = Point(points[i]);
                int numNeighbors = point.numberOfNeighbors(points, neighborDistanceThreshold); // remove point itself as neighbor
                std::cout<<"Number of Neighbors : "<<numNeighbors<<std::endl;
                if (numNeighbors >= numNeighborsThreshold) pointsInCluster.push_back(point);
            }

            return pointsInCluster;
        }

    private:
        double inlierDistanceThreshold;
        int numInliersThreshold;
        std::deque<Point> interestingPoints;

};


int main(int argc, char** argv) {

    ros::init(argc, argv, "mapper");
    ros::NodeHandle nh;
    int control_frequency = 10;
	ros::Rate rate(control_frequency);


     int numAngles = 20;
     double rangeThreshold = 0.15;
     double inlierDistanceThreshold = 0.03;
     int numInliersThreshold = 15;
     double neighborDistanceThreshold = 0.05;
     int numNeighborsThreshold = 1;

     Measurements meas = Measurements(numAngles, rangeThreshold);
     std::deque<Point> ip = meas.getInterestingPoints();

     int n = ip.size();
     std::cout << "Number of interesting points : " << n << std::endl;

     Mapper mapper = Mapper(inlierDistanceThreshold, numInliersThreshold);
     std::deque<Segment> segm = mapper.sequentialRANSAC(ip, neighborDistanceThreshold, numNeighborsThreshold);

     int sg = segm.size();
     std::cout << "Number of segments : " << sg << std::endl;
    for(int i = 0; i < sg; i++){
        segm[i].print();
        // segm[i].printInliers();
        std::cout << "==============================================================" << std::endl;

    }

    //IF SEGMENT (0,0) -> NOT ENOUGH POINTS

	// while (sl.nh.ok()) {
	// 	ros::spinOnce();
	// 	rate.sleep();
		
	// }

	return 0;
}