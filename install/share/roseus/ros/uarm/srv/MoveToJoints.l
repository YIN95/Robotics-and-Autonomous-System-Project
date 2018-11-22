;; Auto-generated. Do not edit!


(when (boundp 'uarm::MoveToJoints)
  (if (not (find-package "UARM"))
    (make-package "UARM"))
  (shadow 'MoveToJoints (find-package "UARM")))
(unless (find-package "UARM::MOVETOJOINTS")
  (make-package "UARM::MOVETOJOINTS"))
(unless (find-package "UARM::MOVETOJOINTSREQUEST")
  (make-package "UARM::MOVETOJOINTSREQUEST"))
(unless (find-package "UARM::MOVETOJOINTSRESPONSE")
  (make-package "UARM::MOVETOJOINTSRESPONSE"))

(in-package "ROS")





(intern "*ABSOLUTE_MOVEMENT*" (find-package "UARM::MOVETOJOINTSREQUEST"))
(shadow '*ABSOLUTE_MOVEMENT* (find-package "UARM::MOVETOJOINTSREQUEST"))
(defconstant uarm::MoveToJointsRequest::*ABSOLUTE_MOVEMENT* 0)
(intern "*RELATIVE_MOVEMENT*" (find-package "UARM::MOVETOJOINTSREQUEST"))
(shadow '*RELATIVE_MOVEMENT* (find-package "UARM::MOVETOJOINTSREQUEST"))
(defconstant uarm::MoveToJointsRequest::*RELATIVE_MOVEMENT* 1)
(intern "*NO_INTERPOLATION*" (find-package "UARM::MOVETOJOINTSREQUEST"))
(shadow '*NO_INTERPOLATION* (find-package "UARM::MOVETOJOINTSREQUEST"))
(defconstant uarm::MoveToJointsRequest::*NO_INTERPOLATION* 0)
(intern "*CUBIC_INTERPOLATION*" (find-package "UARM::MOVETOJOINTSREQUEST"))
(shadow '*CUBIC_INTERPOLATION* (find-package "UARM::MOVETOJOINTSREQUEST"))
(defconstant uarm::MoveToJointsRequest::*CUBIC_INTERPOLATION* 1)
(intern "*LINEAR_INTERPOLATION*" (find-package "UARM::MOVETOJOINTSREQUEST"))
(shadow '*LINEAR_INTERPOLATION* (find-package "UARM::MOVETOJOINTSREQUEST"))
(defconstant uarm::MoveToJointsRequest::*LINEAR_INTERPOLATION* 2)
(defclass uarm::MoveToJointsRequest
  :super ros::object
  :slots (_j0 _j1 _j2 _j3 _move_mode _movement_duration _interpolation_type _check_limits ))

(defmethod uarm::MoveToJointsRequest
  (:init
   (&key
    ((:j0 __j0) 0.0)
    ((:j1 __j1) 0.0)
    ((:j2 __j2) 0.0)
    ((:j3 __j3) 0.0)
    ((:move_mode __move_mode) 0)
    ((:movement_duration __movement_duration) (instance ros::time :init))
    ((:interpolation_type __interpolation_type) 0)
    ((:check_limits __check_limits) nil)
    )
   (send-super :init)
   (setq _j0 (float __j0))
   (setq _j1 (float __j1))
   (setq _j2 (float __j2))
   (setq _j3 (float __j3))
   (setq _move_mode (round __move_mode))
   (setq _movement_duration __movement_duration)
   (setq _interpolation_type (round __interpolation_type))
   (setq _check_limits __check_limits)
   self)
  (:j0
   (&optional __j0)
   (if __j0 (setq _j0 __j0)) _j0)
  (:j1
   (&optional __j1)
   (if __j1 (setq _j1 __j1)) _j1)
  (:j2
   (&optional __j2)
   (if __j2 (setq _j2 __j2)) _j2)
  (:j3
   (&optional __j3)
   (if __j3 (setq _j3 __j3)) _j3)
  (:move_mode
   (&optional __move_mode)
   (if __move_mode (setq _move_mode __move_mode)) _move_mode)
  (:movement_duration
   (&optional __movement_duration)
   (if __movement_duration (setq _movement_duration __movement_duration)) _movement_duration)
  (:interpolation_type
   (&optional __interpolation_type)
   (if __interpolation_type (setq _interpolation_type __interpolation_type)) _interpolation_type)
  (:check_limits
   (&optional __check_limits)
   (if __check_limits (setq _check_limits __check_limits)) _check_limits)
  (:serialization-length
   ()
   (+
    ;; float32 _j0
    4
    ;; float32 _j1
    4
    ;; float32 _j2
    4
    ;; float32 _j3
    4
    ;; int32 _move_mode
    4
    ;; duration _movement_duration
    8
    ;; int32 _interpolation_type
    4
    ;; bool _check_limits
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _j0
       (sys::poke _j0 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _j1
       (sys::poke _j1 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _j2
       (sys::poke _j2 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _j3
       (sys::poke _j3 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int32 _move_mode
       (write-long _move_mode s)
     ;; duration _movement_duration
       (write-long (send _movement_duration :sec) s) (write-long (send _movement_duration :nsec) s)
     ;; int32 _interpolation_type
       (write-long _interpolation_type s)
     ;; bool _check_limits
       (if _check_limits (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _j0
     (setq _j0 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _j1
     (setq _j1 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _j2
     (setq _j2 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _j3
     (setq _j3 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int32 _move_mode
     (setq _move_mode (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; duration _movement_duration
     (send _movement_duration :sec (sys::peek buf ptr- :integer)) (incf ptr- 4)  (send _movement_duration :nsec (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _interpolation_type
     (setq _interpolation_type (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _check_limits
     (setq _check_limits (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass uarm::MoveToJointsResponse
  :super ros::object
  :slots (_j0 _j1 _j2 _j3 _elapsed _error ))

(defmethod uarm::MoveToJointsResponse
  (:init
   (&key
    ((:j0 __j0) 0.0)
    ((:j1 __j1) 0.0)
    ((:j2 __j2) 0.0)
    ((:j3 __j3) 0.0)
    ((:elapsed __elapsed) (instance ros::time :init))
    ((:error __error) nil)
    )
   (send-super :init)
   (setq _j0 (float __j0))
   (setq _j1 (float __j1))
   (setq _j2 (float __j2))
   (setq _j3 (float __j3))
   (setq _elapsed __elapsed)
   (setq _error __error)
   self)
  (:j0
   (&optional __j0)
   (if __j0 (setq _j0 __j0)) _j0)
  (:j1
   (&optional __j1)
   (if __j1 (setq _j1 __j1)) _j1)
  (:j2
   (&optional __j2)
   (if __j2 (setq _j2 __j2)) _j2)
  (:j3
   (&optional __j3)
   (if __j3 (setq _j3 __j3)) _j3)
  (:elapsed
   (&optional __elapsed)
   (if __elapsed (setq _elapsed __elapsed)) _elapsed)
  (:error
   (&optional __error)
   (if __error (setq _error __error)) _error)
  (:serialization-length
   ()
   (+
    ;; float32 _j0
    4
    ;; float32 _j1
    4
    ;; float32 _j2
    4
    ;; float32 _j3
    4
    ;; duration _elapsed
    8
    ;; bool _error
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _j0
       (sys::poke _j0 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _j1
       (sys::poke _j1 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _j2
       (sys::poke _j2 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _j3
       (sys::poke _j3 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; duration _elapsed
       (write-long (send _elapsed :sec) s) (write-long (send _elapsed :nsec) s)
     ;; bool _error
       (if _error (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _j0
     (setq _j0 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _j1
     (setq _j1 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _j2
     (setq _j2 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _j3
     (setq _j3 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; duration _elapsed
     (send _elapsed :sec (sys::peek buf ptr- :integer)) (incf ptr- 4)  (send _elapsed :nsec (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _error
     (setq _error (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass uarm::MoveToJoints
  :super ros::object
  :slots ())

(setf (get uarm::MoveToJoints :md5sum-) "112a3367014960c210096553f33b43c1")
(setf (get uarm::MoveToJoints :datatype-) "uarm/MoveToJoints")
(setf (get uarm::MoveToJoints :request) uarm::MoveToJointsRequest)
(setf (get uarm::MoveToJoints :response) uarm::MoveToJointsResponse)

(defmethod uarm::MoveToJointsRequest
  (:response () (instance uarm::MoveToJointsResponse :init)))

(setf (get uarm::MoveToJointsRequest :md5sum-) "112a3367014960c210096553f33b43c1")
(setf (get uarm::MoveToJointsRequest :datatype-) "uarm/MoveToJointsRequest")
(setf (get uarm::MoveToJointsRequest :definition-)
      "
float32 j0
float32 j1
float32 j2
float32 j3
int32 move_mode
duration movement_duration
int32 interpolation_type
bool check_limits


int32 ABSOLUTE_MOVEMENT = 0
int32 RELATIVE_MOVEMENT = 1






int32 NO_INTERPOLATION = 0
int32 CUBIC_INTERPOLATION = 1
int32 LINEAR_INTERPOLATION = 2

---

float32 j0
float32 j1
float32 j2
float32 j3
duration elapsed
bool error

")

(setf (get uarm::MoveToJointsResponse :md5sum-) "112a3367014960c210096553f33b43c1")
(setf (get uarm::MoveToJointsResponse :datatype-) "uarm/MoveToJointsResponse")
(setf (get uarm::MoveToJointsResponse :definition-)
      "
float32 j0
float32 j1
float32 j2
float32 j3
int32 move_mode
duration movement_duration
int32 interpolation_type
bool check_limits


int32 ABSOLUTE_MOVEMENT = 0
int32 RELATIVE_MOVEMENT = 1






int32 NO_INTERPOLATION = 0
int32 CUBIC_INTERPOLATION = 1
int32 LINEAR_INTERPOLATION = 2

---

float32 j0
float32 j1
float32 j2
float32 j3
duration elapsed
bool error

")



(provide :uarm/MoveToJoints "112a3367014960c210096553f33b43c1")


