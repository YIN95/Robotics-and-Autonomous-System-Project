; Auto-generated. Do not edit!


(cl:in-package ras_lab1_msgs-msg)


;//! \htmlinclude Encoders.msg.html

(cl:defclass <Encoders> (roslisp-msg-protocol:ros-message)
  ((encoder1
    :reader encoder1
    :initarg :encoder1
    :type cl:integer
    :initform 0)
   (encoder2
    :reader encoder2
    :initarg :encoder2
    :type cl:integer
    :initform 0)
   (delta_encoder1
    :reader delta_encoder1
    :initarg :delta_encoder1
    :type cl:integer
    :initform 0)
   (delta_encoder2
    :reader delta_encoder2
    :initarg :delta_encoder2
    :type cl:integer
    :initform 0)
   (timestamp
    :reader timestamp
    :initarg :timestamp
    :type cl:integer
    :initform 0))
)

(cl:defclass Encoders (<Encoders>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Encoders>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Encoders)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ras_lab1_msgs-msg:<Encoders> is deprecated: use ras_lab1_msgs-msg:Encoders instead.")))

(cl:ensure-generic-function 'encoder1-val :lambda-list '(m))
(cl:defmethod encoder1-val ((m <Encoders>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ras_lab1_msgs-msg:encoder1-val is deprecated.  Use ras_lab1_msgs-msg:encoder1 instead.")
  (encoder1 m))

(cl:ensure-generic-function 'encoder2-val :lambda-list '(m))
(cl:defmethod encoder2-val ((m <Encoders>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ras_lab1_msgs-msg:encoder2-val is deprecated.  Use ras_lab1_msgs-msg:encoder2 instead.")
  (encoder2 m))

(cl:ensure-generic-function 'delta_encoder1-val :lambda-list '(m))
(cl:defmethod delta_encoder1-val ((m <Encoders>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ras_lab1_msgs-msg:delta_encoder1-val is deprecated.  Use ras_lab1_msgs-msg:delta_encoder1 instead.")
  (delta_encoder1 m))

(cl:ensure-generic-function 'delta_encoder2-val :lambda-list '(m))
(cl:defmethod delta_encoder2-val ((m <Encoders>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ras_lab1_msgs-msg:delta_encoder2-val is deprecated.  Use ras_lab1_msgs-msg:delta_encoder2 instead.")
  (delta_encoder2 m))

(cl:ensure-generic-function 'timestamp-val :lambda-list '(m))
(cl:defmethod timestamp-val ((m <Encoders>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ras_lab1_msgs-msg:timestamp-val is deprecated.  Use ras_lab1_msgs-msg:timestamp instead.")
  (timestamp m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Encoders>) ostream)
  "Serializes a message object of type '<Encoders>"
  (cl:let* ((signed (cl:slot-value msg 'encoder1)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'encoder2)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'delta_encoder1)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'delta_encoder2)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'timestamp)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Encoders>) istream)
  "Deserializes a message object of type '<Encoders>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'encoder1) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'encoder2) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'delta_encoder1) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'delta_encoder2) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'timestamp) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Encoders>)))
  "Returns string type for a message object of type '<Encoders>"
  "ras_lab1_msgs/Encoders")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Encoders)))
  "Returns string type for a message object of type 'Encoders"
  "ras_lab1_msgs/Encoders")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Encoders>)))
  "Returns md5sum for a message object of type '<Encoders>"
  "6363193e7f66cd2bf0e60c5eb25e1bd5")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Encoders)))
  "Returns md5sum for a message object of type 'Encoders"
  "6363193e7f66cd2bf0e60c5eb25e1bd5")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Encoders>)))
  "Returns full string definition for message of type '<Encoders>"
  (cl:format cl:nil "# encoder: absolute encoder value~%# delta_encoder: differential encoder value~%# tiemstamp: in milliseconds~%# 1 --> left~%# 2 --> right~%int32 encoder1~%int32 encoder2~%int32 delta_encoder1~%int32 delta_encoder2~%int32 timestamp~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Encoders)))
  "Returns full string definition for message of type 'Encoders"
  (cl:format cl:nil "# encoder: absolute encoder value~%# delta_encoder: differential encoder value~%# tiemstamp: in milliseconds~%# 1 --> left~%# 2 --> right~%int32 encoder1~%int32 encoder2~%int32 delta_encoder1~%int32 delta_encoder2~%int32 timestamp~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Encoders>))
  (cl:+ 0
     4
     4
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Encoders>))
  "Converts a ROS message object to a list"
  (cl:list 'Encoders
    (cl:cons ':encoder1 (encoder1 msg))
    (cl:cons ':encoder2 (encoder2 msg))
    (cl:cons ':delta_encoder1 (delta_encoder1 msg))
    (cl:cons ':delta_encoder2 (delta_encoder2 msg))
    (cl:cons ':timestamp (timestamp msg))
))
