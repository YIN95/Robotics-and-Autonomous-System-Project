;; Auto-generated. Do not edit!


(when (boundp 'ras_lab1_msgs::WheelAngularVelocities)
  (if (not (find-package "RAS_LAB1_MSGS"))
    (make-package "RAS_LAB1_MSGS"))
  (shadow 'WheelAngularVelocities (find-package "RAS_LAB1_MSGS")))
(unless (find-package "RAS_LAB1_MSGS::WHEELANGULARVELOCITIES")
  (make-package "RAS_LAB1_MSGS::WHEELANGULARVELOCITIES"))

(in-package "ROS")
;;//! \htmlinclude WheelAngularVelocities.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass ras_lab1_msgs::WheelAngularVelocities
  :super ros::object
  :slots (_header _W1 _W2 ))

(defmethod ras_lab1_msgs::WheelAngularVelocities
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:W1 __W1) 0.0)
    ((:W2 __W2) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _W1 (float __W1))
   (setq _W2 (float __W2))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:W1
   (&optional __W1)
   (if __W1 (setq _W1 __W1)) _W1)
  (:W2
   (&optional __W2)
   (if __W2 (setq _W2 __W2)) _W2)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _W1
    4
    ;; float32 _W2
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _W1
       (sys::poke _W1 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _W2
       (sys::poke _W2 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _W1
     (setq _W1 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _W2
     (setq _W2 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get ras_lab1_msgs::WheelAngularVelocities :md5sum-) "ae0c4a7348b1a8bfa79b856330d95cad")
(setf (get ras_lab1_msgs::WheelAngularVelocities :datatype-) "ras_lab1_msgs/WheelAngularVelocities")
(setf (get ras_lab1_msgs::WheelAngularVelocities :definition-)
      "Header header

float32 W1
float32 W2
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



(provide :ras_lab1_msgs/WheelAngularVelocities "ae0c4a7348b1a8bfa79b856330d95cad")


