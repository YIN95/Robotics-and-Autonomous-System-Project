; Auto-generated. Do not edit!


(cl:in-package phidgets-srv)


;//! \htmlinclude interface_kit-request.msg.html

(cl:defclass <interface_kit-request> (roslisp-msg-protocol:ros-message)
  ((index
    :reader index
    :initarg :index
    :type cl:integer
    :initform 0)
   (value_type
    :reader value_type
    :initarg :value_type
    :type cl:integer
    :initform 0)
   (value
    :reader value
    :initarg :value
    :type cl:integer
    :initform 0))
)

(cl:defclass interface_kit-request (<interface_kit-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <interface_kit-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'interface_kit-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name phidgets-srv:<interface_kit-request> is deprecated: use phidgets-srv:interface_kit-request instead.")))

(cl:ensure-generic-function 'index-val :lambda-list '(m))
(cl:defmethod index-val ((m <interface_kit-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader phidgets-srv:index-val is deprecated.  Use phidgets-srv:index instead.")
  (index m))

(cl:ensure-generic-function 'value_type-val :lambda-list '(m))
(cl:defmethod value_type-val ((m <interface_kit-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader phidgets-srv:value_type-val is deprecated.  Use phidgets-srv:value_type instead.")
  (value_type m))

(cl:ensure-generic-function 'value-val :lambda-list '(m))
(cl:defmethod value-val ((m <interface_kit-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader phidgets-srv:value-val is deprecated.  Use phidgets-srv:value instead.")
  (value m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <interface_kit-request>) ostream)
  "Serializes a message object of type '<interface_kit-request>"
  (cl:let* ((signed (cl:slot-value msg 'index)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'value_type)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'value)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <interface_kit-request>) istream)
  "Deserializes a message object of type '<interface_kit-request>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'index) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'value_type) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'value) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<interface_kit-request>)))
  "Returns string type for a service object of type '<interface_kit-request>"
  "phidgets/interface_kitRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'interface_kit-request)))
  "Returns string type for a service object of type 'interface_kit-request"
  "phidgets/interface_kitRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<interface_kit-request>)))
  "Returns md5sum for a message object of type '<interface_kit-request>"
  "75cbd2a6abfcf442181c14de3598b662")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'interface_kit-request)))
  "Returns md5sum for a message object of type 'interface_kit-request"
  "75cbd2a6abfcf442181c14de3598b662")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<interface_kit-request>)))
  "Returns full string definition for message of type '<interface_kit-request>"
  (cl:format cl:nil "int32 index~%int32 value_type~%int32 value~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'interface_kit-request)))
  "Returns full string definition for message of type 'interface_kit-request"
  (cl:format cl:nil "int32 index~%int32 value_type~%int32 value~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <interface_kit-request>))
  (cl:+ 0
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <interface_kit-request>))
  "Converts a ROS message object to a list"
  (cl:list 'interface_kit-request
    (cl:cons ':index (index msg))
    (cl:cons ':value_type (value_type msg))
    (cl:cons ':value (value msg))
))
;//! \htmlinclude interface_kit-response.msg.html

(cl:defclass <interface_kit-response> (roslisp-msg-protocol:ros-message)
  ((ack
    :reader ack
    :initarg :ack
    :type cl:integer
    :initform 0))
)

(cl:defclass interface_kit-response (<interface_kit-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <interface_kit-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'interface_kit-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name phidgets-srv:<interface_kit-response> is deprecated: use phidgets-srv:interface_kit-response instead.")))

(cl:ensure-generic-function 'ack-val :lambda-list '(m))
(cl:defmethod ack-val ((m <interface_kit-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader phidgets-srv:ack-val is deprecated.  Use phidgets-srv:ack instead.")
  (ack m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <interface_kit-response>) ostream)
  "Serializes a message object of type '<interface_kit-response>"
  (cl:let* ((signed (cl:slot-value msg 'ack)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <interface_kit-response>) istream)
  "Deserializes a message object of type '<interface_kit-response>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'ack) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<interface_kit-response>)))
  "Returns string type for a service object of type '<interface_kit-response>"
  "phidgets/interface_kitResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'interface_kit-response)))
  "Returns string type for a service object of type 'interface_kit-response"
  "phidgets/interface_kitResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<interface_kit-response>)))
  "Returns md5sum for a message object of type '<interface_kit-response>"
  "75cbd2a6abfcf442181c14de3598b662")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'interface_kit-response)))
  "Returns md5sum for a message object of type 'interface_kit-response"
  "75cbd2a6abfcf442181c14de3598b662")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<interface_kit-response>)))
  "Returns full string definition for message of type '<interface_kit-response>"
  (cl:format cl:nil "int32 ack~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'interface_kit-response)))
  "Returns full string definition for message of type 'interface_kit-response"
  (cl:format cl:nil "int32 ack~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <interface_kit-response>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <interface_kit-response>))
  "Converts a ROS message object to a list"
  (cl:list 'interface_kit-response
    (cl:cons ':ack (ack msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'interface_kit)))
  'interface_kit-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'interface_kit)))
  'interface_kit-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'interface_kit)))
  "Returns string type for a service object of type '<interface_kit>"
  "phidgets/interface_kit")