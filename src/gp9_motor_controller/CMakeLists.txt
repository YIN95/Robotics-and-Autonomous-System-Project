cmake_minimum_required(VERSION 2.8.3)
project(gp9_motor_controller)

find_package(catkin REQUIRED COMPONENTS
  phidgets
  roscpp
  rospy
  std_msgs
)

catkin_package(
#  INCLUDE_DIRS include
#  LIBRARIES motor_controller
#  CATKIN_DEPENDS other_catkin_pkg
#  DEPENDS system_lib
)

include_directories(
# include
  ${catkin_INCLUDE_DIRS}
)

include_directories(./include/gp9_motor_controller/)

add_executable(motor_controller src/motor_controller.cpp)
target_link_libraries(motor_controller ${catkin_LIBRARIES})

add_executable(velocity_controller src/velocity_controller.cpp)
target_link_libraries(velocity_controller ${catkin_LIBRARIES})
