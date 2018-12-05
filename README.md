# RAS-GROUP-9
RAS-GROUP-9


## The commands to run  

0. To be able to connect, be on the same wifi as the NUC with your computer.  
``` c++
ssh ras19@192.168.1.18
```

1. First, roscore and source
``` c++
roscore  
```
2. To run the scripts in path planning called tsp.py for global exploration. 
``` py
python tsp.py
```
3. To run the system
``` c++
roslaunch gp9_motor_controller phidgets.launch
roslaunch gp9_brain brain.launch
roslaunch gp9_objects_detection objects_controller.launch
```

4. For phase 1 or 2
``` c++
rosrun gp9_brain state_machine.cpp
rosrun gp9_brain state_machine2.cpp
```
