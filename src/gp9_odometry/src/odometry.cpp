#include <gp9_odometry/odometry.h>
#include <math.h>

int main(int argc, char** argv){
    int control_frequency = 125;
    
    ros::init(argc, argv, "odometry");
    Odometry odometry(control_frequency);
    ros::Rate rate(control_frequency);

    while (ros::ok()) {
		ros::spinOnce();
        odometry.updateEstimatedOdometry();
		rate.sleep();
		ROS_INFO("|-=-=-=-=-=-=--=-=-=-=-=-=-=-|");
	}
	return 0;
}

Odometry::Odometry(int control_frequency_){
    control_frequency = control_frequency_;
    dt = (current_time - last_time).toSec();
    sub_weighted_pose = nh.subscribe<geometry_msgs::Pose2D>("/corrected_pose", 1, &Odometry::poseCallback, this);
    estimatedSpeed = nh.subscribe<geometry_msgs::Twist>("/velocity_estimate", 1, &Odometry::motorCallbackSpeed, this);
    pub_pose = nh.advertise<geometry_msgs::Pose2D>("/pose", 1);
    pub_uncorrected_pose = nh.advertise<geometry_msgs::Pose2D>("/uncorrected_pose", 1);
    pub_robot_marker = nh.advertise<visualization_msgs::Marker>("/robot/marker", 1);
    pub_moving_state = nh.advertise<std_msgs::Int32>("/state/ismoving", 1);

    current_time = ros::Time::now();
    last_time = ros::Time::now();

    rob_x = 0.225;
    rob_y = 0.225;
    rob_theta = 0.5 * M_PI; // Map is defined so that robot starts along y-axis. Therefore, we rotate it

    rob_x_uncorrected = 0.225;
    rob_y_uncorrected = 0.225;
    rob_theta_uncorrected = 0.5 * M_PI;

    rob_x_v = 0.0;
    rob_y_v = 0.0;
    rob_w = 0.0;
    count_value = 0;
    update_time = 7;

}

void Odometry::updateEstimatedOdometry(){
    updateEstimatedPosition();

    pose.x = rob_x;
    pose.y = rob_y;
    pose.theta = rob_theta;

    pub_pose.publish(pose);
    pub_robot_Pose(rob_x, rob_y);
    last_time = current_time;
    ROS_INFO("rob_x     : %f", rob_x);
    ROS_INFO("rob_y     : %f", rob_y);
    ROS_INFO("rob_theta : %f", rob_theta);
    return;
}


void Odometry::updateEstimatedPosition(){
    updateEstimatedSpeed();
    updateEstimatedDelta();
    rob_x = rob_x + rob_x_delta;
    rob_y = rob_y + rob_y_delta;
    rob_theta = rob_theta + rob_theta_delta;
    if (rob_theta < 0) {
        rob_theta += 2*M_PI;
    }
    else if (rob_theta > 2*M_PI) {
        rob_theta -= 2*M_PI;
    }

    rob_x_uncorrected = rob_x_uncorrected + rob_x_delta;
    rob_y_uncorrected = rob_y_uncorrected + rob_y_delta;
    rob_theta_uncorrected = rob_theta_uncorrected + rob_theta_delta;
    if (rob_theta_uncorrected < 0) {
        rob_theta_uncorrected += 2*M_PI;
    }
    else if (rob_theta_uncorrected > 2*M_PI) {
        rob_theta_uncorrected -= 2*M_PI;
    }

    uncorrected_pose.x = rob_x_uncorrected;
    uncorrected_pose.y = rob_y_uncorrected;
    uncorrected_pose.theta = rob_theta_uncorrected;

    pub_uncorrected_pose.publish(uncorrected_pose);

    return;
}

void Odometry::updateEstimatedDelta(){
    current_time = ros::Time::now();
    dt = (current_time - last_time).toSec();
    rob_x_delta = rob_x_v * dt;
    rob_y_delta = rob_y_v * dt;
    rob_theta_delta = rob_w * dt;

    ROS_INFO("rob_x_delta : %f", rob_x_delta);
    ROS_INFO("rob_y_delta : %f", rob_y_delta);
    ROS_INFO("rob_theta_delta : %f", rob_theta_delta);
    ROS_INFO("dt : %f", dt);

    return;
}

void Odometry::updateEstimatedSpeed(){
    rob_x_v = estimated_v * cos(rob_theta); 
    rob_y_v = estimated_v * sin(rob_theta); 
    rob_w = estimated_w;
    ismoving(rob_x_v, rob_y_v, rob_w);

    if (_ismoving){
        std_msgs::Int32 msg;
        msg.data = 1;
        pub_moving_state.publish(msg);
        ROS_INFO("MOVING");
    }
    else{
        std_msgs::Int32 msg;
        msg.data = 0;
        pub_moving_state.publish(msg);  
        ROS_INFO("STOP");
    }
    ROS_INFO("rob_x_v : %f", rob_x_v);
    ROS_INFO("rob_y_v : %f", rob_y_v);
    ROS_INFO("rob_w : %f", rob_w);
    return;
}

void Odometry::ismoving(double vx, double vy, double w){
    double v1, v2, v3;
    v1 = std::fabs(vx);
    v2 = std::fabs(vy);
    v3 = std::fabs(w);
    if ((v3 > 0.00001) && (v1 > 0.0001) && (v2 > 0.0001)){
        _ismoving = true;
    }
    else{
        _ismoving = false;
    }
    // _ismoving = true;
    
}

void Odometry::motorCallbackSpeed(const geometry_msgs::Twist::ConstPtr &msg){
    estimated_v = msg->linear.x;
    estimated_w = msg->angular.z;
    ROS_INFO("estimated_v : %f", estimated_v);
    ROS_INFO("estimated_w : %f", estimated_w);
    return;
}

void Odometry::poseCallback(const geometry_msgs::Pose2D::ConstPtr &msg){
    count_value++;
    double error_distance = 0;
    double error_angle = 0;
    ROS_INFO("countvalue %d", count_value);

    if (count_value == update_time){
        bool turning = (fabs(estimated_w) > 0.5);

        double error_x = fabs(msg->x - rob_x);
        double error_y = fabs(msg->y - rob_y);
        error_distance = std::max(error_x, error_y);
        error_angle = fabs(msg->theta - rob_theta);

        if ((!turning) && ((error_distance > 0.05) || (error_angle > 0.05))){
            rob_x = msg->x;
            rob_y = msg->y;
            rob_theta = msg->theta;
        }
        
        count_value = 0;
   }

    return;
}


void Odometry::pub_robot_Pose(double x, double y){
    visualization_msgs::Marker marker;
    geometry_msgs::Quaternion odom_quat = tf::createQuaternionMsgFromYaw(rob_theta);
    geometry_msgs::TransformStamped odom_trans;
 
    
    marker.header.frame_id = "map";
    marker.header.stamp = ros::Time();
    marker.ns = "my_namespace";
    marker.id = 0;
    marker.type = visualization_msgs::Marker::ARROW;
    marker.action = visualization_msgs::Marker::ADD;
    marker.pose.position.x = x;
    marker.pose.position.y = y;
    marker.pose.position.z = 0;
    // marker.pose.orientation.x = 0.0;
    // marker.pose.orientation.y = 0.0;
    // marker.pose.orientation.z = 3.1415926/2;
    // marker.pose.orientation.w = 1.0;
    marker.pose.orientation = odom_quat;
    marker.scale.x = 0.2;
    marker.scale.y = 0.1;
    marker.scale.z = 0.1;
    marker.color.a = 0.9; 
    marker.color.r = 1.0;
    marker.color.g = 0;
    marker.color.b = 1.0;
    // marker.mesh_resource = "package://pr2_description/meshes/base_v0/base.dae";
    pub_robot_marker.publish(marker);
}
