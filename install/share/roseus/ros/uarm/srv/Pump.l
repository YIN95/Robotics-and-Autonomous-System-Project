;; Auto-generated. Do not edit!


(when (boundp 'uarm::Pump)
  (if (not (find-package "UARM"))
    (make-package "UARM"))
  (shadow 'Pump (find-package "UARM")))
(unless (find-package "UARM::PUMP")
  (make-package "UARM::PUMP"))
(unless (find-package "UARM::PUMPREQUEST")
  (make-package "UARM::PUMPREQUEST"))
(unless (find-package "UARM::PUMPRESPONSE")
  (make-package "UARM::PUMPRESPONSE"))

(in-package "ROS")





(defclass uarm::PumpRequest
  :super ros::object
  :slots (_pump_status ))

(defmethod uarm::PumpRequest
  (:init
   (&key
    ((:pump_status __pump_status) nil)
    )
   (send-super :init)
   (setq _pump_status __pump_status)
   self)
  (:pump_status
   (&optional __pump_status)
   (if __pump_status (setq _pump_status __pump_status)) _pump_status)
  (:serialization-length
   ()
   (+
    ;; bool _pump_status
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _pump_status
       (if _pump_status (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _pump_status
     (setq _pump_status (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass uarm::PumpResponse
  :super ros::object
  :slots (_pump_status ))

(defmethod uarm::PumpResponse
  (:init
   (&key
    ((:pump_status __pump_status) nil)
    )
   (send-super :init)
   (setq _pump_status __pump_status)
   self)
  (:pump_status
   (&optional __pump_status)
   (if __pump_status (setq _pump_status __pump_status)) _pump_status)
  (:serialization-length
   ()
   (+
    ;; bool _pump_status
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _pump_status
       (if _pump_status (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _pump_status
     (setq _pump_status (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass uarm::Pump
  :super ros::object
  :slots ())

(setf (get uarm::Pump :md5sum-) "ff5a115a491fb65f575572e4a97ae33c")
(setf (get uarm::Pump :datatype-) "uarm/Pump")
(setf (get uarm::Pump :request) uarm::PumpRequest)
(setf (get uarm::Pump :response) uarm::PumpResponse)

(defmethod uarm::PumpRequest
  (:response () (instance uarm::PumpResponse :init)))

(setf (get uarm::PumpRequest :md5sum-) "ff5a115a491fb65f575572e4a97ae33c")
(setf (get uarm::PumpRequest :datatype-) "uarm/PumpRequest")
(setf (get uarm::PumpRequest :definition-)
      "
bool pump_status

---

bool pump_status

")

(setf (get uarm::PumpResponse :md5sum-) "ff5a115a491fb65f575572e4a97ae33c")
(setf (get uarm::PumpResponse :datatype-) "uarm/PumpResponse")
(setf (get uarm::PumpResponse :definition-)
      "
bool pump_status

---

bool pump_status

")



(provide :uarm/Pump "ff5a115a491fb65f575572e4a97ae33c")


