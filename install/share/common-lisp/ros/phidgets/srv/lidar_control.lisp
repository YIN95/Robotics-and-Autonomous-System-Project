; Auto-generated. Do not edit!


(cl:in-package phidgets-srv)


;//! \htmlinclude lidar_control-request.msg.html

(cl:defclass <lidar_control-request> (roslisp-msg-protocol:ros-message)
  ((pause
    :reader pause
    :initarg :pause
    :type cl:boolean
    :initform cl:nil)
   (pan_servo_index
    :reader pan_servo_index
    :initarg :pan_servo_index
    :type cl:integer
    :initform 0)
   (tilt_servo_index
    :reader tilt_servo_index
    :initarg :tilt_servo_index
    :type cl:integer
    :initform 0)
   (sensor_index
    :reader sensor_index
    :initarg :sensor_index
    :type cl:integer
    :initform 0)
   (no_of_sensors
    :reader no_of_sensors
    :initarg :no_of_sensors
    :type cl:integer
    :initform 0)
   (sensor_type
    :reader sensor_type
    :initarg :sensor_type
    :type (cl:vector cl:integer)
   :initform (cl:make-array 0 :element-type 'cl:integer :initial-element 0))
   (sensor_coupling
    :reader sensor_coupling
    :initarg :sensor_coupling
    :type (cl:vector cl:integer)
   :initform (cl:make-array 0 :element-type 'cl:integer :initial-element 0))
   (speed
    :reader speed
    :initarg :speed
    :type cl:float
    :initform 0.0)
   (acceleration
    :reader acceleration
    :initarg :acceleration
    :type cl:float
    :initform 0.0)
   (pan_position_left
    :reader pan_position_left
    :initarg :pan_position_left
    :type cl:float
    :initform 0.0)
   (pan_position_right
    :reader pan_position_right
    :initarg :pan_position_right
    :type cl:float
    :initform 0.0)
   (pan_position_left_angle_degrees
    :reader pan_position_left_angle_degrees
    :initarg :pan_position_left_angle_degrees
    :type cl:float
    :initform 0.0)
   (pan_position_right_angle_degrees
    :reader pan_position_right_angle_degrees
    :initarg :pan_position_right_angle_degrees
    :type cl:float
    :initform 0.0)
   (tilt_position_up
    :reader tilt_position_up
    :initarg :tilt_position_up
    :type cl:float
    :initform 0.0)
   (tilt_position_down
    :reader tilt_position_down
    :initarg :tilt_position_down
    :type cl:float
    :initform 0.0)
   (tilt_position_up_angle_degrees
    :reader tilt_position_up_angle_degrees
    :initarg :tilt_position_up_angle_degrees
    :type cl:float
    :initform 0.0)
   (tilt_position_down_angle_degrees
    :reader tilt_position_down_angle_degrees
    :initarg :tilt_position_down_angle_degrees
    :type cl:float
    :initform 0.0)
   (tilt_steps
    :reader tilt_steps
    :initarg :tilt_steps
    :type cl:integer
    :initform 0)
   (cycle_time_sec
    :reader cycle_time_sec
    :initarg :cycle_time_sec
    :type cl:float
    :initform 0.0))
)

(cl:defclass lidar_control-request (<lidar_control-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <lidar_control-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'lidar_control-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name phidgets-srv:<lidar_control-request> is deprecated: use phidgets-srv:lidar_control-request instead.")))

(cl:ensure-generic-function 'pause-val :lambda-list '(m))
(cl:defmethod pause-val ((m <lidar_control-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader phidgets-srv:pause-val is deprecated.  Use phidgets-srv:pause instead.")
  (pause m))

(cl:ensure-generic-function 'pan_servo_index-val :lambda-list '(m))
(cl:defmethod pan_servo_index-val ((m <lidar_control-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader phidgets-srv:pan_servo_index-val is deprecated.  Use phidgets-srv:pan_servo_index instead.")
  (pan_servo_index m))

(cl:ensure-generic-function 'tilt_servo_index-val :lambda-list '(m))
(cl:defmethod tilt_servo_index-val ((m <lidar_control-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader phidgets-srv:tilt_servo_index-val is deprecated.  Use phidgets-srv:tilt_servo_index instead.")
  (tilt_servo_index m))

(cl:ensure-generic-function 'sensor_index-val :lambda-list '(m))
(cl:defmethod sensor_index-val ((m <lidar_control-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader phidgets-srv:sensor_index-val is deprecated.  Use phidgets-srv:sensor_index instead.")
  (sensor_index m))

(cl:ensure-generic-function 'no_of_sensors-val :lambda-list '(m))
(cl:defmethod no_of_sensors-val ((m <lidar_control-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader phidgets-srv:no_of_sensors-val is deprecated.  Use phidgets-srv:no_of_sensors instead.")
  (no_of_sensors m))

(cl:ensure-generic-function 'sensor_type-val :lambda-list '(m))
(cl:defmethod sensor_type-val ((m <lidar_control-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader phidgets-srv:sensor_type-val is deprecated.  Use phidgets-srv:sensor_type instead.")
  (sensor_type m))

(cl:ensure-generic-function 'sensor_coupling-val :lambda-list '(m))
(cl:defmethod sensor_coupling-val ((m <lidar_control-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader phidgets-srv:sensor_coupling-val is deprecated.  Use phidgets-srv:sensor_coupling instead.")
  (sensor_coupling m))

(cl:ensure-generic-function 'speed-val :lambda-list '(m))
(cl:defmethod speed-val ((m <lidar_control-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader phidgets-srv:speed-val is deprecated.  Use phidgets-srv:speed instead.")
  (speed m))

(cl:ensure-generic-function 'acceleration-val :lambda-list '(m))
(cl:defmethod acceleration-val ((m <lidar_control-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader phidgets-srv:acceleration-val is deprecated.  Use phidgets-srv:acceleration instead.")
  (acceleration m))

(cl:ensure-generic-function 'pan_position_left-val :lambda-list '(m))
(cl:defmethod pan_position_left-val ((m <lidar_control-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader phidgets-srv:pan_position_left-val is deprecated.  Use phidgets-srv:pan_position_left instead.")
  (pan_position_left m))

(cl:ensure-generic-function 'pan_position_right-val :lambda-list '(m))
(cl:defmethod pan_position_right-val ((m <lidar_control-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader phidgets-srv:pan_position_right-val is deprecated.  Use phidgets-srv:pan_position_right instead.")
  (pan_position_right m))

(cl:ensure-generic-function 'pan_position_left_angle_degrees-val :lambda-list '(m))
(cl:defmethod pan_position_left_angle_degrees-val ((m <lidar_control-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader phidgets-srv:pan_position_left_angle_degrees-val is deprecated.  Use phidgets-srv:pan_position_left_angle_degrees instead.")
  (pan_position_left_angle_degrees m))

(cl:ensure-generic-function 'pan_position_right_angle_degrees-val :lambda-list '(m))
(cl:defmethod pan_position_right_angle_degrees-val ((m <lidar_control-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader phidgets-srv:pan_position_right_angle_degrees-val is deprecated.  Use phidgets-srv:pan_position_right_angle_degrees instead.")
  (pan_position_right_angle_degrees m))

(cl:ensure-generic-function 'tilt_position_up-val :lambda-list '(m))
(cl:defmethod tilt_position_up-val ((m <lidar_control-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader phidgets-srv:tilt_position_up-val is deprecated.  Use phidgets-srv:tilt_position_up instead.")
  (tilt_position_up m))

(cl:ensure-generic-function 'tilt_position_down-val :lambda-list '(m))
(cl:defmethod tilt_position_down-val ((m <lidar_control-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader phidgets-srv:tilt_position_down-val is deprecated.  Use phidgets-srv:tilt_position_down instead.")
  (tilt_position_down m))

(cl:ensure-generic-function 'tilt_position_up_angle_degrees-val :lambda-list '(m))
(cl:defmethod tilt_position_up_angle_degrees-val ((m <lidar_control-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader phidgets-srv:tilt_position_up_angle_degrees-val is deprecated.  Use phidgets-srv:tilt_position_up_angle_degrees instead.")
  (tilt_position_up_angle_degrees m))

(cl:ensure-generic-function 'tilt_position_down_angle_degrees-val :lambda-list '(m))
(cl:defmethod tilt_position_down_angle_degrees-val ((m <lidar_control-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader phidgets-srv:tilt_position_down_angle_degrees-val is deprecated.  Use phidgets-srv:tilt_position_down_angle_degrees instead.")
  (tilt_position_down_angle_degrees m))

(cl:ensure-generic-function 'tilt_steps-val :lambda-list '(m))
(cl:defmethod tilt_steps-val ((m <lidar_control-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader phidgets-srv:tilt_steps-val is deprecated.  Use phidgets-srv:tilt_steps instead.")
  (tilt_steps m))

(cl:ensure-generic-function 'cycle_time_sec-val :lambda-list '(m))
(cl:defmethod cycle_time_sec-val ((m <lidar_control-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader phidgets-srv:cycle_time_sec-val is deprecated.  Use phidgets-srv:cycle_time_sec instead.")
  (cycle_time_sec m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <lidar_control-request>) ostream)
  "Serializes a message object of type '<lidar_control-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'pause) 1 0)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'pan_servo_index)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'tilt_servo_index)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'sensor_index)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'no_of_sensors)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'sensor_type))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let* ((signed ele) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    ))
   (cl:slot-value msg 'sensor_type))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'sensor_coupling))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let* ((signed ele) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    ))
   (cl:slot-value msg 'sensor_coupling))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'speed))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'acceleration))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'pan_position_left))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'pan_position_right))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'pan_position_left_angle_degrees))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'pan_position_right_angle_degrees))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'tilt_position_up))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'tilt_position_down))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'tilt_position_up_angle_degrees))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'tilt_position_down_angle_degrees))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'tilt_steps)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'cycle_time_sec))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <lidar_control-request>) istream)
  "Deserializes a message object of type '<lidar_control-request>"
    (cl:setf (cl:slot-value msg 'pause) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'pan_servo_index) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'tilt_servo_index) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'sensor_index) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'no_of_sensors) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'sensor_type) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'sensor_type)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296)))))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'sensor_coupling) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'sensor_coupling)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296)))))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'speed) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'acceleration) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'pan_position_left) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'pan_position_right) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'pan_position_left_angle_degrees) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'pan_position_right_angle_degrees) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'tilt_position_up) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'tilt_position_down) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'tilt_position_up_angle_degrees) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'tilt_position_down_angle_degrees) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'tilt_steps) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'cycle_time_sec) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<lidar_control-request>)))
  "Returns string type for a service object of type '<lidar_control-request>"
  "phidgets/lidar_controlRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'lidar_control-request)))
  "Returns string type for a service object of type 'lidar_control-request"
  "phidgets/lidar_controlRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<lidar_control-request>)))
  "Returns md5sum for a message object of type '<lidar_control-request>"
  "63541d856b007db47fcb5fb28b699f7b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'lidar_control-request)))
  "Returns md5sum for a message object of type 'lidar_control-request"
  "63541d856b007db47fcb5fb28b699f7b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<lidar_control-request>)))
  "Returns full string definition for message of type '<lidar_control-request>"
  (cl:format cl:nil "bool pause~%int32 pan_servo_index~%int32 tilt_servo_index~%int32 sensor_index~%int32 no_of_sensors~%int32[] sensor_type~%int32[] sensor_coupling~%float32 speed~%float32 acceleration~%float32 pan_position_left~%float32 pan_position_right~%float32 pan_position_left_angle_degrees~%float32 pan_position_right_angle_degrees~%float32 tilt_position_up~%float32 tilt_position_down~%float32 tilt_position_up_angle_degrees~%float32 tilt_position_down_angle_degrees~%int32 tilt_steps~%float32 cycle_time_sec~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'lidar_control-request)))
  "Returns full string definition for message of type 'lidar_control-request"
  (cl:format cl:nil "bool pause~%int32 pan_servo_index~%int32 tilt_servo_index~%int32 sensor_index~%int32 no_of_sensors~%int32[] sensor_type~%int32[] sensor_coupling~%float32 speed~%float32 acceleration~%float32 pan_position_left~%float32 pan_position_right~%float32 pan_position_left_angle_degrees~%float32 pan_position_right_angle_degrees~%float32 tilt_position_up~%float32 tilt_position_down~%float32 tilt_position_up_angle_degrees~%float32 tilt_position_down_angle_degrees~%int32 tilt_steps~%float32 cycle_time_sec~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <lidar_control-request>))
  (cl:+ 0
     1
     4
     4
     4
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'sensor_type) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'sensor_coupling) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4
     4
     4
     4
     4
     4
     4
     4
     4
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <lidar_control-request>))
  "Converts a ROS message object to a list"
  (cl:list 'lidar_control-request
    (cl:cons ':pause (pause msg))
    (cl:cons ':pan_servo_index (pan_servo_index msg))
    (cl:cons ':tilt_servo_index (tilt_servo_index msg))
    (cl:cons ':sensor_index (sensor_index msg))
    (cl:cons ':no_of_sensors (no_of_sensors msg))
    (cl:cons ':sensor_type (sensor_type msg))
    (cl:cons ':sensor_coupling (sensor_coupling msg))
    (cl:cons ':speed (speed msg))
    (cl:cons ':acceleration (acceleration msg))
    (cl:cons ':pan_position_left (pan_position_left msg))
    (cl:cons ':pan_position_right (pan_position_right msg))
    (cl:cons ':pan_position_left_angle_degrees (pan_position_left_angle_degrees msg))
    (cl:cons ':pan_position_right_angle_degrees (pan_position_right_angle_degrees msg))
    (cl:cons ':tilt_position_up (tilt_position_up msg))
    (cl:cons ':tilt_position_down (tilt_position_down msg))
    (cl:cons ':tilt_position_up_angle_degrees (tilt_position_up_angle_degrees msg))
    (cl:cons ':tilt_position_down_angle_degrees (tilt_position_down_angle_degrees msg))
    (cl:cons ':tilt_steps (tilt_steps msg))
    (cl:cons ':cycle_time_sec (cycle_time_sec msg))
))
;//! \htmlinclude lidar_control-response.msg.html

(cl:defclass <lidar_control-response> (roslisp-msg-protocol:ros-message)
  ((ack
    :reader ack
    :initarg :ack
    :type cl:integer
    :initform 0))
)

(cl:defclass lidar_control-response (<lidar_control-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <lidar_control-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'lidar_control-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name phidgets-srv:<lidar_control-response> is deprecated: use phidgets-srv:lidar_control-response instead.")))

(cl:ensure-generic-function 'ack-val :lambda-list '(m))
(cl:defmethod ack-val ((m <lidar_control-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader phidgets-srv:ack-val is deprecated.  Use phidgets-srv:ack instead.")
  (ack m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <lidar_control-response>) ostream)
  "Serializes a message object of type '<lidar_control-response>"
  (cl:let* ((signed (cl:slot-value msg 'ack)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <lidar_control-response>) istream)
  "Deserializes a message object of type '<lidar_control-response>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'ack) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<lidar_control-response>)))
  "Returns string type for a service object of type '<lidar_control-response>"
  "phidgets/lidar_controlResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'lidar_control-response)))
  "Returns string type for a service object of type 'lidar_control-response"
  "phidgets/lidar_controlResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<lidar_control-response>)))
  "Returns md5sum for a message object of type '<lidar_control-response>"
  "63541d856b007db47fcb5fb28b699f7b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'lidar_control-response)))
  "Returns md5sum for a message object of type 'lidar_control-response"
  "63541d856b007db47fcb5fb28b699f7b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<lidar_control-response>)))
  "Returns full string definition for message of type '<lidar_control-response>"
  (cl:format cl:nil "int32 ack~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'lidar_control-response)))
  "Returns full string definition for message of type 'lidar_control-response"
  (cl:format cl:nil "int32 ack~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <lidar_control-response>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <lidar_control-response>))
  "Converts a ROS message object to a list"
  (cl:list 'lidar_control-response
    (cl:cons ':ack (ack msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'lidar_control)))
  'lidar_control-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'lidar_control)))
  'lidar_control-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'lidar_control)))
  "Returns string type for a service object of type '<lidar_control>"
  "phidgets/lidar_control")