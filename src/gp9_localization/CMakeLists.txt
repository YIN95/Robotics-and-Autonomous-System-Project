cmake_minimum_required(VERSION 2.8.3)
project(gp9_localization)

find_package(catkin REQUIRED COMPONENTS
  geometry_msgs
  roscpp
  rospy
  std_msgs
  random_numbers
)

catkin_package(
#  INCLUDE_DIRS include
#  LIBRARIES gp9_localization
#  CATKIN_DEPENDS geometry_msgs roscpp rospy std_msgs
#  DEPENDS system_lib
)

include_directories(
  include
  ${catkin_INCLUDE_DIRS}
)

add_executable(particle_filter src/particle_filter.cpp)
target_link_libraries(particle_filter ${catkin_LIBRARIES})

add_executable(intersection src/intersection.cpp)
target_link_libraries(intersection ${catkin_LIBRARIES})
