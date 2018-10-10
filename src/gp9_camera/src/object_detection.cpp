#include "gp9_camera/object_detection.h"
#include <vector>
#include <pcl/filters/filter.h>

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
}

void ObjectDetection::clusterObject(){


}

void ObjectDetection::checkColor(){


}

void ObjectDetection::checkSize(){


}

bool ObjectDetection::objectInImage(){
    BOOST_FOREACH(pcl::PointXYZHSV &pt, hsv_cloud.points){
        if(pt.s > color_lim_s) {
            ROS_INFO("Colored object!!!");
        }
        else if(pt.v < 20){
        }
    }
    return true;
}
