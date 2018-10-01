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
    void setV(double v_);
    void setW(double w_);
    void setVW(double v_, double w_);
};