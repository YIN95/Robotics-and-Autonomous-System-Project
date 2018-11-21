;; Auto-generated. Do not edit!


(when (boundp 'ras_lab1_msgs::Encoders)
  (if (not (find-package "RAS_LAB1_MSGS"))
    (make-package "RAS_LAB1_MSGS"))
  (shadow 'Encoders (find-package "RAS_LAB1_MSGS")))
(unless (find-package "RAS_LAB1_MSGS::ENCODERS")
  (make-package "RAS_LAB1_MSGS::ENCODERS"))

(in-package "ROS")
;;//! \htmlinclude Encoders.msg.html


(defclass ras_lab1_msgs::Encoders
  :super ros::object
  :slots (_encoder1 _encoder2 _delta_encoder1 _delta_encoder2 _timestamp ))

(defmethod ras_lab1_msgs::Encoders
  (:init
   (&key
    ((:encoder1 __encoder1) 0)
    ((:encoder2 __encoder2) 0)
    ((:delta_encoder1 __delta_encoder1) 0)
    ((:delta_encoder2 __delta_encoder2) 0)
    ((:timestamp __timestamp) 0)
    )
   (send-super :init)
   (setq _encoder1 (round __encoder1))
   (setq _encoder2 (round __encoder2))
   (setq _delta_encoder1 (round __delta_encoder1))
   (setq _delta_encoder2 (round __delta_encoder2))
   (setq _timestamp (round __timestamp))
   self)
  (:encoder1
   (&optional __encoder1)
   (if __encoder1 (setq _encoder1 __encoder1)) _encoder1)
  (:encoder2
   (&optional __encoder2)
   (if __encoder2 (setq _encoder2 __encoder2)) _encoder2)
  (:delta_encoder1
   (&optional __delta_encoder1)
   (if __delta_encoder1 (setq _delta_encoder1 __delta_encoder1)) _delta_encoder1)
  (:delta_encoder2
   (&optional __delta_encoder2)
   (if __delta_encoder2 (setq _delta_encoder2 __delta_encoder2)) _delta_encoder2)
  (:timestamp
   (&optional __timestamp)
   (if __timestamp (setq _timestamp __timestamp)) _timestamp)
  (:serialization-length
   ()
   (+
    ;; int32 _encoder1
    4
    ;; int32 _encoder2
    4
    ;; int32 _delta_encoder1
    4
    ;; int32 _delta_encoder2
    4
    ;; int32 _timestamp
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _encoder1
       (write-long _encoder1 s)
     ;; int32 _encoder2
       (write-long _encoder2 s)
     ;; int32 _delta_encoder1
       (write-long _delta_encoder1 s)
     ;; int32 _delta_encoder2
       (write-long _delta_encoder2 s)
     ;; int32 _timestamp
       (write-long _timestamp s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _encoder1
     (setq _encoder1 (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _encoder2
     (setq _encoder2 (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _delta_encoder1
     (setq _delta_encoder1 (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _delta_encoder2
     (setq _delta_encoder2 (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _timestamp
     (setq _timestamp (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get ras_lab1_msgs::Encoders :md5sum-) "6363193e7f66cd2bf0e60c5eb25e1bd5")
(setf (get ras_lab1_msgs::Encoders :datatype-) "ras_lab1_msgs/Encoders")
(setf (get ras_lab1_msgs::Encoders :definition-)
      "# encoder: absolute encoder value
# delta_encoder: differential encoder value
# tiemstamp: in milliseconds
# 1 --> left
# 2 --> right
int32 encoder1
int32 encoder2
int32 delta_encoder1
int32 delta_encoder2
int32 timestamp


")



(provide :ras_lab1_msgs/Encoders "6363193e7f66cd2bf0e60c5eb25e1bd5")


