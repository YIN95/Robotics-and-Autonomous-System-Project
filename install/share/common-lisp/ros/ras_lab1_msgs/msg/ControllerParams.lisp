; Auto-generated. Do not edit!


(cl:in-package ras_lab1_msgs-msg)


;//! \htmlinclude ControllerParams.msg.html

(cl:defclass <ControllerParams> (roslisp-msg-protocol:ros-message)
  ((K
    :reader K
    :initarg :K
    :type cl:fixnum
    :initform 0)
   (KI
    :reader KI
    :initarg :KI
    :type cl:fixnum
    :initform 0)
   (INT_MAX
    :reader INT_MAX
    :initarg :INT_MAX
    :type cl:fixnum
    :initform 0)
   (ticks
    :reader ticks
    :initarg :ticks
    :type cl:fixnum
    :initform 0)
   (r
    :reader r
    :initarg :r
    :type cl:float
    :initform 0.0)
   (r_l
    :reader r_l
    :initarg :r_l
    :type cl:float
    :initform 0.0)
   (r_r
    :reader r_r
    :initarg :r_r
    :type cl:float
    :initform 0.0)
   (B
    :reader B
    :initarg :B
    :type cl:float
    :initform 0.0))
)

(cl:defclass ControllerParams (<ControllerParams>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ControllerParams>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ControllerParams)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ras_lab1_msgs-msg:<ControllerParams> is deprecated: use ras_lab1_msgs-msg:ControllerParams instead.")))

(cl:ensure-generic-function 'K-val :lambda-list '(m))
(cl:defmethod K-val ((m <ControllerParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ras_lab1_msgs-msg:K-val is deprecated.  Use ras_lab1_msgs-msg:K instead.")
  (K m))

(cl:ensure-generic-function 'KI-val :lambda-list '(m))
(cl:defmethod KI-val ((m <ControllerParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ras_lab1_msgs-msg:KI-val is deprecated.  Use ras_lab1_msgs-msg:KI instead.")
  (KI m))

(cl:ensure-generic-function 'INT_MAX-val :lambda-list '(m))
(cl:defmethod INT_MAX-val ((m <ControllerParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ras_lab1_msgs-msg:INT_MAX-val is deprecated.  Use ras_lab1_msgs-msg:INT_MAX instead.")
  (INT_MAX m))

(cl:ensure-generic-function 'ticks-val :lambda-list '(m))
(cl:defmethod ticks-val ((m <ControllerParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ras_lab1_msgs-msg:ticks-val is deprecated.  Use ras_lab1_msgs-msg:ticks instead.")
  (ticks m))

(cl:ensure-generic-function 'r-val :lambda-list '(m))
(cl:defmethod r-val ((m <ControllerParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ras_lab1_msgs-msg:r-val is deprecated.  Use ras_lab1_msgs-msg:r instead.")
  (r m))

(cl:ensure-generic-function 'r_l-val :lambda-list '(m))
(cl:defmethod r_l-val ((m <ControllerParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ras_lab1_msgs-msg:r_l-val is deprecated.  Use ras_lab1_msgs-msg:r_l instead.")
  (r_l m))

(cl:ensure-generic-function 'r_r-val :lambda-list '(m))
(cl:defmethod r_r-val ((m <ControllerParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ras_lab1_msgs-msg:r_r-val is deprecated.  Use ras_lab1_msgs-msg:r_r instead.")
  (r_r m))

(cl:ensure-generic-function 'B-val :lambda-list '(m))
(cl:defmethod B-val ((m <ControllerParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ras_lab1_msgs-msg:B-val is deprecated.  Use ras_lab1_msgs-msg:B instead.")
  (B m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ControllerParams>) ostream)
  "Serializes a message object of type '<ControllerParams>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'K)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'K)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'KI)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'KI)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'INT_MAX)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'INT_MAX)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ticks)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'ticks)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'r))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'r_l))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'r_r))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'B))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ControllerParams>) istream)
  "Deserializes a message object of type '<ControllerParams>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'K)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'K)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'KI)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'KI)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'INT_MAX)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'INT_MAX)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ticks)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'ticks)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'r) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'r_l) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'r_r) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'B) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ControllerParams>)))
  "Returns string type for a message object of type '<ControllerParams>"
  "ras_lab1_msgs/ControllerParams")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ControllerParams)))
  "Returns string type for a message object of type 'ControllerParams"
  "ras_lab1_msgs/ControllerParams")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ControllerParams>)))
  "Returns md5sum for a message object of type '<ControllerParams>"
  "8950f824993d2867219a00186d4620f7")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ControllerParams)))
  "Returns md5sum for a message object of type 'ControllerParams"
  "8950f824993d2867219a00186d4620f7")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ControllerParams>)))
  "Returns full string definition for message of type '<ControllerParams>"
  (cl:format cl:nil "# PI Control parameters~%uint16 K~%uint16 KI~%uint16 INT_MAX~%uint16 ticks~%~%# Robot dimensions~%float32 r~%float32 r_l~%float32 r_r~%float32 B~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ControllerParams)))
  "Returns full string definition for message of type 'ControllerParams"
  (cl:format cl:nil "# PI Control parameters~%uint16 K~%uint16 KI~%uint16 INT_MAX~%uint16 ticks~%~%# Robot dimensions~%float32 r~%float32 r_l~%float32 r_r~%float32 B~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ControllerParams>))
  (cl:+ 0
     2
     2
     2
     2
     4
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ControllerParams>))
  "Converts a ROS message object to a list"
  (cl:list 'ControllerParams
    (cl:cons ':K (K msg))
    (cl:cons ':KI (KI msg))
    (cl:cons ':INT_MAX (INT_MAX msg))
    (cl:cons ':ticks (ticks msg))
    (cl:cons ':r (r msg))
    (cl:cons ':r_l (r_l msg))
    (cl:cons ':r_r (r_r msg))
    (cl:cons ':B (B msg))
))
