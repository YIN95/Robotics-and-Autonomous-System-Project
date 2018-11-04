#include "ros/ros.h"
#include <math.h>
#include <vector>
#include <std_msgs/Int32.h>

class StateMachine{
public: /* ros */
	ros::NodeHandle nh;

public:
    StateMachine();      

public:
    unsigned int currentState;
    bool is_moving;
    bool detect_something;
public:
    static const int ST_MOVING_AND_NO_DETECTION = 0;
    static const int ST_MOVING_AND_DETECT_SOMETHING = 1;
    static const int ST_STOP_NOT_DETECT_ANYTHING = 2;
    static const int ST_STUP_AND_DETECT_SOMETHING = 3;
};

