;; Auto-generated. Do not edit!


(when (boundp 'ras_lab1_msgs::ADConverter)
  (if (not (find-package "RAS_LAB1_MSGS"))
    (make-package "RAS_LAB1_MSGS"))
  (shadow 'ADConverter (find-package "RAS_LAB1_MSGS")))
(unless (find-package "RAS_LAB1_MSGS::ADCONVERTER")
  (make-package "RAS_LAB1_MSGS::ADCONVERTER"))

(in-package "ROS")
;;//! \htmlinclude ADConverter.msg.html


(defclass ras_lab1_msgs::ADConverter
  :super ros::object
  :slots (_ch1 _ch2 _ch3 _ch4 _ch5 _ch6 _ch7 _ch8 ))

(defmethod ras_lab1_msgs::ADConverter
  (:init
   (&key
    ((:ch1 __ch1) 0)
    ((:ch2 __ch2) 0)
    ((:ch3 __ch3) 0)
    ((:ch4 __ch4) 0)
    ((:ch5 __ch5) 0)
    ((:ch6 __ch6) 0)
    ((:ch7 __ch7) 0)
    ((:ch8 __ch8) 0)
    )
   (send-super :init)
   (setq _ch1 (round __ch1))
   (setq _ch2 (round __ch2))
   (setq _ch3 (round __ch3))
   (setq _ch4 (round __ch4))
   (setq _ch5 (round __ch5))
   (setq _ch6 (round __ch6))
   (setq _ch7 (round __ch7))
   (setq _ch8 (round __ch8))
   self)
  (:ch1
   (&optional __ch1)
   (if __ch1 (setq _ch1 __ch1)) _ch1)
  (:ch2
   (&optional __ch2)
   (if __ch2 (setq _ch2 __ch2)) _ch2)
  (:ch3
   (&optional __ch3)
   (if __ch3 (setq _ch3 __ch3)) _ch3)
  (:ch4
   (&optional __ch4)
   (if __ch4 (setq _ch4 __ch4)) _ch4)
  (:ch5
   (&optional __ch5)
   (if __ch5 (setq _ch5 __ch5)) _ch5)
  (:ch6
   (&optional __ch6)
   (if __ch6 (setq _ch6 __ch6)) _ch6)
  (:ch7
   (&optional __ch7)
   (if __ch7 (setq _ch7 __ch7)) _ch7)
  (:ch8
   (&optional __ch8)
   (if __ch8 (setq _ch8 __ch8)) _ch8)
  (:serialization-length
   ()
   (+
    ;; uint16 _ch1
    2
    ;; uint16 _ch2
    2
    ;; uint16 _ch3
    2
    ;; uint16 _ch4
    2
    ;; uint16 _ch5
    2
    ;; uint16 _ch6
    2
    ;; uint16 _ch7
    2
    ;; uint16 _ch8
    2
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint16 _ch1
       (write-word _ch1 s)
     ;; uint16 _ch2
       (write-word _ch2 s)
     ;; uint16 _ch3
       (write-word _ch3 s)
     ;; uint16 _ch4
       (write-word _ch4 s)
     ;; uint16 _ch5
       (write-word _ch5 s)
     ;; uint16 _ch6
       (write-word _ch6 s)
     ;; uint16 _ch7
       (write-word _ch7 s)
     ;; uint16 _ch8
       (write-word _ch8 s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint16 _ch1
     (setq _ch1 (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; uint16 _ch2
     (setq _ch2 (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; uint16 _ch3
     (setq _ch3 (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; uint16 _ch4
     (setq _ch4 (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; uint16 _ch5
     (setq _ch5 (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; uint16 _ch6
     (setq _ch6 (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; uint16 _ch7
     (setq _ch7 (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; uint16 _ch8
     (setq _ch8 (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;;
   self)
  )

(setf (get ras_lab1_msgs::ADConverter :md5sum-) "a5aa1c52a7841be08d11353384df8a9c")
(setf (get ras_lab1_msgs::ADConverter :datatype-) "ras_lab1_msgs/ADConverter")
(setf (get ras_lab1_msgs::ADConverter :definition-)
      "# 8 * uint16 for IR sensors
uint16 ch1
uint16 ch2
uint16 ch3
uint16 ch4
uint16 ch5
uint16 ch6
uint16 ch7
uint16 ch8



")



(provide :ras_lab1_msgs/ADConverter "a5aa1c52a7841be08d11353384df8a9c")


