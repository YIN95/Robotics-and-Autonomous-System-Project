#include "tf_robot_camera.h"
#include <math.h>

double degreeToRadian(double deg) {
    return deg * (M_PI / 180);
}

int main(int argc, char** argv){
    ros::init(argc, argv, "tf_robot_camera");
    TF_Robot_Camera TF;
    ros::Rate rate(10);
    

    while(TF.nh.ok()) {
        TF.setTransform();
        rate.sleep();
    }

}

void TF_Robot_Camera::setTransform() {
    static tf::TransformBroadcaster br;
    tf::Transform transform;
    transform.setOrigin(tf::Vector3(0.105, 0.0, 0.0));
    tf::Quaternion q;
    q.setRPY(0, 0, 0);
    transform.setRotation(q);
    br.sendTransform(tf::StampedTransform(transform, ros::Time::now(), "/robot", "/camera"));
}

TF_Robot_Camera::TF_Robot_Camera() {};