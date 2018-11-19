#include "gp9_camera/barrier_detection.h"
#include <vector>
#include <pcl/filters/filter.h>
#include <pcl/filters/passthrough.h>
#include <pcl/filters/voxel_grid.h>
#include <pcl/filters/radius_outlier_removal.h>
#include <pcl/point_types_conversion.h>
#include <pcl/visualization/cloud_viewer.h>
#include <pcl/filters/extract_indices.h>

int main(int argc, char** argv){
    ros::init(argc, argv, "barrier_detection");
    ObjectDetection od;
    ros::Rate rate(10);
    while (od.nh.ok()){
        ros::spinOnce();
        // od.detectObject(); 
        od.detectBarrier();
        rate.sleep();
    }
}

ObjectDetection::ObjectDetection(){
    nh = ros::NodeHandle("~");
    sub_pointcloud = nh.subscribe<pcl::PointCloud<pcl::PointXYZRGB> >("/camera/depth_registered/points", 1, &ObjectDetection::pointCloudCallback, this);
    sub_image_depth = nh.subscribe<sensor_msgs::Image>("/camera/depth/image_rect", 1, &ObjectDetection::imageDepthCallback, this);

    rgb_cloud = pcl::PointCloud<pcl::PointXYZRGB>::Ptr(new pcl::PointCloud<pcl::PointXYZRGB>);
}

void ObjectDetection::pointCloudCallback(const pcl::PointCloud<pcl::PointXYZRGB>::ConstPtr &msg){
    rgb_cloud->height = msg->height;
    rgb_cloud->width = msg->width;
    rgb_cloud->points = msg->points;
    ROS_INFO("D: %d", rgb_cloud->height);
    double maxheight = 0;
    double minheight = 999;
    double delta = -1;
    for (size_t i = 0; i < rgb_cloud->points.size(); i++){
        
        if (!std::isnan(rgb_cloud->points[i].x)){
            double h = rgb_cloud->points[i].z;
            // ROS_INFO("%i, %f, %f, %f", (int) i, rgb_cloud->points[i].x, rgb_cloud->points[i].y, rgb_cloud->points[i].z);
            if (h > maxheight){
                maxheight = h;
            }
            if (h < minheight){
                minheight = h;
            }
        }
    }
    delta = maxheight - minheight;
    ROS_INFO("max: %f", maxheight);
    ROS_INFO("min: %f", minheight);
    ROS_INFO("delta: %f", delta);
}

void ObjectDetection::detectBarrier(){

}

void ObjectDetection::imageDepthCallback(const sensor_msgs::ImageConstPtr &msg){
    try{
        cv_depth_ptr = cv_bridge::toCvCopy(msg);
        // getDepth(3, 3)
        // , sensor_msgs::image_encodings::mono8
    }
    catch (...){
        return;
    }
    
    cv::imshow("DEPTH_WINDOW", cv_depth_ptr->image);
    cv::waitKey(3);  
}

// int ObjectDetection::getDepth(int x, int y){
//     int depth;
  
//     Mat frame_depth = cv_depth_ptr->image;

//     uchar* d = frame_depth.ptr<uchar>(y);
//     depth = d[2*x] + 255*d[2*x+1];
//     ROS_INFO("depth: %d", depth);
//     return depth;
// }
