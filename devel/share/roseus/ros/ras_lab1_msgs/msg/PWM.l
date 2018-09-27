;; Auto-generated. Do not edit!


(when (boundp 'ras_lab1_msgs::PWM)
  (if (not (find-package "RAS_LAB1_MSGS"))
    (make-package "RAS_LAB1_MSGS"))
  (shadow 'PWM (find-package "RAS_LAB1_MSGS")))
(unless (find-package "RAS_LAB1_MSGS::PWM")
  (make-package "RAS_LAB1_MSGS::PWM"))

(in-package "ROS")
;;//! \htmlinclude PWM.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass ras_lab1_msgs::PWM
  :super ros::object
  :slots (_header _PWM1 _PWM2 ))

(defmethod ras_lab1_msgs::PWM
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:PWM1 __PWM1) 0)
    ((:PWM2 __PWM2) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _PWM1 (round __PWM1))
   (setq _PWM2 (round __PWM2))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:PWM1
   (&optional __PWM1)
   (if __PWM1 (setq _PWM1 __PWM1)) _PWM1)
  (:PWM2
   (&optional __PWM2)
   (if __PWM2 (setq _PWM2 __PWM2)) _PWM2)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int32 _PWM1
    4
    ;; int32 _PWM2
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int32 _PWM1
       (write-long _PWM1 s)
     ;; int32 _PWM2
       (write-long _PWM2 s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int32 _PWM1
     (setq _PWM1 (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _PWM2
     (setq _PWM2 (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get ras_lab1_msgs::PWM :md5sum-) "7536f824b238f3bc8ae162f5a97c5bfc")
(setf (get ras_lab1_msgs::PWM :datatype-) "ras_lab1_msgs/PWM")
(setf (get ras_lab1_msgs::PWM :definition-)
      "# PWM should be between -255 and 255
# 1 --> left
# 2 --> right
Header header

int32 PWM1
int32 PWM2
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



(provide :ras_lab1_msgs/PWM "7536f824b238f3bc8ae162f5a97c5bfc")


