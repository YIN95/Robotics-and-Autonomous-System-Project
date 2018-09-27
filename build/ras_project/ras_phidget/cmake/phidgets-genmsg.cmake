# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "phidgets: 3 messages, 2 services")

set(MSG_I_FLAGS "-Iphidgets:/home/ras19/catkin_ws/src/ras_project/ras_phidget/msg;-Istd_msgs:/opt/ros/kinetic/share/std_msgs/cmake/../msg;-Inav_msgs:/opt/ros/kinetic/share/nav_msgs/cmake/../msg;-Isensor_msgs:/opt/ros/kinetic/share/sensor_msgs/cmake/../msg;-Igeometry_msgs:/opt/ros/kinetic/share/geometry_msgs/cmake/../msg;-Iactionlib_msgs:/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(phidgets_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_phidget/srv/lidar_control.srv" NAME_WE)
add_custom_target(_phidgets_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "phidgets" "/home/ras19/catkin_ws/src/ras_project/ras_phidget/srv/lidar_control.srv" ""
)

get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_phidget/msg/interface_kit_params.msg" NAME_WE)
add_custom_target(_phidgets_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "phidgets" "/home/ras19/catkin_ws/src/ras_project/ras_phidget/msg/interface_kit_params.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_phidget/srv/interface_kit.srv" NAME_WE)
add_custom_target(_phidgets_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "phidgets" "/home/ras19/catkin_ws/src/ras_project/ras_phidget/srv/interface_kit.srv" ""
)

get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_phidget/msg/motor_params.msg" NAME_WE)
add_custom_target(_phidgets_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "phidgets" "/home/ras19/catkin_ws/src/ras_project/ras_phidget/msg/motor_params.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_phidget/msg/motor_encoder.msg" NAME_WE)
add_custom_target(_phidgets_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "phidgets" "/home/ras19/catkin_ws/src/ras_project/ras_phidget/msg/motor_encoder.msg" "std_msgs/Header"
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(phidgets
  "/home/ras19/catkin_ws/src/ras_project/ras_phidget/msg/interface_kit_params.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/phidgets
)
_generate_msg_cpp(phidgets
  "/home/ras19/catkin_ws/src/ras_project/ras_phidget/msg/motor_encoder.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/phidgets
)
_generate_msg_cpp(phidgets
  "/home/ras19/catkin_ws/src/ras_project/ras_phidget/msg/motor_params.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/phidgets
)

### Generating Services
_generate_srv_cpp(phidgets
  "/home/ras19/catkin_ws/src/ras_project/ras_phidget/srv/lidar_control.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/phidgets
)
_generate_srv_cpp(phidgets
  "/home/ras19/catkin_ws/src/ras_project/ras_phidget/srv/interface_kit.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/phidgets
)

### Generating Module File
_generate_module_cpp(phidgets
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/phidgets
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(phidgets_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(phidgets_generate_messages phidgets_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_phidget/srv/lidar_control.srv" NAME_WE)
add_dependencies(phidgets_generate_messages_cpp _phidgets_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_phidget/msg/interface_kit_params.msg" NAME_WE)
add_dependencies(phidgets_generate_messages_cpp _phidgets_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_phidget/srv/interface_kit.srv" NAME_WE)
add_dependencies(phidgets_generate_messages_cpp _phidgets_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_phidget/msg/motor_params.msg" NAME_WE)
add_dependencies(phidgets_generate_messages_cpp _phidgets_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_phidget/msg/motor_encoder.msg" NAME_WE)
add_dependencies(phidgets_generate_messages_cpp _phidgets_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(phidgets_gencpp)
add_dependencies(phidgets_gencpp phidgets_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS phidgets_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(phidgets
  "/home/ras19/catkin_ws/src/ras_project/ras_phidget/msg/interface_kit_params.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/phidgets
)
_generate_msg_eus(phidgets
  "/home/ras19/catkin_ws/src/ras_project/ras_phidget/msg/motor_encoder.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/phidgets
)
_generate_msg_eus(phidgets
  "/home/ras19/catkin_ws/src/ras_project/ras_phidget/msg/motor_params.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/phidgets
)

### Generating Services
_generate_srv_eus(phidgets
  "/home/ras19/catkin_ws/src/ras_project/ras_phidget/srv/lidar_control.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/phidgets
)
_generate_srv_eus(phidgets
  "/home/ras19/catkin_ws/src/ras_project/ras_phidget/srv/interface_kit.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/phidgets
)

### Generating Module File
_generate_module_eus(phidgets
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/phidgets
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(phidgets_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(phidgets_generate_messages phidgets_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_phidget/srv/lidar_control.srv" NAME_WE)
add_dependencies(phidgets_generate_messages_eus _phidgets_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_phidget/msg/interface_kit_params.msg" NAME_WE)
add_dependencies(phidgets_generate_messages_eus _phidgets_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_phidget/srv/interface_kit.srv" NAME_WE)
add_dependencies(phidgets_generate_messages_eus _phidgets_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_phidget/msg/motor_params.msg" NAME_WE)
add_dependencies(phidgets_generate_messages_eus _phidgets_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_phidget/msg/motor_encoder.msg" NAME_WE)
add_dependencies(phidgets_generate_messages_eus _phidgets_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(phidgets_geneus)
add_dependencies(phidgets_geneus phidgets_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS phidgets_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(phidgets
  "/home/ras19/catkin_ws/src/ras_project/ras_phidget/msg/interface_kit_params.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/phidgets
)
_generate_msg_lisp(phidgets
  "/home/ras19/catkin_ws/src/ras_project/ras_phidget/msg/motor_encoder.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/phidgets
)
_generate_msg_lisp(phidgets
  "/home/ras19/catkin_ws/src/ras_project/ras_phidget/msg/motor_params.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/phidgets
)

### Generating Services
_generate_srv_lisp(phidgets
  "/home/ras19/catkin_ws/src/ras_project/ras_phidget/srv/lidar_control.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/phidgets
)
_generate_srv_lisp(phidgets
  "/home/ras19/catkin_ws/src/ras_project/ras_phidget/srv/interface_kit.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/phidgets
)

### Generating Module File
_generate_module_lisp(phidgets
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/phidgets
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(phidgets_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(phidgets_generate_messages phidgets_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_phidget/srv/lidar_control.srv" NAME_WE)
add_dependencies(phidgets_generate_messages_lisp _phidgets_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_phidget/msg/interface_kit_params.msg" NAME_WE)
add_dependencies(phidgets_generate_messages_lisp _phidgets_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_phidget/srv/interface_kit.srv" NAME_WE)
add_dependencies(phidgets_generate_messages_lisp _phidgets_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_phidget/msg/motor_params.msg" NAME_WE)
add_dependencies(phidgets_generate_messages_lisp _phidgets_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_phidget/msg/motor_encoder.msg" NAME_WE)
add_dependencies(phidgets_generate_messages_lisp _phidgets_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(phidgets_genlisp)
add_dependencies(phidgets_genlisp phidgets_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS phidgets_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(phidgets
  "/home/ras19/catkin_ws/src/ras_project/ras_phidget/msg/interface_kit_params.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/phidgets
)
_generate_msg_nodejs(phidgets
  "/home/ras19/catkin_ws/src/ras_project/ras_phidget/msg/motor_encoder.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/phidgets
)
_generate_msg_nodejs(phidgets
  "/home/ras19/catkin_ws/src/ras_project/ras_phidget/msg/motor_params.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/phidgets
)

### Generating Services
_generate_srv_nodejs(phidgets
  "/home/ras19/catkin_ws/src/ras_project/ras_phidget/srv/lidar_control.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/phidgets
)
_generate_srv_nodejs(phidgets
  "/home/ras19/catkin_ws/src/ras_project/ras_phidget/srv/interface_kit.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/phidgets
)

### Generating Module File
_generate_module_nodejs(phidgets
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/phidgets
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(phidgets_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(phidgets_generate_messages phidgets_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_phidget/srv/lidar_control.srv" NAME_WE)
add_dependencies(phidgets_generate_messages_nodejs _phidgets_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_phidget/msg/interface_kit_params.msg" NAME_WE)
add_dependencies(phidgets_generate_messages_nodejs _phidgets_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_phidget/srv/interface_kit.srv" NAME_WE)
add_dependencies(phidgets_generate_messages_nodejs _phidgets_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_phidget/msg/motor_params.msg" NAME_WE)
add_dependencies(phidgets_generate_messages_nodejs _phidgets_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_phidget/msg/motor_encoder.msg" NAME_WE)
add_dependencies(phidgets_generate_messages_nodejs _phidgets_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(phidgets_gennodejs)
add_dependencies(phidgets_gennodejs phidgets_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS phidgets_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(phidgets
  "/home/ras19/catkin_ws/src/ras_project/ras_phidget/msg/interface_kit_params.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/phidgets
)
_generate_msg_py(phidgets
  "/home/ras19/catkin_ws/src/ras_project/ras_phidget/msg/motor_encoder.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/phidgets
)
_generate_msg_py(phidgets
  "/home/ras19/catkin_ws/src/ras_project/ras_phidget/msg/motor_params.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/phidgets
)

### Generating Services
_generate_srv_py(phidgets
  "/home/ras19/catkin_ws/src/ras_project/ras_phidget/srv/lidar_control.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/phidgets
)
_generate_srv_py(phidgets
  "/home/ras19/catkin_ws/src/ras_project/ras_phidget/srv/interface_kit.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/phidgets
)

### Generating Module File
_generate_module_py(phidgets
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/phidgets
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(phidgets_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(phidgets_generate_messages phidgets_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_phidget/srv/lidar_control.srv" NAME_WE)
add_dependencies(phidgets_generate_messages_py _phidgets_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_phidget/msg/interface_kit_params.msg" NAME_WE)
add_dependencies(phidgets_generate_messages_py _phidgets_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_phidget/srv/interface_kit.srv" NAME_WE)
add_dependencies(phidgets_generate_messages_py _phidgets_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_phidget/msg/motor_params.msg" NAME_WE)
add_dependencies(phidgets_generate_messages_py _phidgets_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_phidget/msg/motor_encoder.msg" NAME_WE)
add_dependencies(phidgets_generate_messages_py _phidgets_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(phidgets_genpy)
add_dependencies(phidgets_genpy phidgets_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS phidgets_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/phidgets)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/phidgets
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(phidgets_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()
if(TARGET nav_msgs_generate_messages_cpp)
  add_dependencies(phidgets_generate_messages_cpp nav_msgs_generate_messages_cpp)
endif()
if(TARGET sensor_msgs_generate_messages_cpp)
  add_dependencies(phidgets_generate_messages_cpp sensor_msgs_generate_messages_cpp)
endif()
if(TARGET geometry_msgs_generate_messages_cpp)
  add_dependencies(phidgets_generate_messages_cpp geometry_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/phidgets)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/phidgets
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(phidgets_generate_messages_eus std_msgs_generate_messages_eus)
endif()
if(TARGET nav_msgs_generate_messages_eus)
  add_dependencies(phidgets_generate_messages_eus nav_msgs_generate_messages_eus)
endif()
if(TARGET sensor_msgs_generate_messages_eus)
  add_dependencies(phidgets_generate_messages_eus sensor_msgs_generate_messages_eus)
endif()
if(TARGET geometry_msgs_generate_messages_eus)
  add_dependencies(phidgets_generate_messages_eus geometry_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/phidgets)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/phidgets
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(phidgets_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()
if(TARGET nav_msgs_generate_messages_lisp)
  add_dependencies(phidgets_generate_messages_lisp nav_msgs_generate_messages_lisp)
endif()
if(TARGET sensor_msgs_generate_messages_lisp)
  add_dependencies(phidgets_generate_messages_lisp sensor_msgs_generate_messages_lisp)
endif()
if(TARGET geometry_msgs_generate_messages_lisp)
  add_dependencies(phidgets_generate_messages_lisp geometry_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/phidgets)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/phidgets
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(phidgets_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()
if(TARGET nav_msgs_generate_messages_nodejs)
  add_dependencies(phidgets_generate_messages_nodejs nav_msgs_generate_messages_nodejs)
endif()
if(TARGET sensor_msgs_generate_messages_nodejs)
  add_dependencies(phidgets_generate_messages_nodejs sensor_msgs_generate_messages_nodejs)
endif()
if(TARGET geometry_msgs_generate_messages_nodejs)
  add_dependencies(phidgets_generate_messages_nodejs geometry_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/phidgets)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/phidgets\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/phidgets
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(phidgets_generate_messages_py std_msgs_generate_messages_py)
endif()
if(TARGET nav_msgs_generate_messages_py)
  add_dependencies(phidgets_generate_messages_py nav_msgs_generate_messages_py)
endif()
if(TARGET sensor_msgs_generate_messages_py)
  add_dependencies(phidgets_generate_messages_py sensor_msgs_generate_messages_py)
endif()
if(TARGET geometry_msgs_generate_messages_py)
  add_dependencies(phidgets_generate_messages_py geometry_msgs_generate_messages_py)
endif()
