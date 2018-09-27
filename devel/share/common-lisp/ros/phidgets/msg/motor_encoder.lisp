; Auto-generated. Do not edit!


(cl:in-package phidgets-msg)


;//! \htmlinclude motor_encoder.msg.html

(cl:defclass <motor_encoder> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (count
    :reader count
    :initarg :count
    :type cl:integer
    :initform 0)
   (count_change
    :reader count_change
    :initarg :count_change
    :type cl:integer
    :initform 0))
)

(cl:defclass motor_encoder (<motor_encoder>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <motor_encoder>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'motor_encoder)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name phidgets-msg:<motor_encoder> is deprecated: use phidgets-msg:motor_encoder instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <motor_encoder>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader phidgets-msg:header-val is deprecated.  Use phidgets-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'count-val :lambda-list '(m))
(cl:defmethod count-val ((m <motor_encoder>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader phidgets-msg:count-val is deprecated.  Use phidgets-msg:count instead.")
  (count m))

(cl:ensure-generic-function 'count_change-val :lambda-list '(m))
(cl:defmethod count_change-val ((m <motor_encoder>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader phidgets-msg:count_change-val is deprecated.  Use phidgets-msg:count_change instead.")
  (count_change m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <motor_encoder>) ostream)
  "Serializes a message object of type '<motor_encoder>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let* ((signed (cl:slot-value msg 'count)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'count_change)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <motor_encoder>) istream)
  "Deserializes a message object of type '<motor_encoder>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'count) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'count_change) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<motor_encoder>)))
  "Returns string type for a message object of type '<motor_encoder>"
  "phidgets/motor_encoder")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'motor_encoder)))
  "Returns string type for a message object of type 'motor_encoder"
  "phidgets/motor_encoder")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<motor_encoder>)))
  "Returns md5sum for a message object of type '<motor_encoder>"
  "37e1a519f128a6f4927cf6b14a5ffb50")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'motor_encoder)))
  "Returns md5sum for a message object of type 'motor_encoder"
  "37e1a519f128a6f4927cf6b14a5ffb50")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<motor_encoder>)))
  "Returns full string definition for message of type '<motor_encoder>"
  (cl:format cl:nil "Header header~%int32 count~%int32 count_change~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'motor_encoder)))
  "Returns full string definition for message of type 'motor_encoder"
  (cl:format cl:nil "Header header~%int32 count~%int32 count_change~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <motor_encoder>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <motor_encoder>))
  "Converts a ROS message object to a list"
  (cl:list 'motor_encoder
    (cl:cons ':header (header msg))
    (cl:cons ':count (count msg))
    (cl:cons ':count_change (count_change msg))
))
