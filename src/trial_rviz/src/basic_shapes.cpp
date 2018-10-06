#include <ros/ros.h>
#include <visualization_msgs/Marker.h>
#include <nav_msgs/Odometry.h>

class odomPrint
{
    public:
        ros::NodeHandle n;
        ros::Subscriber odom_sub;
        ros::Publisher marker_pub;

        visualization_msgs::Marker marker;

        uint32_t shape;

        odomPrint(){
            n = ros::NodeHandle("~");

            shape = visualization_msgs::Marker::CUBE;

            marker.header.frame_id = "/my_frame";
            marker.ns = "basic_shapes";
            marker.id = 0;
            marker.ns = "basic_shapes";
            marker.id = 0;
            marker.type = shape;
            marker.action = visualization_msgs::Marker::ADD;
            marker.pose.position.x = 0;
            marker.pose.position.y = 0;
            marker.pose.position.z = 0;
            marker.pose.orientation.x = 0.0;
            marker.pose.orientation.y = 0.0;
            marker.pose.orientation.z = 0.0;
            marker.pose.orientation.w = 1.0;
            marker.scale.x = 1.0;
            marker.scale.y = 1.0;
            marker.scale.z = 1.0;
            marker.color.r = 0.0f;
            marker.color.g = 1.0f;
            marker.color.b = 0.0f;
            marker.color.a = 1.0;

            odom_sub = n.subscribe<nav_msgs::Odometry>("/odom", 1, &odomPrint::odomCallback, this);
            marker_pub = n.advertise<visualization_msgs::Marker>("visualization_marker", 1);
        }

        void odomCallback(const nav_msgs::Odometry::ConstPtr &msg) {
            marker.pose.position.x = msg->pose.pose.position.x;
        }

        /*
        void markerPub(){
            marker.header.stamp = ros::Time::now();
            marker.lifetime = ros::Duration();

            
            while (marker_pub.getNumSubscribers() < 1)
            {
                if (!ros::ok())
                {
                return 0;
                }
                ROS_WARN_ONCE("Please create a subscriber to the marker");
                sleep(1);
            }
            
            ros::spinOnce();
            marker_pub.publish(marker);
            switch (shape)
            {
                case visualization_msgs::Marker::CUBE:
                    shape = visualization_msgs::Marker::SPHERE;
                    break;
                case visualization_msgs::Marker::SPHERE:
                    shape = visualization_msgs::Marker::ARROW;
                    break;
                case visualization_msgs::Marker::ARROW:
                    shape = visualization_msgs::Marker::CYLINDER;
                    break;
                case visualization_msgs::Marker::CYLINDER:
                    shape = visualization_msgs::Marker::CUBE;
                    break;
            }
        }
        */
        

    private:

};

int main( int argc, char** argv )
{
    ros::init(argc, argv, "basic_shapes");
    ros::NodeHandle nh;
    ros::Rate rate(10);

    odomPrint odom_print;


    while (ros::ok())
    {
        //odom_print.markerPub();

        odom_print.marker.header.stamp = ros::Time::now();
        odom_print.marker.lifetime = ros::Duration();

            
        while (odom_print.marker_pub.getNumSubscribers() < 1)
        {
            if (!ros::ok())
            {
                return 0;
            }
            ROS_WARN_ONCE("Please create a subscriber to the marker");
            sleep(1);
        }
        odom_print.marker_pub.publish(odom_print.marker);
        switch (odom_print.shape)
            {
                case visualization_msgs::Marker::CUBE:
                    odom_print.shape = visualization_msgs::Marker::SPHERE;
                    break;
                case visualization_msgs::Marker::SPHERE:
                    odom_print.shape = visualization_msgs::Marker::ARROW;
                    break;
                case visualization_msgs::Marker::ARROW:
                    odom_print.shape = visualization_msgs::Marker::CYLINDER;
                    break;
                case visualization_msgs::Marker::CYLINDER:
                    odom_print.shape = visualization_msgs::Marker::CUBE;
                    break;
            }
    
        ros::spinOnce();
        rate.sleep();
    }
}
