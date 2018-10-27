;; Auto-generated. Do not edit!


(when (boundp 'ras_lab1_msgs::BatteryStatus)
  (if (not (find-package "RAS_LAB1_MSGS"))
    (make-package "RAS_LAB1_MSGS"))
  (shadow 'BatteryStatus (find-package "RAS_LAB1_MSGS")))
(unless (find-package "RAS_LAB1_MSGS::BATTERYSTATUS")
  (make-package "RAS_LAB1_MSGS::BATTERYSTATUS"))

(in-package "ROS")
;;//! \htmlinclude BatteryStatus.msg.html


(defclass ras_lab1_msgs::BatteryStatus
  :super ros::object
  :slots (_on_batt _cell1 _cell2 _cell3 ))

(defmethod ras_lab1_msgs::BatteryStatus
  (:init
   (&key
    ((:on_batt __on_batt) 0)
    ((:cell1 __cell1) 0.0)
    ((:cell2 __cell2) 0.0)
    ((:cell3 __cell3) 0.0)
    )
   (send-super :init)
   (setq _on_batt (round __on_batt))
   (setq _cell1 (float __cell1))
   (setq _cell2 (float __cell2))
   (setq _cell3 (float __cell3))
   self)
  (:on_batt
   (&optional __on_batt)
   (if __on_batt (setq _on_batt __on_batt)) _on_batt)
  (:cell1
   (&optional __cell1)
   (if __cell1 (setq _cell1 __cell1)) _cell1)
  (:cell2
   (&optional __cell2)
   (if __cell2 (setq _cell2 __cell2)) _cell2)
  (:cell3
   (&optional __cell3)
   (if __cell3 (setq _cell3 __cell3)) _cell3)
  (:serialization-length
   ()
   (+
    ;; uint8 _on_batt
    1
    ;; float32 _cell1
    4
    ;; float32 _cell2
    4
    ;; float32 _cell3
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _on_batt
       (write-byte _on_batt s)
     ;; float32 _cell1
       (sys::poke _cell1 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _cell2
       (sys::poke _cell2 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _cell3
       (sys::poke _cell3 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _on_batt
     (setq _on_batt (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32 _cell1
     (setq _cell1 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _cell2
     (setq _cell2 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _cell3
     (setq _cell3 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get ras_lab1_msgs::BatteryStatus :md5sum-) "0cacd621f2d12e6814d77d4a2f6b6051")
(setf (get ras_lab1_msgs::BatteryStatus :datatype-) "ras_lab1_msgs/BatteryStatus")
(setf (get ras_lab1_msgs::BatteryStatus :definition-)
      "# Say if battery is in use, of if a wall adaptator is present
# value : 1 if on battery, 0 if adaptator present
uint8 on_batt

# cell voltage
float32 cell1
float32 cell2
float32 cell3




")



(provide :ras_lab1_msgs/BatteryStatus "0cacd621f2d12e6814d77d4a2f6b6051")


