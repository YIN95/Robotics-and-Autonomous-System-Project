# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "uarm: 0 messages, 4 services")

set(MSG_I_FLAGS "-Istd_msgs:/opt/ros/kinetic/share/std_msgs/cmake/../msg;-Isensor_msgs:/opt/ros/kinetic/share/sensor_msgs/cmake/../msg;-Igeometry_msgs:/opt/ros/kinetic/share/geometry_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(uarm_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/MoveToJoints.srv" NAME_WE)
add_custom_target(_uarm_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uarm" "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/MoveToJoints.srv" ""
)

get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/AttachDetach.srv" NAME_WE)
add_custom_target(_uarm_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uarm" "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/AttachDetach.srv" ""
)

get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/Pump.srv" NAME_WE)
add_custom_target(_uarm_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uarm" "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/Pump.srv" ""
)

get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/MoveTo.srv" NAME_WE)
add_custom_target(_uarm_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uarm" "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/MoveTo.srv" "geometry_msgs/Point"
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages

### Generating Services
_generate_srv_cpp(uarm
  "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/AttachDetach.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uarm
)
_generate_srv_cpp(uarm
  "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/MoveTo.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uarm
)
_generate_srv_cpp(uarm
  "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/Pump.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uarm
)
_generate_srv_cpp(uarm
  "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/MoveToJoints.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uarm
)

### Generating Module File
_generate_module_cpp(uarm
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uarm
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(uarm_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(uarm_generate_messages uarm_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/MoveToJoints.srv" NAME_WE)
add_dependencies(uarm_generate_messages_cpp _uarm_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/AttachDetach.srv" NAME_WE)
add_dependencies(uarm_generate_messages_cpp _uarm_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/Pump.srv" NAME_WE)
add_dependencies(uarm_generate_messages_cpp _uarm_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/MoveTo.srv" NAME_WE)
add_dependencies(uarm_generate_messages_cpp _uarm_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(uarm_gencpp)
add_dependencies(uarm_gencpp uarm_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS uarm_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages

### Generating Services
_generate_srv_eus(uarm
  "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/AttachDetach.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uarm
)
_generate_srv_eus(uarm
  "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/MoveTo.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uarm
)
_generate_srv_eus(uarm
  "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/Pump.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uarm
)
_generate_srv_eus(uarm
  "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/MoveToJoints.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uarm
)

### Generating Module File
_generate_module_eus(uarm
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uarm
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(uarm_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(uarm_generate_messages uarm_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/MoveToJoints.srv" NAME_WE)
add_dependencies(uarm_generate_messages_eus _uarm_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/AttachDetach.srv" NAME_WE)
add_dependencies(uarm_generate_messages_eus _uarm_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/Pump.srv" NAME_WE)
add_dependencies(uarm_generate_messages_eus _uarm_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/MoveTo.srv" NAME_WE)
add_dependencies(uarm_generate_messages_eus _uarm_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(uarm_geneus)
add_dependencies(uarm_geneus uarm_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS uarm_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages

### Generating Services
_generate_srv_lisp(uarm
  "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/AttachDetach.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uarm
)
_generate_srv_lisp(uarm
  "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/MoveTo.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uarm
)
_generate_srv_lisp(uarm
  "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/Pump.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uarm
)
_generate_srv_lisp(uarm
  "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/MoveToJoints.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uarm
)

### Generating Module File
_generate_module_lisp(uarm
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uarm
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(uarm_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(uarm_generate_messages uarm_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/MoveToJoints.srv" NAME_WE)
add_dependencies(uarm_generate_messages_lisp _uarm_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/AttachDetach.srv" NAME_WE)
add_dependencies(uarm_generate_messages_lisp _uarm_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/Pump.srv" NAME_WE)
add_dependencies(uarm_generate_messages_lisp _uarm_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/MoveTo.srv" NAME_WE)
add_dependencies(uarm_generate_messages_lisp _uarm_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(uarm_genlisp)
add_dependencies(uarm_genlisp uarm_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS uarm_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages

### Generating Services
_generate_srv_nodejs(uarm
  "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/AttachDetach.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uarm
)
_generate_srv_nodejs(uarm
  "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/MoveTo.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uarm
)
_generate_srv_nodejs(uarm
  "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/Pump.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uarm
)
_generate_srv_nodejs(uarm
  "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/MoveToJoints.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uarm
)

### Generating Module File
_generate_module_nodejs(uarm
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uarm
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(uarm_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(uarm_generate_messages uarm_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/MoveToJoints.srv" NAME_WE)
add_dependencies(uarm_generate_messages_nodejs _uarm_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/AttachDetach.srv" NAME_WE)
add_dependencies(uarm_generate_messages_nodejs _uarm_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/Pump.srv" NAME_WE)
add_dependencies(uarm_generate_messages_nodejs _uarm_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/MoveTo.srv" NAME_WE)
add_dependencies(uarm_generate_messages_nodejs _uarm_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(uarm_gennodejs)
add_dependencies(uarm_gennodejs uarm_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS uarm_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages

### Generating Services
_generate_srv_py(uarm
  "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/AttachDetach.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uarm
)
_generate_srv_py(uarm
  "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/MoveTo.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uarm
)
_generate_srv_py(uarm
  "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/Pump.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uarm
)
_generate_srv_py(uarm
  "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/MoveToJoints.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uarm
)

### Generating Module File
_generate_module_py(uarm
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uarm
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(uarm_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(uarm_generate_messages uarm_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/MoveToJoints.srv" NAME_WE)
add_dependencies(uarm_generate_messages_py _uarm_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/AttachDetach.srv" NAME_WE)
add_dependencies(uarm_generate_messages_py _uarm_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/Pump.srv" NAME_WE)
add_dependencies(uarm_generate_messages_py _uarm_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ras19/catkin_ws/src/ras_project/ras_uarm/srv/MoveTo.srv" NAME_WE)
add_dependencies(uarm_generate_messages_py _uarm_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(uarm_genpy)
add_dependencies(uarm_genpy uarm_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS uarm_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uarm)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uarm
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(uarm_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()
if(TARGET sensor_msgs_generate_messages_cpp)
  add_dependencies(uarm_generate_messages_cpp sensor_msgs_generate_messages_cpp)
endif()
if(TARGET geometry_msgs_generate_messages_cpp)
  add_dependencies(uarm_generate_messages_cpp geometry_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uarm)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uarm
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(uarm_generate_messages_eus std_msgs_generate_messages_eus)
endif()
if(TARGET sensor_msgs_generate_messages_eus)
  add_dependencies(uarm_generate_messages_eus sensor_msgs_generate_messages_eus)
endif()
if(TARGET geometry_msgs_generate_messages_eus)
  add_dependencies(uarm_generate_messages_eus geometry_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uarm)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uarm
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(uarm_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()
if(TARGET sensor_msgs_generate_messages_lisp)
  add_dependencies(uarm_generate_messages_lisp sensor_msgs_generate_messages_lisp)
endif()
if(TARGET geometry_msgs_generate_messages_lisp)
  add_dependencies(uarm_generate_messages_lisp geometry_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uarm)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uarm
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(uarm_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()
if(TARGET sensor_msgs_generate_messages_nodejs)
  add_dependencies(uarm_generate_messages_nodejs sensor_msgs_generate_messages_nodejs)
endif()
if(TARGET geometry_msgs_generate_messages_nodejs)
  add_dependencies(uarm_generate_messages_nodejs geometry_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uarm)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uarm\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uarm
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(uarm_generate_messages_py std_msgs_generate_messages_py)
endif()
if(TARGET sensor_msgs_generate_messages_py)
  add_dependencies(uarm_generate_messages_py sensor_msgs_generate_messages_py)
endif()
if(TARGET geometry_msgs_generate_messages_py)
  add_dependencies(uarm_generate_messages_py geometry_msgs_generate_messages_py)
endif()
