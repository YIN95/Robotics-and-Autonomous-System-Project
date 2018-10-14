cmake_minimum_required(VERSION 2.8.3)
project(gp9_objects_detection)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  rospy
  std_msgs
  cv_bridge
  tf
)

catkin_package(
#  INCLUDE_DIRS include
#  LIBRARIES motor_controller
#  CATKIN_DEPENDS other_catkin_pkg
#  DEPENDS system_lib
)

# OpenCV
FIND_PACKAGE(OpenCV REQUIRED )
include_directories(${OpenCV_INCLUDE_DIRS})
link_directories(${OpenCV_LIBRARY_DIRS})
link_libraries(${OpenCV_LIBRARIES})

# PCL
find_package(PCL REQUIRED)
include_directories(${PCL_INCLUDE_DIRS})
link_directories(${PCL_LIBRARY_DIRS})
link_libraries(${PCL_LIBRARIES})

include_directories(
include
  ${catkin_INCLUDE_DIRS}
)


add_executable(objects_detection src/objects_detection.cpp)
target_link_libraries(objects_detection ${catkin_LIBRARIES})
add_dependencies(objects_detection robot_vision_generate_messages_cpp)

add_executable(calibration_util src/calibration_util.cpp)
target_link_libraries(calibration_util ${catkin_LIBRARIES})