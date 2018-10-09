#include "object_detection.h"

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
    BOOST_FOREACH (const pcl::PointXYZRGB& pt, msg->points)
       ROS_INFO("\t(%f, %f, %f)\n", pt.x, pt.y, pt.z);
}

void ObjectDetection::detectObject(){
    cleanData();
    clusterObject();
    checkColor();
    checkSize();
}

void ObjectDetection::cleanData(){


}

void ObjectDetection::clusterObject(){


}

void ObjectDetection::checkColor(){


}

void ObjectDetection::checkSize(){


}