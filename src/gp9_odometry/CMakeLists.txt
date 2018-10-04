cmake_minimum_required(VERSION 2.8.3)
project(gp9_odometry)

## Compile as C++11, supported in ROS Kinetic and newer
# add_compile_options(-std=c++11)

## Find catkin macros and libraries
## if COMPONENTS list like find_package(catkin REQUIRED COMPONENTS xyz)
## is used, also find other catkin packages
find_package(catkin REQUIRED COMPONENTS
  phidgets  
  roscpp
  rospy
  std_msgs
)

## System dependencies are found with CMake's conventions
# find_package(Boost REQUIRED COMPONENTS system)

catkin_package(
#  INCLUDE_DIRS include
#  LIBRARIES gp9_odometry
#  CATKIN_DEPENDS roscpp rospy std_msgs
#  DEPENDS system_lib
)

## Specify additional locations of header files
## Your package locations should be listed before other locations
include_directories(
# include
  ${catkin_INCLUDE_DIRS}
)
include_directories(./include/gp9_odometry/)


add_executable(odometry src/odometry.cpp)
target_link_libraries(odometry ${catkin_LIBRARIES})

add_executable(tf_boardcaster src/tf_boardcaster.cpp)
target_link_libraries(tf_boardcaster ${catkin_LIBRARIES})

add_executable(tf_listener_robot src/tf_listener_robot.cpp)
target_link_libraries(tf_listener_robot ${catkin_LIBRARIES})