; Auto-generated. Do not edit!


(cl:in-package uarm-srv)


;//! \htmlinclude Pump-request.msg.html

(cl:defclass <Pump-request> (roslisp-msg-protocol:ros-message)
  ((pump_status
    :reader pump_status
    :initarg :pump_status
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass Pump-request (<Pump-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Pump-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Pump-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uarm-srv:<Pump-request> is deprecated: use uarm-srv:Pump-request instead.")))

(cl:ensure-generic-function 'pump_status-val :lambda-list '(m))
(cl:defmethod pump_status-val ((m <Pump-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uarm-srv:pump_status-val is deprecated.  Use uarm-srv:pump_status instead.")
  (pump_status m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Pump-request>) ostream)
  "Serializes a message object of type '<Pump-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'pump_status) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Pump-request>) istream)
  "Deserializes a message object of type '<Pump-request>"
    (cl:setf (cl:slot-value msg 'pump_status) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Pump-request>)))
  "Returns string type for a service object of type '<Pump-request>"
  "uarm/PumpRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Pump-request)))
  "Returns string type for a service object of type 'Pump-request"
  "uarm/PumpRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Pump-request>)))
  "Returns md5sum for a message object of type '<Pump-request>"
  "ff5a115a491fb65f575572e4a97ae33c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Pump-request)))
  "Returns md5sum for a message object of type 'Pump-request"
  "ff5a115a491fb65f575572e4a97ae33c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Pump-request>)))
  "Returns full string definition for message of type '<Pump-request>"
  (cl:format cl:nil "~%bool pump_status~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Pump-request)))
  "Returns full string definition for message of type 'Pump-request"
  (cl:format cl:nil "~%bool pump_status~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Pump-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Pump-request>))
  "Converts a ROS message object to a list"
  (cl:list 'Pump-request
    (cl:cons ':pump_status (pump_status msg))
))
;//! \htmlinclude Pump-response.msg.html

(cl:defclass <Pump-response> (roslisp-msg-protocol:ros-message)
  ((pump_status
    :reader pump_status
    :initarg :pump_status
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass Pump-response (<Pump-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Pump-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Pump-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uarm-srv:<Pump-response> is deprecated: use uarm-srv:Pump-response instead.")))

(cl:ensure-generic-function 'pump_status-val :lambda-list '(m))
(cl:defmethod pump_status-val ((m <Pump-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uarm-srv:pump_status-val is deprecated.  Use uarm-srv:pump_status instead.")
  (pump_status m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Pump-response>) ostream)
  "Serializes a message object of type '<Pump-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'pump_status) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Pump-response>) istream)
  "Deserializes a message object of type '<Pump-response>"
    (cl:setf (cl:slot-value msg 'pump_status) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Pump-response>)))
  "Returns string type for a service object of type '<Pump-response>"
  "uarm/PumpResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Pump-response)))
  "Returns string type for a service object of type 'Pump-response"
  "uarm/PumpResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Pump-response>)))
  "Returns md5sum for a message object of type '<Pump-response>"
  "ff5a115a491fb65f575572e4a97ae33c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Pump-response)))
  "Returns md5sum for a message object of type 'Pump-response"
  "ff5a115a491fb65f575572e4a97ae33c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Pump-response>)))
  "Returns full string definition for message of type '<Pump-response>"
  (cl:format cl:nil "~%bool pump_status~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Pump-response)))
  "Returns full string definition for message of type 'Pump-response"
  (cl:format cl:nil "~%bool pump_status~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Pump-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Pump-response>))
  "Converts a ROS message object to a list"
  (cl:list 'Pump-response
    (cl:cons ':pump_status (pump_status msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'Pump)))
  'Pump-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'Pump)))
  'Pump-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Pump)))
  "Returns string type for a service object of type '<Pump>"
  "uarm/Pump")