;; Auto-generated. Do not edit!


(when (boundp 'phidgets::lidar_control)
  (if (not (find-package "PHIDGETS"))
    (make-package "PHIDGETS"))
  (shadow 'lidar_control (find-package "PHIDGETS")))
(unless (find-package "PHIDGETS::LIDAR_CONTROL")
  (make-package "PHIDGETS::LIDAR_CONTROL"))
(unless (find-package "PHIDGETS::LIDAR_CONTROLREQUEST")
  (make-package "PHIDGETS::LIDAR_CONTROLREQUEST"))
(unless (find-package "PHIDGETS::LIDAR_CONTROLRESPONSE")
  (make-package "PHIDGETS::LIDAR_CONTROLRESPONSE"))

(in-package "ROS")





(defclass phidgets::lidar_controlRequest
  :super ros::object
  :slots (_pause _pan_servo_index _tilt_servo_index _sensor_index _no_of_sensors _sensor_type _sensor_coupling _speed _acceleration _pan_position_left _pan_position_right _pan_position_left_angle_degrees _pan_position_right_angle_degrees _tilt_position_up _tilt_position_down _tilt_position_up_angle_degrees _tilt_position_down_angle_degrees _tilt_steps _cycle_time_sec ))

(defmethod phidgets::lidar_controlRequest
  (:init
   (&key
    ((:pause __pause) nil)
    ((:pan_servo_index __pan_servo_index) 0)
    ((:tilt_servo_index __tilt_servo_index) 0)
    ((:sensor_index __sensor_index) 0)
    ((:no_of_sensors __no_of_sensors) 0)
    ((:sensor_type __sensor_type) (make-array 0 :initial-element 0 :element-type :integer))
    ((:sensor_coupling __sensor_coupling) (make-array 0 :initial-element 0 :element-type :integer))
    ((:speed __speed) 0.0)
    ((:acceleration __acceleration) 0.0)
    ((:pan_position_left __pan_position_left) 0.0)
    ((:pan_position_right __pan_position_right) 0.0)
    ((:pan_position_left_angle_degrees __pan_position_left_angle_degrees) 0.0)
    ((:pan_position_right_angle_degrees __pan_position_right_angle_degrees) 0.0)
    ((:tilt_position_up __tilt_position_up) 0.0)
    ((:tilt_position_down __tilt_position_down) 0.0)
    ((:tilt_position_up_angle_degrees __tilt_position_up_angle_degrees) 0.0)
    ((:tilt_position_down_angle_degrees __tilt_position_down_angle_degrees) 0.0)
    ((:tilt_steps __tilt_steps) 0)
    ((:cycle_time_sec __cycle_time_sec) 0.0)
    )
   (send-super :init)
   (setq _pause __pause)
   (setq _pan_servo_index (round __pan_servo_index))
   (setq _tilt_servo_index (round __tilt_servo_index))
   (setq _sensor_index (round __sensor_index))
   (setq _no_of_sensors (round __no_of_sensors))
   (setq _sensor_type __sensor_type)
   (setq _sensor_coupling __sensor_coupling)
   (setq _speed (float __speed))
   (setq _acceleration (float __acceleration))
   (setq _pan_position_left (float __pan_position_left))
   (setq _pan_position_right (float __pan_position_right))
   (setq _pan_position_left_angle_degrees (float __pan_position_left_angle_degrees))
   (setq _pan_position_right_angle_degrees (float __pan_position_right_angle_degrees))
   (setq _tilt_position_up (float __tilt_position_up))
   (setq _tilt_position_down (float __tilt_position_down))
   (setq _tilt_position_up_angle_degrees (float __tilt_position_up_angle_degrees))
   (setq _tilt_position_down_angle_degrees (float __tilt_position_down_angle_degrees))
   (setq _tilt_steps (round __tilt_steps))
   (setq _cycle_time_sec (float __cycle_time_sec))
   self)
  (:pause
   (&optional __pause)
   (if __pause (setq _pause __pause)) _pause)
  (:pan_servo_index
   (&optional __pan_servo_index)
   (if __pan_servo_index (setq _pan_servo_index __pan_servo_index)) _pan_servo_index)
  (:tilt_servo_index
   (&optional __tilt_servo_index)
   (if __tilt_servo_index (setq _tilt_servo_index __tilt_servo_index)) _tilt_servo_index)
  (:sensor_index
   (&optional __sensor_index)
   (if __sensor_index (setq _sensor_index __sensor_index)) _sensor_index)
  (:no_of_sensors
   (&optional __no_of_sensors)
   (if __no_of_sensors (setq _no_of_sensors __no_of_sensors)) _no_of_sensors)
  (:sensor_type
   (&optional __sensor_type)
   (if __sensor_type (setq _sensor_type __sensor_type)) _sensor_type)
  (:sensor_coupling
   (&optional __sensor_coupling)
   (if __sensor_coupling (setq _sensor_coupling __sensor_coupling)) _sensor_coupling)
  (:speed
   (&optional __speed)
   (if __speed (setq _speed __speed)) _speed)
  (:acceleration
   (&optional __acceleration)
   (if __acceleration (setq _acceleration __acceleration)) _acceleration)
  (:pan_position_left
   (&optional __pan_position_left)
   (if __pan_position_left (setq _pan_position_left __pan_position_left)) _pan_position_left)
  (:pan_position_right
   (&optional __pan_position_right)
   (if __pan_position_right (setq _pan_position_right __pan_position_right)) _pan_position_right)
  (:pan_position_left_angle_degrees
   (&optional __pan_position_left_angle_degrees)
   (if __pan_position_left_angle_degrees (setq _pan_position_left_angle_degrees __pan_position_left_angle_degrees)) _pan_position_left_angle_degrees)
  (:pan_position_right_angle_degrees
   (&optional __pan_position_right_angle_degrees)
   (if __pan_position_right_angle_degrees (setq _pan_position_right_angle_degrees __pan_position_right_angle_degrees)) _pan_position_right_angle_degrees)
  (:tilt_position_up
   (&optional __tilt_position_up)
   (if __tilt_position_up (setq _tilt_position_up __tilt_position_up)) _tilt_position_up)
  (:tilt_position_down
   (&optional __tilt_position_down)
   (if __tilt_position_down (setq _tilt_position_down __tilt_position_down)) _tilt_position_down)
  (:tilt_position_up_angle_degrees
   (&optional __tilt_position_up_angle_degrees)
   (if __tilt_position_up_angle_degrees (setq _tilt_position_up_angle_degrees __tilt_position_up_angle_degrees)) _tilt_position_up_angle_degrees)
  (:tilt_position_down_angle_degrees
   (&optional __tilt_position_down_angle_degrees)
   (if __tilt_position_down_angle_degrees (setq _tilt_position_down_angle_degrees __tilt_position_down_angle_degrees)) _tilt_position_down_angle_degrees)
  (:tilt_steps
   (&optional __tilt_steps)
   (if __tilt_steps (setq _tilt_steps __tilt_steps)) _tilt_steps)
  (:cycle_time_sec
   (&optional __cycle_time_sec)
   (if __cycle_time_sec (setq _cycle_time_sec __cycle_time_sec)) _cycle_time_sec)
  (:serialization-length
   ()
   (+
    ;; bool _pause
    1
    ;; int32 _pan_servo_index
    4
    ;; int32 _tilt_servo_index
    4
    ;; int32 _sensor_index
    4
    ;; int32 _no_of_sensors
    4
    ;; int32[] _sensor_type
    (* 4    (length _sensor_type)) 4
    ;; int32[] _sensor_coupling
    (* 4    (length _sensor_coupling)) 4
    ;; float32 _speed
    4
    ;; float32 _acceleration
    4
    ;; float32 _pan_position_left
    4
    ;; float32 _pan_position_right
    4
    ;; float32 _pan_position_left_angle_degrees
    4
    ;; float32 _pan_position_right_angle_degrees
    4
    ;; float32 _tilt_position_up
    4
    ;; float32 _tilt_position_down
    4
    ;; float32 _tilt_position_up_angle_degrees
    4
    ;; float32 _tilt_position_down_angle_degrees
    4
    ;; int32 _tilt_steps
    4
    ;; float32 _cycle_time_sec
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _pause
       (if _pause (write-byte -1 s) (write-byte 0 s))
     ;; int32 _pan_servo_index
       (write-long _pan_servo_index s)
     ;; int32 _tilt_servo_index
       (write-long _tilt_servo_index s)
     ;; int32 _sensor_index
       (write-long _sensor_index s)
     ;; int32 _no_of_sensors
       (write-long _no_of_sensors s)
     ;; int32[] _sensor_type
     (write-long (length _sensor_type) s)
     (dotimes (i (length _sensor_type))
       (write-long (elt _sensor_type i) s)
       )
     ;; int32[] _sensor_coupling
     (write-long (length _sensor_coupling) s)
     (dotimes (i (length _sensor_coupling))
       (write-long (elt _sensor_coupling i) s)
       )
     ;; float32 _speed
       (sys::poke _speed (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _acceleration
       (sys::poke _acceleration (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _pan_position_left
       (sys::poke _pan_position_left (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _pan_position_right
       (sys::poke _pan_position_right (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _pan_position_left_angle_degrees
       (sys::poke _pan_position_left_angle_degrees (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _pan_position_right_angle_degrees
       (sys::poke _pan_position_right_angle_degrees (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _tilt_position_up
       (sys::poke _tilt_position_up (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _tilt_position_down
       (sys::poke _tilt_position_down (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _tilt_position_up_angle_degrees
       (sys::poke _tilt_position_up_angle_degrees (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _tilt_position_down_angle_degrees
       (sys::poke _tilt_position_down_angle_degrees (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int32 _tilt_steps
       (write-long _tilt_steps s)
     ;; float32 _cycle_time_sec
       (sys::poke _cycle_time_sec (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _pause
     (setq _pause (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; int32 _pan_servo_index
     (setq _pan_servo_index (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _tilt_servo_index
     (setq _tilt_servo_index (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _sensor_index
     (setq _sensor_index (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _no_of_sensors
     (setq _no_of_sensors (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32[] _sensor_type
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _sensor_type (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _sensor_type i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; int32[] _sensor_coupling
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _sensor_coupling (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _sensor_coupling i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; float32 _speed
     (setq _speed (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _acceleration
     (setq _acceleration (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _pan_position_left
     (setq _pan_position_left (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _pan_position_right
     (setq _pan_position_right (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _pan_position_left_angle_degrees
     (setq _pan_position_left_angle_degrees (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _pan_position_right_angle_degrees
     (setq _pan_position_right_angle_degrees (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _tilt_position_up
     (setq _tilt_position_up (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _tilt_position_down
     (setq _tilt_position_down (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _tilt_position_up_angle_degrees
     (setq _tilt_position_up_angle_degrees (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _tilt_position_down_angle_degrees
     (setq _tilt_position_down_angle_degrees (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int32 _tilt_steps
     (setq _tilt_steps (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _cycle_time_sec
     (setq _cycle_time_sec (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(defclass phidgets::lidar_controlResponse
  :super ros::object
  :slots (_ack ))

(defmethod phidgets::lidar_controlResponse
  (:init
   (&key
    ((:ack __ack) 0)
    )
   (send-super :init)
   (setq _ack (round __ack))
   self)
  (:ack
   (&optional __ack)
   (if __ack (setq _ack __ack)) _ack)
  (:serialization-length
   ()
   (+
    ;; int32 _ack
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _ack
       (write-long _ack s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _ack
     (setq _ack (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(defclass phidgets::lidar_control
  :super ros::object
  :slots ())

(setf (get phidgets::lidar_control :md5sum-) "63541d856b007db47fcb5fb28b699f7b")
(setf (get phidgets::lidar_control :datatype-) "phidgets/lidar_control")
(setf (get phidgets::lidar_control :request) phidgets::lidar_controlRequest)
(setf (get phidgets::lidar_control :response) phidgets::lidar_controlResponse)

(defmethod phidgets::lidar_controlRequest
  (:response () (instance phidgets::lidar_controlResponse :init)))

(setf (get phidgets::lidar_controlRequest :md5sum-) "63541d856b007db47fcb5fb28b699f7b")
(setf (get phidgets::lidar_controlRequest :datatype-) "phidgets/lidar_controlRequest")
(setf (get phidgets::lidar_controlRequest :definition-)
      "bool pause
int32 pan_servo_index
int32 tilt_servo_index
int32 sensor_index
int32 no_of_sensors
int32[] sensor_type
int32[] sensor_coupling
float32 speed
float32 acceleration
float32 pan_position_left
float32 pan_position_right
float32 pan_position_left_angle_degrees
float32 pan_position_right_angle_degrees
float32 tilt_position_up
float32 tilt_position_down
float32 tilt_position_up_angle_degrees
float32 tilt_position_down_angle_degrees
int32 tilt_steps
float32 cycle_time_sec
---
int32 ack

")

(setf (get phidgets::lidar_controlResponse :md5sum-) "63541d856b007db47fcb5fb28b699f7b")
(setf (get phidgets::lidar_controlResponse :datatype-) "phidgets/lidar_controlResponse")
(setf (get phidgets::lidar_controlResponse :definition-)
      "bool pause
int32 pan_servo_index
int32 tilt_servo_index
int32 sensor_index
int32 no_of_sensors
int32[] sensor_type
int32[] sensor_coupling
float32 speed
float32 acceleration
float32 pan_position_left
float32 pan_position_right
float32 pan_position_left_angle_degrees
float32 pan_position_right_angle_degrees
float32 tilt_position_up
float32 tilt_position_down
float32 tilt_position_up_angle_degrees
float32 tilt_position_down_angle_degrees
int32 tilt_steps
float32 cycle_time_sec
---
int32 ack

")



(provide :phidgets/lidar_control "63541d856b007db47fcb5fb28b699f7b")


