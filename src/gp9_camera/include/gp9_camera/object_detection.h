#include "ros/ros.h"
#include <pcl_ros/point_cloud.h>
#include <pcl/point_types.h>
#include <boost/foreach.hpp>
#include <vector>


class ObjectDetection{
public: /* ros */
	ros::NodeHandle nh;
	/* Subscribers */
	ros::Subscriber sub_pointcloud;

public: /* Functions */
	/* Constructor Functions */
	ObjectDetection();

	void pointCloudCallback(const pcl::PointCloud<pcl::PointXYZRGB>::ConstPtr &msg);
	void detectObject();
	void cleanData();
	void clusterObject();
	void checkColor();
	void checkSize();
        bool objectInImage();

private:
        pcl::PointCloud<pcl::PointXYZRGB> rgb_cloud;
        pcl::PointCloud<pcl::PointXYZHSV> hsv_cloud;
        int color_lim_s;
	unsigned int height;
	unsigned int width;
};
