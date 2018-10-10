#include "object_detection.h"
#include <vector>

using namespace cv;
using namespace std;


bool detectAndDisplay(Mat frame, CascadeClassifier cascade);

int main(int argc, char** argv) 
{	

	ros::init(argc, argv, "object_detection");
	ros::NodeHandle nh;
	ros::Rate rate(10);

    string cascade_name = "/home/ras29/catkin_ws/src/gp9_realsense/src/cascade.xml";
    CascadeClassifier cascade;
    if(!cascade.load(cascade_name)){ 
        ROS_INFO("Error loading cascade!"); 
        return -1; 
    };
    // Mat img_org = imread("/home/ras29/catkin_ws/src/gp9_realsense/src/testImage.jpg", CV_LOAD_IMAGE_UNCHANGED);
    // Mat img = Mat::zeros(540, 960, CV_8UC3); 
    // resize(img_org, img, img.size());
    ROS_INFO("-=-=-=-=-=-=-=-=-=-=-=-=-=-=-");

    VideoCapture capture;
    capture.open(-1);
    if (! capture.isOpened()){ 
        ROS_INFO("Error opening video capture"); return -1; 
    }
    Mat frame;

    while (capture.read(frame) )
    {
        if(frame.empty())
        {
            ROS_INFO("No captured frame -- Break!");
            break;
        }
        bool key = detectAndDisplay(frame, cascade);
        if (key){
            break;
        }
    } 
    
	return 0;
}

bool detectAndDisplay(Mat frame, CascadeClassifier cascade)
{
    std::vector<Rect> objects;
    Mat frame_gray;

    cvtColor(frame, frame_gray, COLOR_BGR2GRAY);
    equalizeHist(frame_gray, frame_gray);
    //-- Detect objects
    cascade.detectMultiScale(frame_gray, objects, 1.1, 10, 0|CASCADE_SCALE_IMAGE, Size(40, 40));

    for ( size_t i = 0; i < objects.size(); i++ )
    {
        Point center(objects[i].x + objects[i].width/2, objects[i].y + objects[i].height/2);
        // recantagle()
        ellipse(frame, center, Size(objects[i].width/2, objects[i].height/2 ), 0, 0, 360, Scalar( 255, 0, 255 ), 4, 8, 0 );
        Mat objectROI = frame_gray( objects[i] );
    }
    //-- Show what you got
    imshow("RESULT", frame);
    char key = (char)waitKey(10);
    if( key == 27 ){ 
        return true;
    } // escape
    return false;
    destroyWindow("RESULT");
}