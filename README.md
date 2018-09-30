# RAS-GROUP-9
RAS-GROUP-9

## Milestone 1
1. Robot be able to drive in the maze.  
2. Keyboard control.  
3. Have a dead reckoning system (odometry) on the robot. 
4. Use tf (ROS Transform library) to display the position of the robot 
and the current laser scan from the laser in rviz. 

*motor control command*

``` c++
rosrun phidgets motor _serial:=482685 __name:=motor_left _name:=motor_left   
rostopic pub -r 10 /motor_left/cmd_vel std_msgs/Float32 "data: 30.0"   
rosrun phidgets motor _serial:=490601 __name:=motor_right _name:=motor_right   
rostopic pub -r 10 /motor_right/cmd_vel std_msgs/Float32 "data: 30.0"   
```