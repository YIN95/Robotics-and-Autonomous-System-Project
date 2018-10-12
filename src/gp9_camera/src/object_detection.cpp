#include "gp9_camera/object_detection.h"
#include <vector>
#include <pcl/filters/filter.h>
#include <pcl/filters/passthrough.h>
#include <pcl/filters/voxel_grid.h>
#include <pcl/filters/radius_outlier_removal.h>
#include <pcl/point_types_conversion.h>
 #include <pcl/visualization/cloud_viewer.h>
 #include <pcl/filters/extract_indices.h>

int main(int argc, char** argv){
    ros::init(argc, argv, "object_detection");
    ObjectDetection od;
    ros::Rate rate(10);
    while (od.nh.ok()){
        ros::spinOnce();
        od.detectObject(); 
        rate.sleep();
    }
}

ObjectDetection::ObjectDetection(){
    nh = ros::NodeHandle("~");
    sub_pointcloud = nh.subscribe<pcl::PointCloud<pcl::PointXYZRGB> >("/camera/depth_registered/points", 1, &ObjectDetection::pointCloudCallback, this);
    pub_pointcloud = nh.advertise<sensor_msgs::PointCloud2>("/pcl_detection/pcl_cloud", 1);
    rgb_cloud = pcl::PointCloud<pcl::PointXYZRGB>::Ptr(new pcl::PointCloud<pcl::PointXYZRGB>);
    res_cloud = pcl::PointCloud<pcl::PointXYZRGB>::Ptr(new pcl::PointCloud<pcl::PointXYZRGB>);
    hsv_cloud = pcl::PointCloud<pcl::PointXYZHSV>::Ptr(new pcl::PointCloud<pcl::PointXYZHSV>);

    color_lim_s = 0.7;
}

void ObjectDetection::pointCloudCallback(const pcl::PointCloud<pcl::PointXYZRGB>::ConstPtr &msg){

    hsv_cloud = pcl::PointCloud<pcl::PointXYZHSV>::Ptr(new pcl::PointCloud<pcl::PointXYZHSV>);
    rgb_cloud->height = msg->height;
    rgb_cloud->width = msg->width;
    rgb_cloud->points = msg->points;
    cleanData();
}

void ObjectDetection::detectObject(){
    objectInImage();
    //makeVoxelGrid();
    //removeOutliers();
    clusterObject();
    checkSize();
    pubCloud();
}

void ObjectDetection::cleanData(){
    pcl::PointIndices::Ptr inliers(new pcl::PointIndices());
    pcl::ExtractIndices<pcl::PointXYZRGB> extract;
    for (int i = 0; i < rgb_cloud->points.size(); i++){
        if (std::isnan(rgb_cloud->points[i].x)){
            inliers->indices.push_back(i);
        }
    }
    extract.setInputCloud(rgb_cloud);
    extract.setIndices(inliers);
    extract.setNegative(true);
    extract.filter(*rgb_cloud);
}

void ObjectDetection::clusterObject(){


}

void ObjectDetection::checkColor(int h){
    //ROS_INFO("ACTUAL HUE: %i", h);
    if (h>85 && h<140){
        //ROS_INFO("COLOR_GREEN");
    }
    else if (h>36 && h<60){
        //ROS_INFO("COLOR_YELLOW");
    }
    else if (h>85 && h<140){
        //ROS_INFO("COLOR_LIGHT_GREEN");
    }
    else if (h>12 && h<35){
        //ROS_INFO("COLOR_ORANGE");
    }
    else if (h>350 || h<10){
        //ROS_INFO("COLOR_RED");
    }
    else if (h>175 && h<195){
        //ROS_INFO("COLOR_LIGHT_BLUE");
    }
    else if (h>210 && h<250){
        //ROS_INFO("COLOR_BLUE");
    }
    else if (h>265 && h<290){
        //ROS_INFO("COLOR_PURPLE");
    }
}

void ObjectDetection::checkSize(){


}

bool ObjectDetection::objectInImage(){
    dimFilter("z", 0, 0.02, true);
    PointCloudXYZRGBtoXYZHSV(*rgb_cloud, *hsv_cloud);
    colorFilter("s", 0.90, 1, false);
    ROS_INFO("HSV SIZE AFTER FILTER: %i", (int) hsv_cloud->points.size());
    for (size_t i = 0; i < hsv_cloud->points.size(); i++){
        //ROS_INFO("%i, %f, %f, %f, %i, %f, %f", (int) i, hsv_cloud->points[i].x, hsv_cloud->points[i].y, hsv_cloud->points[i].z, (int) hsv_cloud->points[i].h, hsv_cloud->points[i].s, hsv_cloud->points[i].v);
        checkColor((int) hsv_cloud->points[i].h);
    }
    return true;
}

void ObjectDetection::pubCloud(){
    PointCloudXYZHSVtoXYZRGB(*hsv_cloud, *res_cloud);
    pub_pointcloud.publish(res_cloud);
}

void ObjectDetection::dimFilter(std::string dim, double lower_bound, double upper_bound, bool inv_cond){
    pcl::PassThrough<pcl::PointXYZRGB> pass;
    pass.setInputCloud(rgb_cloud);
    pass.setFilterFieldName(dim);
    pass.setFilterLimits(lower_bound, upper_bound);
    pass.setNegative(inv_cond);
    pass.filter(*rgb_cloud);
}

void ObjectDetection::colorFilter(std::string dim, double lower_bound, double upper_bound, bool inv_cond){
    pcl::PassThrough<pcl::PointXYZHSV> pass;
    pass.setInputCloud(hsv_cloud);
    pass.setFilterFieldName(dim);
    pass.setFilterLimits(lower_bound, upper_bound);
    pass.setNegative(inv_cond);
    pass.filter(*hsv_cloud);
}

void ObjectDetection::makeVoxelGrid(){
    pcl::VoxelGrid<pcl::PointXYZHSV> voxel;
    voxel.setInputCloud(hsv_cloud);
    voxel.setLeafSize(0.01, 0.01, 0.01);
    voxel.filter(*hsv_cloud);
}

void ObjectDetection::removeOutliers(){
    pcl::RadiusOutlierRemoval<pcl::PointXYZHSV> outlier_removal;
    outlier_removal.setInputCloud(hsv_cloud);
    outlier_removal.setRadiusSearch(0.01);
    outlier_removal.setMinNeighborsInRadius(10);
    outlier_removal.filter(*hsv_cloud);
}

//Copied and modified from pcl lib
void ObjectDetection::PointCloudXYZHSVtoXYZRGB(pcl::PointCloud<pcl::PointXYZHSV>& in, pcl::PointCloud<pcl::PointXYZRGB>& out){
    out.width   = in.width;
    out.height  = in.height;
    for (size_t i = 0; i < in.points.size (); i++){
        pcl::PointXYZRGB p;
        p.x = in.points[i].x;
        p.y = in.points[i].y;
        p.z = in.points[i].z;
        pcl::PointXYZHSVtoXYZRGB(in.points[i], p);
        out.points.push_back (p);
    }
}

//Copied and modified from pcl lib
void ObjectDetection::PointCloudXYZRGBtoXYZHSV(pcl::PointCloud<pcl::PointXYZRGB>& in, pcl::PointCloud<pcl::PointXYZHSV>& out){
    out.width   = in.width;
    out.height  = in.height;
    for (size_t i = 0; i < in.points.size (); i++){
        pcl::PointXYZHSV p;
        p.x = in.points[i].x;
        p.y = in.points[i].y;
        p.z = in.points[i].z;
        pcl::PointXYZRGBtoXYZHSV(in.points[i], p);
        out.points.push_back (p);
    }
}
