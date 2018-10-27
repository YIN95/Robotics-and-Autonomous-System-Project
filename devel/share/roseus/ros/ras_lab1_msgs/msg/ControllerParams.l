;; Auto-generated. Do not edit!


(when (boundp 'ras_lab1_msgs::ControllerParams)
  (if (not (find-package "RAS_LAB1_MSGS"))
    (make-package "RAS_LAB1_MSGS"))
  (shadow 'ControllerParams (find-package "RAS_LAB1_MSGS")))
(unless (find-package "RAS_LAB1_MSGS::CONTROLLERPARAMS")
  (make-package "RAS_LAB1_MSGS::CONTROLLERPARAMS"))

(in-package "ROS")
;;//! \htmlinclude ControllerParams.msg.html


(defclass ras_lab1_msgs::ControllerParams
  :super ros::object
  :slots (_K _KI _INT_MAX _ticks _r _r_l _r_r _B ))

(defmethod ras_lab1_msgs::ControllerParams
  (:init
   (&key
    ((:K __K) 0)
    ((:KI __KI) 0)
    ((:INT_MAX __INT_MAX) 0)
    ((:ticks __ticks) 0)
    ((:r __r) 0.0)
    ((:r_l __r_l) 0.0)
    ((:r_r __r_r) 0.0)
    ((:B __B) 0.0)
    )
   (send-super :init)
   (setq _K (round __K))
   (setq _KI (round __KI))
   (setq _INT_MAX (round __INT_MAX))
   (setq _ticks (round __ticks))
   (setq _r (float __r))
   (setq _r_l (float __r_l))
   (setq _r_r (float __r_r))
   (setq _B (float __B))
   self)
  (:K
   (&optional __K)
   (if __K (setq _K __K)) _K)
  (:KI
   (&optional __KI)
   (if __KI (setq _KI __KI)) _KI)
  (:INT_MAX
   (&optional __INT_MAX)
   (if __INT_MAX (setq _INT_MAX __INT_MAX)) _INT_MAX)
  (:ticks
   (&optional __ticks)
   (if __ticks (setq _ticks __ticks)) _ticks)
  (:r
   (&optional __r)
   (if __r (setq _r __r)) _r)
  (:r_l
   (&optional __r_l)
   (if __r_l (setq _r_l __r_l)) _r_l)
  (:r_r
   (&optional __r_r)
   (if __r_r (setq _r_r __r_r)) _r_r)
  (:B
   (&optional __B)
   (if __B (setq _B __B)) _B)
  (:serialization-length
   ()
   (+
    ;; uint16 _K
    2
    ;; uint16 _KI
    2
    ;; uint16 _INT_MAX
    2
    ;; uint16 _ticks
    2
    ;; float32 _r
    4
    ;; float32 _r_l
    4
    ;; float32 _r_r
    4
    ;; float32 _B
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint16 _K
       (write-word _K s)
     ;; uint16 _KI
       (write-word _KI s)
     ;; uint16 _INT_MAX
       (write-word _INT_MAX s)
     ;; uint16 _ticks
       (write-word _ticks s)
     ;; float32 _r
       (sys::poke _r (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _r_l
       (sys::poke _r_l (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _r_r
       (sys::poke _r_r (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _B
       (sys::poke _B (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint16 _K
     (setq _K (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; uint16 _KI
     (setq _KI (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; uint16 _INT_MAX
     (setq _INT_MAX (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; uint16 _ticks
     (setq _ticks (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; float32 _r
     (setq _r (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _r_l
     (setq _r_l (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _r_r
     (setq _r_r (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _B
     (setq _B (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get ras_lab1_msgs::ControllerParams :md5sum-) "8950f824993d2867219a00186d4620f7")
(setf (get ras_lab1_msgs::ControllerParams :datatype-) "ras_lab1_msgs/ControllerParams")
(setf (get ras_lab1_msgs::ControllerParams :definition-)
      "# PI Control parameters
uint16 K
uint16 KI
uint16 INT_MAX
uint16 ticks

# Robot dimensions
float32 r
float32 r_l
float32 r_r
float32 B

")



(provide :ras_lab1_msgs/ControllerParams "8950f824993d2867219a00186d4620f7")


