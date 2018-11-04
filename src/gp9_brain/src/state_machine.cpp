#include <gp9_brain/state_machine.h>

int main(int argc, char** argv) 
{	

	ros::init(argc, argv, "state_machine");
	StateMachine st;

	ros::Rate rate(10);
	
	while (st.nh.ok()) {
        
		ros::spinOnce();
		rate.sleep();
	}
	return 0;
}

StateMachine::StateMachine(){
    currentState = 0;
}