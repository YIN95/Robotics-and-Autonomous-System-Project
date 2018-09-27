;; Auto-generated. Do not edit!


(when (boundp 'phidgets::motor_params)
  (if (not (find-package "PHIDGETS"))
    (make-package "PHIDGETS"))
  (shadow 'motor_params (find-package "PHIDGETS")))
(unless (find-package "PHIDGETS::MOTOR_PARAMS")
  (make-package "PHIDGETS::MOTOR_PARAMS"))

(in-package "ROS")
;;//! \htmlinclude motor_params.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass phidgets::motor_params
  :super ros::object
  :slots (_header _index _value_type _value ))

(defmethod phidgets::motor_params
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:index __index) 0)
    ((:value_type __value_type) 0)
    ((:value __value) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _index (round __index))
   (setq _value_type (round __value_type))
   (setq _value (float __value))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:index
   (&optional __index)
   (if __index (setq _index __index)) _index)
  (:value_type
   (&optional __value_type)
   (if __value_type (setq _value_type __value_type)) _value_type)
  (:value
   (&optional __value)
   (if __value (setq _value __value)) _value)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int32 _index
    4
    ;; int32 _value_type
    4
    ;; float32 _value
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int32 _index
       (write-long _index s)
     ;; int32 _value_type
       (write-long _value_type s)
     ;; float32 _value
       (sys::poke _value (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int32 _index
     (setq _index (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _value_type
     (setq _value_type (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _value
     (setq _value (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get phidgets::motor_params :md5sum-) "f2429810841a3fec55ae6be1e714f34f")
(setf (get phidgets::motor_params :datatype-) "phidgets/motor_params")
(setf (get phidgets::motor_params :definition-)
      "Header header
int32 index
int32 value_type
float32 value

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
# 0: no frame
# 1: global frame
string frame_id

")



(provide :phidgets/motor_params "f2429810841a3fec55ae6be1e714f34f")


