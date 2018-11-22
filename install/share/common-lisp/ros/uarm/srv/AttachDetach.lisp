; Auto-generated. Do not edit!


(cl:in-package uarm-srv)


;//! \htmlinclude AttachDetach-request.msg.html

(cl:defclass <AttachDetach-request> (roslisp-msg-protocol:ros-message)
  ((attach
    :reader attach
    :initarg :attach
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass AttachDetach-request (<AttachDetach-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <AttachDetach-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'AttachDetach-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uarm-srv:<AttachDetach-request> is deprecated: use uarm-srv:AttachDetach-request instead.")))

(cl:ensure-generic-function 'attach-val :lambda-list '(m))
(cl:defmethod attach-val ((m <AttachDetach-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uarm-srv:attach-val is deprecated.  Use uarm-srv:attach instead.")
  (attach m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <AttachDetach-request>) ostream)
  "Serializes a message object of type '<AttachDetach-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'attach) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <AttachDetach-request>) istream)
  "Deserializes a message object of type '<AttachDetach-request>"
    (cl:setf (cl:slot-value msg 'attach) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<AttachDetach-request>)))
  "Returns string type for a service object of type '<AttachDetach-request>"
  "uarm/AttachDetachRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AttachDetach-request)))
  "Returns string type for a service object of type 'AttachDetach-request"
  "uarm/AttachDetachRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<AttachDetach-request>)))
  "Returns md5sum for a message object of type '<AttachDetach-request>"
  "15a30b512eac3d5d3679caf838a84beb")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'AttachDetach-request)))
  "Returns md5sum for a message object of type 'AttachDetach-request"
  "15a30b512eac3d5d3679caf838a84beb")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<AttachDetach-request>)))
  "Returns full string definition for message of type '<AttachDetach-request>"
  (cl:format cl:nil "~%bool attach~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'AttachDetach-request)))
  "Returns full string definition for message of type 'AttachDetach-request"
  (cl:format cl:nil "~%bool attach~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <AttachDetach-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <AttachDetach-request>))
  "Converts a ROS message object to a list"
  (cl:list 'AttachDetach-request
    (cl:cons ':attach (attach msg))
))
;//! \htmlinclude AttachDetach-response.msg.html

(cl:defclass <AttachDetach-response> (roslisp-msg-protocol:ros-message)
  ((attach
    :reader attach
    :initarg :attach
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass AttachDetach-response (<AttachDetach-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <AttachDetach-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'AttachDetach-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uarm-srv:<AttachDetach-response> is deprecated: use uarm-srv:AttachDetach-response instead.")))

(cl:ensure-generic-function 'attach-val :lambda-list '(m))
(cl:defmethod attach-val ((m <AttachDetach-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uarm-srv:attach-val is deprecated.  Use uarm-srv:attach instead.")
  (attach m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <AttachDetach-response>) ostream)
  "Serializes a message object of type '<AttachDetach-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'attach) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <AttachDetach-response>) istream)
  "Deserializes a message object of type '<AttachDetach-response>"
    (cl:setf (cl:slot-value msg 'attach) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<AttachDetach-response>)))
  "Returns string type for a service object of type '<AttachDetach-response>"
  "uarm/AttachDetachResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AttachDetach-response)))
  "Returns string type for a service object of type 'AttachDetach-response"
  "uarm/AttachDetachResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<AttachDetach-response>)))
  "Returns md5sum for a message object of type '<AttachDetach-response>"
  "15a30b512eac3d5d3679caf838a84beb")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'AttachDetach-response)))
  "Returns md5sum for a message object of type 'AttachDetach-response"
  "15a30b512eac3d5d3679caf838a84beb")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<AttachDetach-response>)))
  "Returns full string definition for message of type '<AttachDetach-response>"
  (cl:format cl:nil "~%bool attach~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'AttachDetach-response)))
  "Returns full string definition for message of type 'AttachDetach-response"
  (cl:format cl:nil "~%bool attach~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <AttachDetach-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <AttachDetach-response>))
  "Converts a ROS message object to a list"
  (cl:list 'AttachDetach-response
    (cl:cons ':attach (attach msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'AttachDetach)))
  'AttachDetach-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'AttachDetach)))
  'AttachDetach-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AttachDetach)))
  "Returns string type for a service object of type '<AttachDetach>"
  "uarm/AttachDetach")