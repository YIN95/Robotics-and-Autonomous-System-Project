;; Auto-generated. Do not edit!


(when (boundp 'uarm::AttachDetach)
  (if (not (find-package "UARM"))
    (make-package "UARM"))
  (shadow 'AttachDetach (find-package "UARM")))
(unless (find-package "UARM::ATTACHDETACH")
  (make-package "UARM::ATTACHDETACH"))
(unless (find-package "UARM::ATTACHDETACHREQUEST")
  (make-package "UARM::ATTACHDETACHREQUEST"))
(unless (find-package "UARM::ATTACHDETACHRESPONSE")
  (make-package "UARM::ATTACHDETACHRESPONSE"))

(in-package "ROS")





(defclass uarm::AttachDetachRequest
  :super ros::object
  :slots (_attach ))

(defmethod uarm::AttachDetachRequest
  (:init
   (&key
    ((:attach __attach) nil)
    )
   (send-super :init)
   (setq _attach __attach)
   self)
  (:attach
   (&optional __attach)
   (if __attach (setq _attach __attach)) _attach)
  (:serialization-length
   ()
   (+
    ;; bool _attach
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _attach
       (if _attach (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _attach
     (setq _attach (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass uarm::AttachDetachResponse
  :super ros::object
  :slots (_attach ))

(defmethod uarm::AttachDetachResponse
  (:init
   (&key
    ((:attach __attach) nil)
    )
   (send-super :init)
   (setq _attach __attach)
   self)
  (:attach
   (&optional __attach)
   (if __attach (setq _attach __attach)) _attach)
  (:serialization-length
   ()
   (+
    ;; bool _attach
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _attach
       (if _attach (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _attach
     (setq _attach (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass uarm::AttachDetach
  :super ros::object
  :slots ())

(setf (get uarm::AttachDetach :md5sum-) "15a30b512eac3d5d3679caf838a84beb")
(setf (get uarm::AttachDetach :datatype-) "uarm/AttachDetach")
(setf (get uarm::AttachDetach :request) uarm::AttachDetachRequest)
(setf (get uarm::AttachDetach :response) uarm::AttachDetachResponse)

(defmethod uarm::AttachDetachRequest
  (:response () (instance uarm::AttachDetachResponse :init)))

(setf (get uarm::AttachDetachRequest :md5sum-) "15a30b512eac3d5d3679caf838a84beb")
(setf (get uarm::AttachDetachRequest :datatype-) "uarm/AttachDetachRequest")
(setf (get uarm::AttachDetachRequest :definition-)
      "
bool attach

---

bool attach

")

(setf (get uarm::AttachDetachResponse :md5sum-) "15a30b512eac3d5d3679caf838a84beb")
(setf (get uarm::AttachDetachResponse :datatype-) "uarm/AttachDetachResponse")
(setf (get uarm::AttachDetachResponse :definition-)
      "
bool attach

---

bool attach

")



(provide :uarm/AttachDetach "15a30b512eac3d5d3679caf838a84beb")


