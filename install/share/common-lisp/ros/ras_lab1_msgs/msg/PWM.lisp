; Auto-generated. Do not edit!


(cl:in-package ras_lab1_msgs-msg)


;//! \htmlinclude PWM.msg.html

(cl:defclass <PWM> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (PWM1
    :reader PWM1
    :initarg :PWM1
    :type cl:integer
    :initform 0)
   (PWM2
    :reader PWM2
    :initarg :PWM2
    :type cl:integer
    :initform 0))
)

(cl:defclass PWM (<PWM>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PWM>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PWM)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ras_lab1_msgs-msg:<PWM> is deprecated: use ras_lab1_msgs-msg:PWM instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <PWM>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ras_lab1_msgs-msg:header-val is deprecated.  Use ras_lab1_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'PWM1-val :lambda-list '(m))
(cl:defmethod PWM1-val ((m <PWM>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ras_lab1_msgs-msg:PWM1-val is deprecated.  Use ras_lab1_msgs-msg:PWM1 instead.")
  (PWM1 m))

(cl:ensure-generic-function 'PWM2-val :lambda-list '(m))
(cl:defmethod PWM2-val ((m <PWM>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ras_lab1_msgs-msg:PWM2-val is deprecated.  Use ras_lab1_msgs-msg:PWM2 instead.")
  (PWM2 m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PWM>) ostream)
  "Serializes a message object of type '<PWM>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let* ((signed (cl:slot-value msg 'PWM1)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'PWM2)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PWM>) istream)
  "Deserializes a message object of type '<PWM>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'PWM1) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'PWM2) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PWM>)))
  "Returns string type for a message object of type '<PWM>"
  "ras_lab1_msgs/PWM")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PWM)))
  "Returns string type for a message object of type 'PWM"
  "ras_lab1_msgs/PWM")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PWM>)))
  "Returns md5sum for a message object of type '<PWM>"
  "7536f824b238f3bc8ae162f5a97c5bfc")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PWM)))
  "Returns md5sum for a message object of type 'PWM"
  "7536f824b238f3bc8ae162f5a97c5bfc")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PWM>)))
  "Returns full string definition for message of type '<PWM>"
  (cl:format cl:nil "# PWM should be between -255 and 255~%# 1 --> left~%# 2 --> right~%Header header~%~%int32 PWM1~%int32 PWM2~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PWM)))
  "Returns full string definition for message of type 'PWM"
  (cl:format cl:nil "# PWM should be between -255 and 255~%# 1 --> left~%# 2 --> right~%Header header~%~%int32 PWM1~%int32 PWM2~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PWM>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PWM>))
  "Converts a ROS message object to a list"
  (cl:list 'PWM
    (cl:cons ':header (header msg))
    (cl:cons ':PWM1 (PWM1 msg))
    (cl:cons ':PWM2 (PWM2 msg))
))
