; Auto-generated. Do not edit!


(cl:in-package uarm-srv)


;//! \htmlinclude MoveTo-request.msg.html

(cl:defclass <MoveTo-request> (roslisp-msg-protocol:ros-message)
  ((position
    :reader position
    :initarg :position
    :type geometry_msgs-msg:Point
    :initform (cl:make-instance 'geometry_msgs-msg:Point))
   (eef_orientation
    :reader eef_orientation
    :initarg :eef_orientation
    :type cl:float
    :initform 0.0)
   (move_mode
    :reader move_mode
    :initarg :move_mode
    :type cl:integer
    :initform 0)
   (movement_duration
    :reader movement_duration
    :initarg :movement_duration
    :type cl:real
    :initform 0)
   (ignore_orientation
    :reader ignore_orientation
    :initarg :ignore_orientation
    :type cl:boolean
    :initform cl:nil)
   (interpolation_type
    :reader interpolation_type
    :initarg :interpolation_type
    :type cl:integer
    :initform 0)
   (check_limits
    :reader check_limits
    :initarg :check_limits
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass MoveTo-request (<MoveTo-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MoveTo-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MoveTo-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uarm-srv:<MoveTo-request> is deprecated: use uarm-srv:MoveTo-request instead.")))

(cl:ensure-generic-function 'position-val :lambda-list '(m))
(cl:defmethod position-val ((m <MoveTo-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uarm-srv:position-val is deprecated.  Use uarm-srv:position instead.")
  (position m))

(cl:ensure-generic-function 'eef_orientation-val :lambda-list '(m))
(cl:defmethod eef_orientation-val ((m <MoveTo-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uarm-srv:eef_orientation-val is deprecated.  Use uarm-srv:eef_orientation instead.")
  (eef_orientation m))

(cl:ensure-generic-function 'move_mode-val :lambda-list '(m))
(cl:defmethod move_mode-val ((m <MoveTo-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uarm-srv:move_mode-val is deprecated.  Use uarm-srv:move_mode instead.")
  (move_mode m))

(cl:ensure-generic-function 'movement_duration-val :lambda-list '(m))
(cl:defmethod movement_duration-val ((m <MoveTo-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uarm-srv:movement_duration-val is deprecated.  Use uarm-srv:movement_duration instead.")
  (movement_duration m))

(cl:ensure-generic-function 'ignore_orientation-val :lambda-list '(m))
(cl:defmethod ignore_orientation-val ((m <MoveTo-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uarm-srv:ignore_orientation-val is deprecated.  Use uarm-srv:ignore_orientation instead.")
  (ignore_orientation m))

(cl:ensure-generic-function 'interpolation_type-val :lambda-list '(m))
(cl:defmethod interpolation_type-val ((m <MoveTo-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uarm-srv:interpolation_type-val is deprecated.  Use uarm-srv:interpolation_type instead.")
  (interpolation_type m))

(cl:ensure-generic-function 'check_limits-val :lambda-list '(m))
(cl:defmethod check_limits-val ((m <MoveTo-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uarm-srv:check_limits-val is deprecated.  Use uarm-srv:check_limits instead.")
  (check_limits m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<MoveTo-request>)))
    "Constants for message type '<MoveTo-request>"
  '((:ABSOLUTE_MOVEMENT . 0)
    (:RELATIVE_MOVEMENT . 1)
    (:NO_INTERPOLATION . 0)
    (:CUBIC_INTERPOLATION . 1)
    (:LINEAR_INTERPOLATION . 2))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'MoveTo-request)))
    "Constants for message type 'MoveTo-request"
  '((:ABSOLUTE_MOVEMENT . 0)
    (:RELATIVE_MOVEMENT . 1)
    (:NO_INTERPOLATION . 0)
    (:CUBIC_INTERPOLATION . 1)
    (:LINEAR_INTERPOLATION . 2))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MoveTo-request>) ostream)
  "Serializes a message object of type '<MoveTo-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'position) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'eef_orientation))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'move_mode)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__sec (cl:floor (cl:slot-value msg 'movement_duration)))
        (__nsec (cl:round (cl:* 1e9 (cl:- (cl:slot-value msg 'movement_duration) (cl:floor (cl:slot-value msg 'movement_duration)))))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 0) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __nsec) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'ignore_orientation) 1 0)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'interpolation_type)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'check_limits) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MoveTo-request>) istream)
  "Deserializes a message object of type '<MoveTo-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'position) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'eef_orientation) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'move_mode) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((__sec 0) (__nsec 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 0) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __nsec) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'movement_duration) (cl:+ (cl:coerce __sec 'cl:double-float) (cl:/ __nsec 1e9))))
    (cl:setf (cl:slot-value msg 'ignore_orientation) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'interpolation_type) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:setf (cl:slot-value msg 'check_limits) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MoveTo-request>)))
  "Returns string type for a service object of type '<MoveTo-request>"
  "uarm/MoveToRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MoveTo-request)))
  "Returns string type for a service object of type 'MoveTo-request"
  "uarm/MoveToRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MoveTo-request>)))
  "Returns md5sum for a message object of type '<MoveTo-request>"
  "b5950699ca93b2e0816f732b4daecc97")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MoveTo-request)))
  "Returns md5sum for a message object of type 'MoveTo-request"
  "b5950699ca93b2e0816f732b4daecc97")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MoveTo-request>)))
  "Returns full string definition for message of type '<MoveTo-request>"
  (cl:format cl:nil "~%geometry_msgs/Point position~%float32 eef_orientation~%int32 move_mode~%duration movement_duration~%bool ignore_orientation~%int32 interpolation_type~%bool check_limits~%~%~%int32 ABSOLUTE_MOVEMENT = 0~%int32 RELATIVE_MOVEMENT = 1~%~%~%~%~%~%~%int32 NO_INTERPOLATION = 0~%int32 CUBIC_INTERPOLATION = 1~%int32 LINEAR_INTERPOLATION = 2~%~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MoveTo-request)))
  "Returns full string definition for message of type 'MoveTo-request"
  (cl:format cl:nil "~%geometry_msgs/Point position~%float32 eef_orientation~%int32 move_mode~%duration movement_duration~%bool ignore_orientation~%int32 interpolation_type~%bool check_limits~%~%~%int32 ABSOLUTE_MOVEMENT = 0~%int32 RELATIVE_MOVEMENT = 1~%~%~%~%~%~%~%int32 NO_INTERPOLATION = 0~%int32 CUBIC_INTERPOLATION = 1~%int32 LINEAR_INTERPOLATION = 2~%~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MoveTo-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'position))
     4
     4
     8
     1
     4
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MoveTo-request>))
  "Converts a ROS message object to a list"
  (cl:list 'MoveTo-request
    (cl:cons ':position (position msg))
    (cl:cons ':eef_orientation (eef_orientation msg))
    (cl:cons ':move_mode (move_mode msg))
    (cl:cons ':movement_duration (movement_duration msg))
    (cl:cons ':ignore_orientation (ignore_orientation msg))
    (cl:cons ':interpolation_type (interpolation_type msg))
    (cl:cons ':check_limits (check_limits msg))
))
;//! \htmlinclude MoveTo-response.msg.html

(cl:defclass <MoveTo-response> (roslisp-msg-protocol:ros-message)
  ((position
    :reader position
    :initarg :position
    :type geometry_msgs-msg:Point
    :initform (cl:make-instance 'geometry_msgs-msg:Point))
   (elapsed
    :reader elapsed
    :initarg :elapsed
    :type cl:real
    :initform 0)
   (error
    :reader error
    :initarg :error
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass MoveTo-response (<MoveTo-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MoveTo-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MoveTo-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uarm-srv:<MoveTo-response> is deprecated: use uarm-srv:MoveTo-response instead.")))

(cl:ensure-generic-function 'position-val :lambda-list '(m))
(cl:defmethod position-val ((m <MoveTo-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uarm-srv:position-val is deprecated.  Use uarm-srv:position instead.")
  (position m))

(cl:ensure-generic-function 'elapsed-val :lambda-list '(m))
(cl:defmethod elapsed-val ((m <MoveTo-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uarm-srv:elapsed-val is deprecated.  Use uarm-srv:elapsed instead.")
  (elapsed m))

(cl:ensure-generic-function 'error-val :lambda-list '(m))
(cl:defmethod error-val ((m <MoveTo-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uarm-srv:error-val is deprecated.  Use uarm-srv:error instead.")
  (error m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MoveTo-response>) ostream)
  "Serializes a message object of type '<MoveTo-response>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'position) ostream)
  (cl:let ((__sec (cl:floor (cl:slot-value msg 'elapsed)))
        (__nsec (cl:round (cl:* 1e9 (cl:- (cl:slot-value msg 'elapsed) (cl:floor (cl:slot-value msg 'elapsed)))))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 0) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __nsec) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'error) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MoveTo-response>) istream)
  "Deserializes a message object of type '<MoveTo-response>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'position) istream)
    (cl:let ((__sec 0) (__nsec 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 0) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __nsec) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'elapsed) (cl:+ (cl:coerce __sec 'cl:double-float) (cl:/ __nsec 1e9))))
    (cl:setf (cl:slot-value msg 'error) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MoveTo-response>)))
  "Returns string type for a service object of type '<MoveTo-response>"
  "uarm/MoveToResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MoveTo-response)))
  "Returns string type for a service object of type 'MoveTo-response"
  "uarm/MoveToResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MoveTo-response>)))
  "Returns md5sum for a message object of type '<MoveTo-response>"
  "b5950699ca93b2e0816f732b4daecc97")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MoveTo-response)))
  "Returns md5sum for a message object of type 'MoveTo-response"
  "b5950699ca93b2e0816f732b4daecc97")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MoveTo-response>)))
  "Returns full string definition for message of type '<MoveTo-response>"
  (cl:format cl:nil "~%geometry_msgs/Point position~%duration elapsed~%bool error~%~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MoveTo-response)))
  "Returns full string definition for message of type 'MoveTo-response"
  (cl:format cl:nil "~%geometry_msgs/Point position~%duration elapsed~%bool error~%~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MoveTo-response>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'position))
     8
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MoveTo-response>))
  "Converts a ROS message object to a list"
  (cl:list 'MoveTo-response
    (cl:cons ':position (position msg))
    (cl:cons ':elapsed (elapsed msg))
    (cl:cons ':error (error msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'MoveTo)))
  'MoveTo-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'MoveTo)))
  'MoveTo-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MoveTo)))
  "Returns string type for a service object of type '<MoveTo>"
  "uarm/MoveTo")