cmake_minimum_required(VERSION 2.8.3)
project(gp9_path_follower)

find_package(catkin REQUIRED COMPONENTS
  geometry_msgs
  roscpp
  rospy
  sensor_msgs
  std_msgs
  message_generation
)

catkin_package(
#  INCLUDE_DIRS include
#  LIBRARIES gp9_path_follower
#  CATKIN_DEPENDS geometry_msgs roscpp rospy sensor_msgs std_msgs
#  DEPENDS system_lib
)
include_directories(
  include
  ${catkin_INCLUDE_DIRS}
)

add_service_files(
  FILES
  Rotation.srv
)

add_executable(path_follower src/path_follower.cpp)
target_link_libraries(path_follower ${catkin_LIBRARIES})

add_executable(rotation src/rotation.cpp)
target_link_libraries(rotation ${catkin_LIBRARIES})

# add_executable(intersection src/intersection.cpp)
# target_link_libraries(intersection ${catkin_LIBRARIES})