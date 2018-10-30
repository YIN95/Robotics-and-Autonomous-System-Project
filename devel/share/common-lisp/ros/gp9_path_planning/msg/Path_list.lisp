; Auto-generated. Do not edit!


(cl:in-package gp9_path_planning-msg)


;//! \htmlinclude Path_list.msg.html

(cl:defclass <Path_list> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (list
    :reader list
    :initarg :list
    :type (cl:vector geometry_msgs-msg:Pose2D)
   :initform (cl:make-array 0 :element-type 'geometry_msgs-msg:Pose2D :initial-element (cl:make-instance 'geometry_msgs-msg:Pose2D))))
)

(cl:defclass Path_list (<Path_list>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Path_list>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Path_list)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name gp9_path_planning-msg:<Path_list> is deprecated: use gp9_path_planning-msg:Path_list instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <Path_list>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gp9_path_planning-msg:header-val is deprecated.  Use gp9_path_planning-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'list-val :lambda-list '(m))
(cl:defmethod list-val ((m <Path_list>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gp9_path_planning-msg:list-val is deprecated.  Use gp9_path_planning-msg:list instead.")
  (list m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Path_list>) ostream)
  "Serializes a message object of type '<Path_list>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'list))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'list))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Path_list>) istream)
  "Deserializes a message object of type '<Path_list>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'list) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'list)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'geometry_msgs-msg:Pose2D))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Path_list>)))
  "Returns string type for a message object of type '<Path_list>"
  "gp9_path_planning/Path_list")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Path_list)))
  "Returns string type for a message object of type 'Path_list"
  "gp9_path_planning/Path_list")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Path_list>)))
  "Returns md5sum for a message object of type '<Path_list>"
  "73778bfb1ad292de1879ee4eba0deb12")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Path_list)))
  "Returns md5sum for a message object of type 'Path_list"
  "73778bfb1ad292de1879ee4eba0deb12")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Path_list>)))
  "Returns full string definition for message of type '<Path_list>"
  (cl:format cl:nil "Header header~%geometry_msgs/Pose2D[] list~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Pose2D~%# This expresses a position and orientation on a 2D manifold.~%~%float64 x~%float64 y~%float64 theta~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Path_list)))
  "Returns full string definition for message of type 'Path_list"
  (cl:format cl:nil "Header header~%geometry_msgs/Pose2D[] list~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Pose2D~%# This expresses a position and orientation on a 2D manifold.~%~%float64 x~%float64 y~%float64 theta~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Path_list>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'list) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Path_list>))
  "Converts a ROS message object to a list"
  (cl:list 'Path_list
    (cl:cons ':header (header msg))
    (cl:cons ':list (list msg))
))
