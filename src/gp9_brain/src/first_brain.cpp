#include <ros/ros.h>
#include <geometry_msgs/Pose2D.h>

class Brain {

    public:

        ros::NodeHandle nh;
        ros::Subscriber sub_desired_pose;
        ros::Subscriber sub_odom;
        ros::Subscriber sub_lidar;

        ros::Publisher pub_desired_pose;
        ros::Publisher pub_velocity;


        void run() {
            switch (state) {

                case 0:
                    doSomething();
                    break;
                    
                case 1:
                    doSomethingElse();
                    break;

                case 2:
                    doSomethingElse();
                    break;
            }
        }

        

    private:
    
        int state = 0;

};

int main(int argc, char** argv) {

	int control_frequency = 125;

	ros::init(argc, argv, "brain");
	Brain brain;
	ros::Rate rate(control_frequency);

	while (brain.nh.ok()) {
		ros::spinOnce();
        brain.run();
		rate.sleep();
	}

	return 0;
}