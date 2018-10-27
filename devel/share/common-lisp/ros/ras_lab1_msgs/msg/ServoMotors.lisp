; Auto-generated. Do not edit!


(cl:in-package ras_lab1_msgs-msg)


;//! \htmlinclude ServoMotors.msg.html

(cl:defclass <ServoMotors> (roslisp-msg-protocol:ros-message)
  ((servo1
    :reader servo1
    :initarg :servo1
    :type cl:fixnum
    :initform 0)
   (servoangle
    :reader servoangle
    :initarg :servoangle
    :type (cl:vector cl:fixnum)
   :initform (cl:make-array 8 :element-type 'cl:fixnum :initial-element 0)))
)

(cl:defclass ServoMotors (<ServoMotors>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ServoMotors>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ServoMotors)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ras_lab1_msgs-msg:<ServoMotors> is deprecated: use ras_lab1_msgs-msg:ServoMotors instead.")))

(cl:ensure-generic-function 'servo1-val :lambda-list '(m))
(cl:defmethod servo1-val ((m <ServoMotors>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ras_lab1_msgs-msg:servo1-val is deprecated.  Use ras_lab1_msgs-msg:servo1 instead.")
  (servo1 m))

(cl:ensure-generic-function 'servoangle-val :lambda-list '(m))
(cl:defmethod servoangle-val ((m <ServoMotors>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ras_lab1_msgs-msg:servoangle-val is deprecated.  Use ras_lab1_msgs-msg:servoangle instead.")
  (servoangle m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ServoMotors>) ostream)
  "Serializes a message object of type '<ServoMotors>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'servo1)) ostream)
  (cl:map cl:nil #'(cl:lambda (ele) (cl:write-byte (cl:ldb (cl:byte 8 0) ele) ostream))
   (cl:slot-value msg 'servoangle))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ServoMotors>) istream)
  "Deserializes a message object of type '<ServoMotors>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'servo1)) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'servoangle) (cl:make-array 8))
  (cl:let ((vals (cl:slot-value msg 'servoangle)))
    (cl:dotimes (i 8)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:aref vals i)) (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ServoMotors>)))
  "Returns string type for a message object of type '<ServoMotors>"
  "ras_lab1_msgs/ServoMotors")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ServoMotors)))
  "Returns string type for a message object of type 'ServoMotors"
  "ras_lab1_msgs/ServoMotors")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ServoMotors>)))
  "Returns md5sum for a message object of type '<ServoMotors>"
  "f51d948c20e299a516b60c1bba9b447f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ServoMotors)))
  "Returns md5sum for a message object of type 'ServoMotors"
  "f51d948c20e299a516b60c1bba9b447f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ServoMotors>)))
  "Returns full string definition for message of type '<ServoMotors>"
  (cl:format cl:nil "# desired angular position~%# range 0-180 degrees~%~%uint8 servo1~%uint8[8] servoangle~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ServoMotors)))
  "Returns full string definition for message of type 'ServoMotors"
  (cl:format cl:nil "# desired angular position~%# range 0-180 degrees~%~%uint8 servo1~%uint8[8] servoangle~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ServoMotors>))
  (cl:+ 0
     1
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'servoangle) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 1)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ServoMotors>))
  "Converts a ROS message object to a list"
  (cl:list 'ServoMotors
    (cl:cons ':servo1 (servo1 msg))
    (cl:cons ':servoangle (servoangle msg))
))
