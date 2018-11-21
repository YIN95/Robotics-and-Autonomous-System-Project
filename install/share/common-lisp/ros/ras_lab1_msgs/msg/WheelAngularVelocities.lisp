; Auto-generated. Do not edit!


(cl:in-package ras_lab1_msgs-msg)


;//! \htmlinclude WheelAngularVelocities.msg.html

(cl:defclass <WheelAngularVelocities> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (W1
    :reader W1
    :initarg :W1
    :type cl:float
    :initform 0.0)
   (W2
    :reader W2
    :initarg :W2
    :type cl:float
    :initform 0.0))
)

(cl:defclass WheelAngularVelocities (<WheelAngularVelocities>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <WheelAngularVelocities>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'WheelAngularVelocities)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ras_lab1_msgs-msg:<WheelAngularVelocities> is deprecated: use ras_lab1_msgs-msg:WheelAngularVelocities instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <WheelAngularVelocities>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ras_lab1_msgs-msg:header-val is deprecated.  Use ras_lab1_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'W1-val :lambda-list '(m))
(cl:defmethod W1-val ((m <WheelAngularVelocities>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ras_lab1_msgs-msg:W1-val is deprecated.  Use ras_lab1_msgs-msg:W1 instead.")
  (W1 m))

(cl:ensure-generic-function 'W2-val :lambda-list '(m))
(cl:defmethod W2-val ((m <WheelAngularVelocities>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ras_lab1_msgs-msg:W2-val is deprecated.  Use ras_lab1_msgs-msg:W2 instead.")
  (W2 m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <WheelAngularVelocities>) ostream)
  "Serializes a message object of type '<WheelAngularVelocities>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'W1))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'W2))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <WheelAngularVelocities>) istream)
  "Deserializes a message object of type '<WheelAngularVelocities>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'W1) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'W2) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<WheelAngularVelocities>)))
  "Returns string type for a message object of type '<WheelAngularVelocities>"
  "ras_lab1_msgs/WheelAngularVelocities")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'WheelAngularVelocities)))
  "Returns string type for a message object of type 'WheelAngularVelocities"
  "ras_lab1_msgs/WheelAngularVelocities")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<WheelAngularVelocities>)))
  "Returns md5sum for a message object of type '<WheelAngularVelocities>"
  "ae0c4a7348b1a8bfa79b856330d95cad")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'WheelAngularVelocities)))
  "Returns md5sum for a message object of type 'WheelAngularVelocities"
  "ae0c4a7348b1a8bfa79b856330d95cad")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<WheelAngularVelocities>)))
  "Returns full string definition for message of type '<WheelAngularVelocities>"
  (cl:format cl:nil "Header header~%~%float32 W1~%float32 W2~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'WheelAngularVelocities)))
  "Returns full string definition for message of type 'WheelAngularVelocities"
  (cl:format cl:nil "Header header~%~%float32 W1~%float32 W2~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <WheelAngularVelocities>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <WheelAngularVelocities>))
  "Converts a ROS message object to a list"
  (cl:list 'WheelAngularVelocities
    (cl:cons ':header (header msg))
    (cl:cons ':W1 (W1 msg))
    (cl:cons ':W2 (W2 msg))
))
