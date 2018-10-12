#include "ros/ros.h"
#include <pcl_ros/point_cloud.h>
#include <pcl/point_types.h>
#include <boost/foreach.hpp>
#include <vector>


class ObjectDetection{
public: /* ros */
	ros::NodeHandle nh;
	/* Subscribers and publishers */
	ros::Subscriber sub_pointcloud;
	ros::Publisher pub_pointcloud;

	pcl::PointCloud<pcl::PointXYZRGB>::Ptr rgb_cloud;
	pcl::PointCloud<pcl::PointXYZRGB>::Ptr res_cloud;
    pcl::PointCloud<pcl::PointXYZHSV>::Ptr hsv_cloud;


public: /* Functions */
	/* Constructor Functions */
	ObjectDetection();

	void pointCloudCallback(const pcl::PointCloud<pcl::PointXYZRGB>::ConstPtr &msg);
	void pubCloud();
	void detectObject();
	void cleanData();
	void clusterObject();
	void checkColor(int h);
    void dimFilter(std::string dim, double lower_bound, double upper_bound, bool inv_cond);
	void colorFilter(std::string dim, double lower_bound, double upper_bound, bool inv_cond);
	void makeVoxelGrid();
	void removeOutliers();
	void checkSize();
	bool objectInImage();
	void PointCloudXYZHSVtoXYZRGB(pcl::PointCloud<pcl::PointXYZHSV>& in, pcl::PointCloud<pcl::PointXYZRGB>& out);
	void PointCloudXYZRGBtoXYZHSV(pcl::PointCloud<pcl::PointXYZRGB>& in, pcl::PointCloud<pcl::PointXYZHSV>& out);
private:
        double color_lim_s;
};