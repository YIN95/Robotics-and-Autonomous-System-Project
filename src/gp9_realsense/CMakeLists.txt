cmake_minimum_required(VERSION 2.8.3)
project(gp9_realsense)

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
# include
  ${catkin_INCLUDE_DIRS}
)

include_directories(./include/gp9_realsense/)

add_executable(object_detection src/object_detection.cpp)
target_link_libraries(object_detection ${catkin_LIBRARIES})

add_executable(haar_detect_image src/haar_detect_image.cpp)
target_link_libraries(haar_detect_image ${catkin_LIBRARIES})

add_executable(haar_detect_video src/haar_detect_video.cpp)
target_link_libraries(haar_detect_video ${catkin_LIBRARIES})