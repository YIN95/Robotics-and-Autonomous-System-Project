#include <ros/ros.h>
#include <geometry_msgs/Twist.h>

class VelocityControler{
public:
    double v;
    double w;

public: /* Functions */
	/* Constructor Functions */
	VelocityControler();
	VelocityControler(double v_, double w_);

    /* velocity setting */
    void setV(double v_);
    void setW(double w_);
    void setVW(double v_, double w_);
    
    /* control command */
    void goForward();
    void goBackward();
    void turnLeft();
    void turnRight();
};