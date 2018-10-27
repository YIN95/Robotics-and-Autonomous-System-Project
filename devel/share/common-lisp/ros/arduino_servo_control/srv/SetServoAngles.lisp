; Auto-generated. Do not edit!


(cl:in-package arduino_servo_control-srv)


;//! \htmlinclude SetServoAngles-request.msg.html

(cl:defclass <SetServoAngles-request> (roslisp-msg-protocol:ros-message)
  ((angle_servo_0
    :reader angle_servo_0
    :initarg :angle_servo_0
    :type cl:integer
    :initform 0)
   (angle_servo_1
    :reader angle_servo_1
    :initarg :angle_servo_1
    :type cl:integer
    :initform 0))
)

(cl:defclass SetServoAngles-request (<SetServoAngles-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetServoAngles-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetServoAngles-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name arduino_servo_control-srv:<SetServoAngles-request> is deprecated: use arduino_servo_control-srv:SetServoAngles-request instead.")))

(cl:ensure-generic-function 'angle_servo_0-val :lambda-list '(m))
(cl:defmethod angle_servo_0-val ((m <SetServoAngles-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader arduino_servo_control-srv:angle_servo_0-val is deprecated.  Use arduino_servo_control-srv:angle_servo_0 instead.")
  (angle_servo_0 m))

(cl:ensure-generic-function 'angle_servo_1-val :lambda-list '(m))
(cl:defmethod angle_servo_1-val ((m <SetServoAngles-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader arduino_servo_control-srv:angle_servo_1-val is deprecated.  Use arduino_servo_control-srv:angle_servo_1 instead.")
  (angle_servo_1 m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetServoAngles-request>) ostream)
  "Serializes a message object of type '<SetServoAngles-request>"
  (cl:let* ((signed (cl:slot-value msg 'angle_servo_0)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'angle_servo_1)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetServoAngles-request>) istream)
  "Deserializes a message object of type '<SetServoAngles-request>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'angle_servo_0) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'angle_servo_1) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetServoAngles-request>)))
  "Returns string type for a service object of type '<SetServoAngles-request>"
  "arduino_servo_control/SetServoAnglesRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetServoAngles-request)))
  "Returns string type for a service object of type 'SetServoAngles-request"
  "arduino_servo_control/SetServoAnglesRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetServoAngles-request>)))
  "Returns md5sum for a message object of type '<SetServoAngles-request>"
  "9f74ea09edde7d0924376ba2d9b77543")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetServoAngles-request)))
  "Returns md5sum for a message object of type 'SetServoAngles-request"
  "9f74ea09edde7d0924376ba2d9b77543")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetServoAngles-request>)))
  "Returns full string definition for message of type '<SetServoAngles-request>"
  (cl:format cl:nil "~%int64 angle_servo_0~%int64 angle_servo_1~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetServoAngles-request)))
  "Returns full string definition for message of type 'SetServoAngles-request"
  (cl:format cl:nil "~%int64 angle_servo_0~%int64 angle_servo_1~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetServoAngles-request>))
  (cl:+ 0
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetServoAngles-request>))
  "Converts a ROS message object to a list"
  (cl:list 'SetServoAngles-request
    (cl:cons ':angle_servo_0 (angle_servo_0 msg))
    (cl:cons ':angle_servo_1 (angle_servo_1 msg))
))
;//! \htmlinclude SetServoAngles-response.msg.html

(cl:defclass <SetServoAngles-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass SetServoAngles-response (<SetServoAngles-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetServoAngles-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetServoAngles-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name arduino_servo_control-srv:<SetServoAngles-response> is deprecated: use arduino_servo_control-srv:SetServoAngles-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <SetServoAngles-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader arduino_servo_control-srv:success-val is deprecated.  Use arduino_servo_control-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetServoAngles-response>) ostream)
  "Serializes a message object of type '<SetServoAngles-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetServoAngles-response>) istream)
  "Deserializes a message object of type '<SetServoAngles-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetServoAngles-response>)))
  "Returns string type for a service object of type '<SetServoAngles-response>"
  "arduino_servo_control/SetServoAnglesResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetServoAngles-response)))
  "Returns string type for a service object of type 'SetServoAngles-response"
  "arduino_servo_control/SetServoAnglesResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetServoAngles-response>)))
  "Returns md5sum for a message object of type '<SetServoAngles-response>"
  "9f74ea09edde7d0924376ba2d9b77543")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetServoAngles-response)))
  "Returns md5sum for a message object of type 'SetServoAngles-response"
  "9f74ea09edde7d0924376ba2d9b77543")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetServoAngles-response>)))
  "Returns full string definition for message of type '<SetServoAngles-response>"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetServoAngles-response)))
  "Returns full string definition for message of type 'SetServoAngles-response"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetServoAngles-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetServoAngles-response>))
  "Converts a ROS message object to a list"
  (cl:list 'SetServoAngles-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'SetServoAngles)))
  'SetServoAngles-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'SetServoAngles)))
  'SetServoAngles-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetServoAngles)))
  "Returns string type for a service object of type '<SetServoAngles>"
  "arduino_servo_control/SetServoAngles")