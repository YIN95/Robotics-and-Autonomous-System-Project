#include "ros/ros.h"
#include <pcl_ros/point_cloud.h>
#include <pcl/point_types.h>
#include <boost/foreach.hpp>
#include <vector>
#include <sensor_msgs/Image.h>
#include <cv_bridge/cv_bridge.h>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/objdetect.hpp>
#include <opencv2/videoio.hpp>
#include <sensor_msgs/image_encodings.h>
#include <iostream>
#include <stdio.h>
#include <math.h>

class ObjectDetection{
public: /* ros */
	ros::NodeHandle nh;

	/* Subscribers and publishers */
	ros::Subscriber sub_pointcloud;
	ros::Subscriber sub_image_depth;

public:
	pcl::PointCloud<pcl::PointXYZRGB>::Ptr rgb_cloud;
	cv_bridge::CvImagePtr cv_depth_ptr;
public: /* Functions */
	/* Constructor Functions */
	ObjectDetection();
	// int getDepth(int x, int y);
	void pointCloudCallback(const pcl::PointCloud<pcl::PointXYZRGB>::ConstPtr &msg);
	void imageDepthCallback(const sensor_msgs::ImageConstPtr &msg);
	void detectBarrier();
};