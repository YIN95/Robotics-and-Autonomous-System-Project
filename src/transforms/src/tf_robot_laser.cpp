#include "tf_robot_laser.h"
#include <math.h>

double degreeToRadian(double deg) {
    return (M_PI / 180) * deg;
}

int main(int argc, char** argv){
    ros::init(argc, argv, "tf_robot_laser");
    TF_Robot_Laser TF;
    ros::Rate rate(10);
    

    while(TF.nh.ok()) {
        TF.setTransform();
        rate.sleep();
    }

}

void TF_Robot_Laser::setTransform() {
    static tf::TransformBroadcaster br;
    tf::Transform transform;
    transform.setOrigin(tf::Vector3(-0.06, 0.0, 0.0));
    tf::Quaternion q;
    q.setRPY(0, 0, degreeToRadian(-5));
    transform.setRotation(q);
    br.sendTransform(tf::StampedTransform(transform, ros::Time::now(), "/robot", "/laser"));
}

TF_Robot_Laser::TF_Robot_Laser() {};
