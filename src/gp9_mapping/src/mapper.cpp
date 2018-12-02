#include <ros/ros.h>
#include <deque>

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
            return sqrt(pow((other.x - x), 2) + pow((other.y - y), 2));;
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

        int numberOfNeighbors(std::deque<Point> &points, double distanceThreshold) {
            int neighborCounter = 0;
            std::deque<Point>::iterator pointIterator = points.begin();
            while (pointIterator != points.end()) {
                Point point = *pointIterator++;
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

        Segment(Point p1_, Point p2_) {
            p1 = p1_;
            p2 = p2_;
        }

        double distanceFromSegment(Point &point) {
            Point p3 = p2 - p1;
            double tHat = (point - p1).dot(p3) / (pow(p3.norm(), 2));
            double tStar = std::min(std::max(tHat, 0.0), 1.0);
            Point p4 = p3.mult(tStar);
            Point p5 = p1 + p4 - point;
            double distance = p5.norm();
            return distance;
        }

        void findInliers(std::deque<Point> &points, double inlierThreshold) {
            std::deque<Point>::iterator pointIterator = points.begin();
            while (pointIterator != points.end()) {
                Point point = *pointIterator++;
                double distance = distanceFromSegment(point);
                if (distance < inlierThreshold) {
                    inliers.push_back(point);
                }
            }
        }

        void printInliers() {
            std::deque<Point>::iterator it = inliers.begin();
            while (it != inliers.end()) {
                Point point = *it++;
                point.print();
            }
        }

        std::deque<Point> getInliers() {
            return inliers;
        }


    private:
        Point p1;
        Point p2;
        std::deque<Point> inliers;

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
                    Point p1 = points[i];
                    Point p2 = points[j];
                    if (p1 == p2) continue;

                    Segment segment = Segment(p1, p2);
                    segment.findInliers(points, inlierDistanceThreshold);
                    int numInliers = segment.getInliers().size();

                    if (numInliers > bestNumInliers) {
                        bestSegment = segment;
                        bestNumInliers = numInliers;
                    }
                }
            }
            return bestSegment;
        }

        std::deque<Segment> sequentialRANSAC(std::deque<Point> &points, double neighborDistanceThreshold, int numNeighborsThreshold) {
            std::deque<Segment> segments;
            std::deque<Point> remainingPoints = points;
            int wallCounter = 0;

            while (true) {
                Segment segment = RANSAC(remainingPoints);
                std::deque<Point> segmentInliers = segment.getInliers();
                int numInliers = segmentInliers.size();
                if (numInliers < numInliersThreshold) break;
                wallCounter++;

                segments.push_back(segment);

                int numRemainingPoints = remainingPoints.size();
                std::deque<Point> outliers;

                for (int i = 0; i < numRemainingPoints; i++) {
                    Point point = remainingPoints[i];
                    bool found = false;
                    for (int j = 0; j < numInliers; j++) {
                        Point inlierPoint = segmentInliers[j];
                        if (point == inlierPoint) found = true;
                    }

                    if (!found) outliers.push_back(point);
                }

                remainingPoints = outliers;
            }

            Segment segment;
            std::deque<Segment> newWalls;
            int numWalls = segments.size();
            for (int i = 0; i < numWalls; i++)
                segment = segments[i];
                Segment wall = getWall(segment, neighborDistanceThreshold, numNeighborsThreshold);
                newWalls.push_back(wall);

            return newWalls;
        }


        Segment getWall(Segment segment, double neighborDistanceThreshold, int numNeighborsThreshold) {
            std::deque<Point> points = segment.getInliers();
            std::deque<Point> clusteredPoints = findCluster(points, neighborDistanceThreshold, numNeighborsThreshold);
            Segment wall = RANSAC(clusteredPoints);
            return wall;
        }

        std::deque<Point> findCluster(std::deque<Point> &points, double neighborDistanceThreshold, int numNeighborsThreshold) {
            int numPoints = points.size();
            std::deque<Point> pointsInCluster;
            for (int i = 0; i < numPoints; i++) {
                Point point = points[i];
                int numNeighbors = point.numberOfNeighbors(points, neighborDistanceThreshold) - 1; // remove point itself as neighbor
                if (numNeighbors > numNeighborsThreshold) pointsInCluster.push_back(point);
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

    Pose pose = Pose(1, 2, 3);
    pose.print();



    Segment s = Segment(Point(0, 0), Point(2, 0));

    Point p1 = Point(2, 0.5);
    Point p2 = Point(3, 1);
    Point p3 = Point(1, 1);
    Point p4 = Point(4, 4);

    std::deque<Point> dq;
    dq.push_back(p1);
    dq.push_back(p2);
    dq.push_back(p3);
    dq.push_back(p4);

    double threshold = 2;
    s.findInliers(dq, threshold);
    s.printInliers();

    double d = s.distanceFromSegment(p1);

    ROS_INFO("distance: %f", d);


	// while (sl.nh.ok()) {
	// 	ros::spinOnce();
	// 	rate.sleep();
		
	// }

	return 0;
}