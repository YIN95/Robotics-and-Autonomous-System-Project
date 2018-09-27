# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "arduino_servo_control: 0 messages, 1 services")

set(MSG_I_FLAGS "-Istd_msgs:/opt/ros/kinetic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(arduino_servo_control_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_servo_control/srv/SetServoAngles.srv" NAME_WE)
add_custom_target(_arduino_servo_control_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "arduino_servo_control" "/home/ras19/catkin_ws/src/ras_project/ras_servo_control/srv/SetServoAngles.srv" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages

### Generating Services
_generate_srv_cpp(arduino_servo_control
  "/home/ras19/catkin_ws/src/ras_project/ras_servo_control/srv/SetServoAngles.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/arduino_servo_control
)

### Generating Module File
_generate_module_cpp(arduino_servo_control
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/arduino_servo_control
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(arduino_servo_control_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(arduino_servo_control_generate_messages arduino_servo_control_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_servo_control/srv/SetServoAngles.srv" NAME_WE)
add_dependencies(arduino_servo_control_generate_messages_cpp _arduino_servo_control_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(arduino_servo_control_gencpp)
add_dependencies(arduino_servo_control_gencpp arduino_servo_control_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS arduino_servo_control_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages

### Generating Services
_generate_srv_eus(arduino_servo_control
  "/home/ras19/catkin_ws/src/ras_project/ras_servo_control/srv/SetServoAngles.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/arduino_servo_control
)

### Generating Module File
_generate_module_eus(arduino_servo_control
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/arduino_servo_control
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(arduino_servo_control_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(arduino_servo_control_generate_messages arduino_servo_control_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_servo_control/srv/SetServoAngles.srv" NAME_WE)
add_dependencies(arduino_servo_control_generate_messages_eus _arduino_servo_control_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(arduino_servo_control_geneus)
add_dependencies(arduino_servo_control_geneus arduino_servo_control_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS arduino_servo_control_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages

### Generating Services
_generate_srv_lisp(arduino_servo_control
  "/home/ras19/catkin_ws/src/ras_project/ras_servo_control/srv/SetServoAngles.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/arduino_servo_control
)

### Generating Module File
_generate_module_lisp(arduino_servo_control
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/arduino_servo_control
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(arduino_servo_control_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(arduino_servo_control_generate_messages arduino_servo_control_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_servo_control/srv/SetServoAngles.srv" NAME_WE)
add_dependencies(arduino_servo_control_generate_messages_lisp _arduino_servo_control_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(arduino_servo_control_genlisp)
add_dependencies(arduino_servo_control_genlisp arduino_servo_control_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS arduino_servo_control_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages

### Generating Services
_generate_srv_nodejs(arduino_servo_control
  "/home/ras19/catkin_ws/src/ras_project/ras_servo_control/srv/SetServoAngles.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/arduino_servo_control
)

### Generating Module File
_generate_module_nodejs(arduino_servo_control
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/arduino_servo_control
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(arduino_servo_control_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(arduino_servo_control_generate_messages arduino_servo_control_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_servo_control/srv/SetServoAngles.srv" NAME_WE)
add_dependencies(arduino_servo_control_generate_messages_nodejs _arduino_servo_control_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(arduino_servo_control_gennodejs)
add_dependencies(arduino_servo_control_gennodejs arduino_servo_control_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS arduino_servo_control_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages

### Generating Services
_generate_srv_py(arduino_servo_control
  "/home/ras19/catkin_ws/src/ras_project/ras_servo_control/srv/SetServoAngles.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/arduino_servo_control
)

### Generating Module File
_generate_module_py(arduino_servo_control
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/arduino_servo_control
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(arduino_servo_control_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(arduino_servo_control_generate_messages arduino_servo_control_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_servo_control/srv/SetServoAngles.srv" NAME_WE)
add_dependencies(arduino_servo_control_generate_messages_py _arduino_servo_control_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(arduino_servo_control_genpy)
add_dependencies(arduino_servo_control_genpy arduino_servo_control_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS arduino_servo_control_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/arduino_servo_control)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/arduino_servo_control
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(arduino_servo_control_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/arduino_servo_control)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/arduino_servo_control
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(arduino_servo_control_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/arduino_servo_control)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/arduino_servo_control
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(arduino_servo_control_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/arduino_servo_control)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/arduino_servo_control
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(arduino_servo_control_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/arduino_servo_control)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/arduino_servo_control\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/arduino_servo_control
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(arduino_servo_control_generate_messages_py std_msgs_generate_messages_py)
endif()
