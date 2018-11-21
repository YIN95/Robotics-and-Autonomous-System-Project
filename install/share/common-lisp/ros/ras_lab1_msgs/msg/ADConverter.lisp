; Auto-generated. Do not edit!


(cl:in-package ras_lab1_msgs-msg)


;//! \htmlinclude ADConverter.msg.html

(cl:defclass <ADConverter> (roslisp-msg-protocol:ros-message)
  ((ch1
    :reader ch1
    :initarg :ch1
    :type cl:fixnum
    :initform 0)
   (ch2
    :reader ch2
    :initarg :ch2
    :type cl:fixnum
    :initform 0)
   (ch3
    :reader ch3
    :initarg :ch3
    :type cl:fixnum
    :initform 0)
   (ch4
    :reader ch4
    :initarg :ch4
    :type cl:fixnum
    :initform 0)
   (ch5
    :reader ch5
    :initarg :ch5
    :type cl:fixnum
    :initform 0)
   (ch6
    :reader ch6
    :initarg :ch6
    :type cl:fixnum
    :initform 0)
   (ch7
    :reader ch7
    :initarg :ch7
    :type cl:fixnum
    :initform 0)
   (ch8
    :reader ch8
    :initarg :ch8
    :type cl:fixnum
    :initform 0))
)

(cl:defclass ADConverter (<ADConverter>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ADConverter>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ADConverter)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ras_lab1_msgs-msg:<ADConverter> is deprecated: use ras_lab1_msgs-msg:ADConverter instead.")))

(cl:ensure-generic-function 'ch1-val :lambda-list '(m))
(cl:defmethod ch1-val ((m <ADConverter>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ras_lab1_msgs-msg:ch1-val is deprecated.  Use ras_lab1_msgs-msg:ch1 instead.")
  (ch1 m))

(cl:ensure-generic-function 'ch2-val :lambda-list '(m))
(cl:defmethod ch2-val ((m <ADConverter>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ras_lab1_msgs-msg:ch2-val is deprecated.  Use ras_lab1_msgs-msg:ch2 instead.")
  (ch2 m))

(cl:ensure-generic-function 'ch3-val :lambda-list '(m))
(cl:defmethod ch3-val ((m <ADConverter>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ras_lab1_msgs-msg:ch3-val is deprecated.  Use ras_lab1_msgs-msg:ch3 instead.")
  (ch3 m))

(cl:ensure-generic-function 'ch4-val :lambda-list '(m))
(cl:defmethod ch4-val ((m <ADConverter>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ras_lab1_msgs-msg:ch4-val is deprecated.  Use ras_lab1_msgs-msg:ch4 instead.")
  (ch4 m))

(cl:ensure-generic-function 'ch5-val :lambda-list '(m))
(cl:defmethod ch5-val ((m <ADConverter>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ras_lab1_msgs-msg:ch5-val is deprecated.  Use ras_lab1_msgs-msg:ch5 instead.")
  (ch5 m))

(cl:ensure-generic-function 'ch6-val :lambda-list '(m))
(cl:defmethod ch6-val ((m <ADConverter>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ras_lab1_msgs-msg:ch6-val is deprecated.  Use ras_lab1_msgs-msg:ch6 instead.")
  (ch6 m))

(cl:ensure-generic-function 'ch7-val :lambda-list '(m))
(cl:defmethod ch7-val ((m <ADConverter>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ras_lab1_msgs-msg:ch7-val is deprecated.  Use ras_lab1_msgs-msg:ch7 instead.")
  (ch7 m))

(cl:ensure-generic-function 'ch8-val :lambda-list '(m))
(cl:defmethod ch8-val ((m <ADConverter>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ras_lab1_msgs-msg:ch8-val is deprecated.  Use ras_lab1_msgs-msg:ch8 instead.")
  (ch8 m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ADConverter>) ostream)
  "Serializes a message object of type '<ADConverter>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ch1)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'ch1)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ch2)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'ch2)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ch3)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'ch3)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ch4)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'ch4)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ch5)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'ch5)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ch6)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'ch6)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ch7)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'ch7)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ch8)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'ch8)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ADConverter>) istream)
  "Deserializes a message object of type '<ADConverter>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ch1)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'ch1)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ch2)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'ch2)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ch3)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'ch3)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ch4)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'ch4)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ch5)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'ch5)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ch6)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'ch6)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ch7)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'ch7)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ch8)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'ch8)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ADConverter>)))
  "Returns string type for a message object of type '<ADConverter>"
  "ras_lab1_msgs/ADConverter")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ADConverter)))
  "Returns string type for a message object of type 'ADConverter"
  "ras_lab1_msgs/ADConverter")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ADConverter>)))
  "Returns md5sum for a message object of type '<ADConverter>"
  "a5aa1c52a7841be08d11353384df8a9c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ADConverter)))
  "Returns md5sum for a message object of type 'ADConverter"
  "a5aa1c52a7841be08d11353384df8a9c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ADConverter>)))
  "Returns full string definition for message of type '<ADConverter>"
  (cl:format cl:nil "# 8 * uint16 for IR sensors~%uint16 ch1~%uint16 ch2~%uint16 ch3~%uint16 ch4~%uint16 ch5~%uint16 ch6~%uint16 ch7~%uint16 ch8~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ADConverter)))
  "Returns full string definition for message of type 'ADConverter"
  (cl:format cl:nil "# 8 * uint16 for IR sensors~%uint16 ch1~%uint16 ch2~%uint16 ch3~%uint16 ch4~%uint16 ch5~%uint16 ch6~%uint16 ch7~%uint16 ch8~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ADConverter>))
  (cl:+ 0
     2
     2
     2
     2
     2
     2
     2
     2
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ADConverter>))
  "Converts a ROS message object to a list"
  (cl:list 'ADConverter
    (cl:cons ':ch1 (ch1 msg))
    (cl:cons ':ch2 (ch2 msg))
    (cl:cons ':ch3 (ch3 msg))
    (cl:cons ':ch4 (ch4 msg))
    (cl:cons ':ch5 (ch5 msg))
    (cl:cons ':ch6 (ch6 msg))
    (cl:cons ':ch7 (ch7 msg))
    (cl:cons ':ch8 (ch8 msg))
))
