; Auto-generated. Do not edit!


(cl:in-package uarm-srv)


;//! \htmlinclude MoveToJoints-request.msg.html

(cl:defclass <MoveToJoints-request> (roslisp-msg-protocol:ros-message)
  ((j0
    :reader j0
    :initarg :j0
    :type cl:float
    :initform 0.0)
   (j1
    :reader j1
    :initarg :j1
    :type cl:float
    :initform 0.0)
   (j2
    :reader j2
    :initarg :j2
    :type cl:float
    :initform 0.0)
   (j3
    :reader j3
    :initarg :j3
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

(cl:defclass MoveToJoints-request (<MoveToJoints-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MoveToJoints-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MoveToJoints-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uarm-srv:<MoveToJoints-request> is deprecated: use uarm-srv:MoveToJoints-request instead.")))

(cl:ensure-generic-function 'j0-val :lambda-list '(m))
(cl:defmethod j0-val ((m <MoveToJoints-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uarm-srv:j0-val is deprecated.  Use uarm-srv:j0 instead.")
  (j0 m))

(cl:ensure-generic-function 'j1-val :lambda-list '(m))
(cl:defmethod j1-val ((m <MoveToJoints-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uarm-srv:j1-val is deprecated.  Use uarm-srv:j1 instead.")
  (j1 m))

(cl:ensure-generic-function 'j2-val :lambda-list '(m))
(cl:defmethod j2-val ((m <MoveToJoints-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uarm-srv:j2-val is deprecated.  Use uarm-srv:j2 instead.")
  (j2 m))

(cl:ensure-generic-function 'j3-val :lambda-list '(m))
(cl:defmethod j3-val ((m <MoveToJoints-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uarm-srv:j3-val is deprecated.  Use uarm-srv:j3 instead.")
  (j3 m))

(cl:ensure-generic-function 'move_mode-val :lambda-list '(m))
(cl:defmethod move_mode-val ((m <MoveToJoints-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uarm-srv:move_mode-val is deprecated.  Use uarm-srv:move_mode instead.")
  (move_mode m))

(cl:ensure-generic-function 'movement_duration-val :lambda-list '(m))
(cl:defmethod movement_duration-val ((m <MoveToJoints-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uarm-srv:movement_duration-val is deprecated.  Use uarm-srv:movement_duration instead.")
  (movement_duration m))

(cl:ensure-generic-function 'interpolation_type-val :lambda-list '(m))
(cl:defmethod interpolation_type-val ((m <MoveToJoints-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uarm-srv:interpolation_type-val is deprecated.  Use uarm-srv:interpolation_type instead.")
  (interpolation_type m))

(cl:ensure-generic-function 'check_limits-val :lambda-list '(m))
(cl:defmethod check_limits-val ((m <MoveToJoints-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uarm-srv:check_limits-val is deprecated.  Use uarm-srv:check_limits instead.")
  (check_limits m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<MoveToJoints-request>)))
    "Constants for message type '<MoveToJoints-request>"
  '((:ABSOLUTE_MOVEMENT . 0)
    (:RELATIVE_MOVEMENT . 1)
    (:NO_INTERPOLATION . 0)
    (:CUBIC_INTERPOLATION . 1)
    (:LINEAR_INTERPOLATION . 2))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'MoveToJoints-request)))
    "Constants for message type 'MoveToJoints-request"
  '((:ABSOLUTE_MOVEMENT . 0)
    (:RELATIVE_MOVEMENT . 1)
    (:NO_INTERPOLATION . 0)
    (:CUBIC_INTERPOLATION . 1)
    (:LINEAR_INTERPOLATION . 2))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MoveToJoints-request>) ostream)
  "Serializes a message object of type '<MoveToJoints-request>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'j0))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'j1))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'j2))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'j3))))
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
  (cl:let* ((signed (cl:slot-value msg 'interpolation_type)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'check_limits) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MoveToJoints-request>) istream)
  "Deserializes a message object of type '<MoveToJoints-request>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'j0) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'j1) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'j2) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'j3) (roslisp-utils:decode-single-float-bits bits)))
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
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'interpolation_type) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:setf (cl:slot-value msg 'check_limits) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MoveToJoints-request>)))
  "Returns string type for a service object of type '<MoveToJoints-request>"
  "uarm/MoveToJointsRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MoveToJoints-request)))
  "Returns string type for a service object of type 'MoveToJoints-request"
  "uarm/MoveToJointsRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MoveToJoints-request>)))
  "Returns md5sum for a message object of type '<MoveToJoints-request>"
  "112a3367014960c210096553f33b43c1")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MoveToJoints-request)))
  "Returns md5sum for a message object of type 'MoveToJoints-request"
  "112a3367014960c210096553f33b43c1")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MoveToJoints-request>)))
  "Returns full string definition for message of type '<MoveToJoints-request>"
  (cl:format cl:nil "~%float32 j0~%float32 j1~%float32 j2~%float32 j3~%int32 move_mode~%duration movement_duration~%int32 interpolation_type~%bool check_limits~%~%~%int32 ABSOLUTE_MOVEMENT = 0~%int32 RELATIVE_MOVEMENT = 1~%~%~%~%~%~%~%int32 NO_INTERPOLATION = 0~%int32 CUBIC_INTERPOLATION = 1~%int32 LINEAR_INTERPOLATION = 2~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MoveToJoints-request)))
  "Returns full string definition for message of type 'MoveToJoints-request"
  (cl:format cl:nil "~%float32 j0~%float32 j1~%float32 j2~%float32 j3~%int32 move_mode~%duration movement_duration~%int32 interpolation_type~%bool check_limits~%~%~%int32 ABSOLUTE_MOVEMENT = 0~%int32 RELATIVE_MOVEMENT = 1~%~%~%~%~%~%~%int32 NO_INTERPOLATION = 0~%int32 CUBIC_INTERPOLATION = 1~%int32 LINEAR_INTERPOLATION = 2~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MoveToJoints-request>))
  (cl:+ 0
     4
     4
     4
     4
     4
     8
     4
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MoveToJoints-request>))
  "Converts a ROS message object to a list"
  (cl:list 'MoveToJoints-request
    (cl:cons ':j0 (j0 msg))
    (cl:cons ':j1 (j1 msg))
    (cl:cons ':j2 (j2 msg))
    (cl:cons ':j3 (j3 msg))
    (cl:cons ':move_mode (move_mode msg))
    (cl:cons ':movement_duration (movement_duration msg))
    (cl:cons ':interpolation_type (interpolation_type msg))
    (cl:cons ':check_limits (check_limits msg))
))
;//! \htmlinclude MoveToJoints-response.msg.html

(cl:defclass <MoveToJoints-response> (roslisp-msg-protocol:ros-message)
  ((j0
    :reader j0
    :initarg :j0
    :type cl:float
    :initform 0.0)
   (j1
    :reader j1
    :initarg :j1
    :type cl:float
    :initform 0.0)
   (j2
    :reader j2
    :initarg :j2
    :type cl:float
    :initform 0.0)
   (j3
    :reader j3
    :initarg :j3
    :type cl:float
    :initform 0.0)
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

(cl:defclass MoveToJoints-response (<MoveToJoints-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MoveToJoints-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MoveToJoints-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uarm-srv:<MoveToJoints-response> is deprecated: use uarm-srv:MoveToJoints-response instead.")))

(cl:ensure-generic-function 'j0-val :lambda-list '(m))
(cl:defmethod j0-val ((m <MoveToJoints-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uarm-srv:j0-val is deprecated.  Use uarm-srv:j0 instead.")
  (j0 m))

(cl:ensure-generic-function 'j1-val :lambda-list '(m))
(cl:defmethod j1-val ((m <MoveToJoints-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uarm-srv:j1-val is deprecated.  Use uarm-srv:j1 instead.")
  (j1 m))

(cl:ensure-generic-function 'j2-val :lambda-list '(m))
(cl:defmethod j2-val ((m <MoveToJoints-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uarm-srv:j2-val is deprecated.  Use uarm-srv:j2 instead.")
  (j2 m))

(cl:ensure-generic-function 'j3-val :lambda-list '(m))
(cl:defmethod j3-val ((m <MoveToJoints-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uarm-srv:j3-val is deprecated.  Use uarm-srv:j3 instead.")
  (j3 m))

(cl:ensure-generic-function 'elapsed-val :lambda-list '(m))
(cl:defmethod elapsed-val ((m <MoveToJoints-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uarm-srv:elapsed-val is deprecated.  Use uarm-srv:elapsed instead.")
  (elapsed m))

(cl:ensure-generic-function 'error-val :lambda-list '(m))
(cl:defmethod error-val ((m <MoveToJoints-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uarm-srv:error-val is deprecated.  Use uarm-srv:error instead.")
  (error m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MoveToJoints-response>) ostream)
  "Serializes a message object of type '<MoveToJoints-response>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'j0))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'j1))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'j2))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'j3))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MoveToJoints-response>) istream)
  "Deserializes a message object of type '<MoveToJoints-response>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'j0) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'j1) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'j2) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'j3) (roslisp-utils:decode-single-float-bits bits)))
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MoveToJoints-response>)))
  "Returns string type for a service object of type '<MoveToJoints-response>"
  "uarm/MoveToJointsResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MoveToJoints-response)))
  "Returns string type for a service object of type 'MoveToJoints-response"
  "uarm/MoveToJointsResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MoveToJoints-response>)))
  "Returns md5sum for a message object of type '<MoveToJoints-response>"
  "112a3367014960c210096553f33b43c1")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MoveToJoints-response)))
  "Returns md5sum for a message object of type 'MoveToJoints-response"
  "112a3367014960c210096553f33b43c1")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MoveToJoints-response>)))
  "Returns full string definition for message of type '<MoveToJoints-response>"
  (cl:format cl:nil "~%float32 j0~%float32 j1~%float32 j2~%float32 j3~%duration elapsed~%bool error~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MoveToJoints-response)))
  "Returns full string definition for message of type 'MoveToJoints-response"
  (cl:format cl:nil "~%float32 j0~%float32 j1~%float32 j2~%float32 j3~%duration elapsed~%bool error~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MoveToJoints-response>))
  (cl:+ 0
     4
     4
     4
     4
     8
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MoveToJoints-response>))
  "Converts a ROS message object to a list"
  (cl:list 'MoveToJoints-response
    (cl:cons ':j0 (j0 msg))
    (cl:cons ':j1 (j1 msg))
    (cl:cons ':j2 (j2 msg))
    (cl:cons ':j3 (j3 msg))
    (cl:cons ':elapsed (elapsed msg))
    (cl:cons ':error (error msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'MoveToJoints)))
  'MoveToJoints-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'MoveToJoints)))
  'MoveToJoints-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MoveToJoints)))
  "Returns string type for a service object of type '<MoveToJoints>"
  "uarm/MoveToJoints")