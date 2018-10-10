#include "gp9_camera/object_detection.h"
#include <vector>
<<<<<<< HEAD
#include "pcl/filters/filter.h"
#include "pcl/point_types_conversion.h"
=======
#include <pcl/filters/filter.h>
>>>>>>> 6e7e7c18ef80232176f38f5d0633539c8395f9c2

int main(int argc, char** argv){
    ros::init(argc, argv, "object_detection");
    ObjectDetection od;
    ros::Rate rate(10);
    

    while(od.nh.ok()) {
        ros::spinOnce();
        od.detectObject();
        
        rate.sleep();
    }

}

ObjectDetection::ObjectDetection(){
    //cloud (new pcl::PointCloud<pcl::PointXYZRGB>);
    nh = ros::NodeHandle("~");
    sub_pointcloud = nh.subscribe<pcl::PointCloud<pcl::PointXYZRGB> >("/camera/depth_registered/points", 1, &ObjectDetection::pointCloudCallback, this);
}

void ObjectDetection::pointCloudCallback(const pcl::PointCloud<pcl::PointXYZRGB>::ConstPtr &msg){
    rgb_cloud.points = msg->points;
<<<<<<< HEAD
    std::vector<int> indices;
    //pcl::PointCloud<pcl::PointXYZ> p1;
    //pcl::PointCloud<pcl::PointXYZ> p2;
    //pcl::removeNaNFromPointCloud(*p1, *p2, indices);
    cleanData();
    BOOST_FOREACH(pcl::PointXYZRGB &pt, rgb_cloud.points){
        //ROS_INFO("XYZRGB values:    %f, %f, %f, %i, %i, %i", pt.x, pt.y, pt.z, pt.r, pt.g, pt.b);
    }
    pcl::PointCloudXYZRGBtoXYZHSV(rgb_cloud, hsv_cloud);
}

void ObjectDetection::detectObject(){
    objectInImage();
    clusterObject();
    checkColor();
    checkSize();
    color_lim_s = 0.7;
}

void ObjectDetection::cleanData(){
    //std::vector<int> indices;
    //ROS_INFO("%i", (int) rgb_cloud.points.size());
    //pcl::removeNaNFromPointCloud(rgb_cloud, rgb_cloud, indices);
    //Also remove other unimportant points
    //ROS_INFO("%i", (int) rgb_cloud.points.size());
=======
    cleanData();
}

void ObjectDetection::detectObject(){
    clusterObject();
    checkColor();
    checkSize();
    color_lim_s = 70;
}

void ObjectDetection::cleanData(){
    std::vector<int> indices;
    ROS_INFO("%i", (int) rgb_cloud.points.size());
    pcl::removeNaNFromPointCloud(rgb_cloud, rgb_cloud, indices);
    //Also remove other unimportant points
    ROS_INFO("%i", (int) rgb_cloud.points.size());
>>>>>>> 6e7e7c18ef80232176f38f5d0633539c8395f9c2
}

void ObjectDetection::clusterObject(){


}

void ObjectDetection::checkColor(){


}

void ObjectDetection::checkSize(){


}

bool ObjectDetection::objectInImage(){
    BOOST_FOREACH(pcl::PointXYZHSV &pt, hsv_cloud.points){
<<<<<<< HEAD
        //ROS_INFO("XYZHSV values:    %f, %f, %f, %f, %f, %f", pt.x, pt.y, pt.z, pt.h, pt.s, pt.v);
        if(pt.s > 0.98) {
=======
        if(pt.s > color_lim_s) {
>>>>>>> 6e7e7c18ef80232176f38f5d0633539c8395f9c2
            ROS_INFO("Colored object!!!");
        }
        else if(pt.v < 20){
        }
    }
    return true;
}
