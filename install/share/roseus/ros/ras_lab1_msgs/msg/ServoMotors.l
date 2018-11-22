;; Auto-generated. Do not edit!


(when (boundp 'ras_lab1_msgs::ServoMotors)
  (if (not (find-package "RAS_LAB1_MSGS"))
    (make-package "RAS_LAB1_MSGS"))
  (shadow 'ServoMotors (find-package "RAS_LAB1_MSGS")))
(unless (find-package "RAS_LAB1_MSGS::SERVOMOTORS")
  (make-package "RAS_LAB1_MSGS::SERVOMOTORS"))

(in-package "ROS")
;;//! \htmlinclude ServoMotors.msg.html


(defclass ras_lab1_msgs::ServoMotors
  :super ros::object
  :slots (_servo1 _servoangle ))

(defmethod ras_lab1_msgs::ServoMotors
  (:init
   (&key
    ((:servo1 __servo1) 0)
    ((:servoangle __servoangle) (make-array 8 :initial-element 0 :element-type :char))
    )
   (send-super :init)
   (setq _servo1 (round __servo1))
   (setq _servoangle __servoangle)
   self)
  (:servo1
   (&optional __servo1)
   (if __servo1 (setq _servo1 __servo1)) _servo1)
  (:servoangle
   (&optional __servoangle)
   (if __servoangle (setq _servoangle __servoangle)) _servoangle)
  (:serialization-length
   ()
   (+
    ;; uint8 _servo1
    1
    ;; uint8[8] _servoangle
    (* 1    8)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _servo1
       (write-byte _servo1 s)
     ;; uint8[8] _servoangle
     (princ _servoangle s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _servo1
     (setq _servo1 (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8[8] _servoangle
   (setq _servoangle (make-array 8 :element-type :char))
   (replace _servoangle buf :start2 ptr-) (incf ptr- 8)
   ;;
   self)
  )

(setf (get ras_lab1_msgs::ServoMotors :md5sum-) "f51d948c20e299a516b60c1bba9b447f")
(setf (get ras_lab1_msgs::ServoMotors :datatype-) "ras_lab1_msgs/ServoMotors")
(setf (get ras_lab1_msgs::ServoMotors :definition-)
      "# desired angular position
# range 0-180 degrees

uint8 servo1
uint8[8] servoangle

")



(provide :ras_lab1_msgs/ServoMotors "f51d948c20e299a516b60c1bba9b447f")


