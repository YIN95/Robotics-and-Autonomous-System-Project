;; Auto-generated. Do not edit!


(when (boundp 'uarm::MoveTo)
  (if (not (find-package "UARM"))
    (make-package "UARM"))
  (shadow 'MoveTo (find-package "UARM")))
(unless (find-package "UARM::MOVETO")
  (make-package "UARM::MOVETO"))
(unless (find-package "UARM::MOVETOREQUEST")
  (make-package "UARM::MOVETOREQUEST"))
(unless (find-package "UARM::MOVETORESPONSE")
  (make-package "UARM::MOVETORESPONSE"))

(in-package "ROS")

(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(intern "*ABSOLUTE_MOVEMENT*" (find-package "UARM::MOVETOREQUEST"))
(shadow '*ABSOLUTE_MOVEMENT* (find-package "UARM::MOVETOREQUEST"))
(defconstant uarm::MoveToRequest::*ABSOLUTE_MOVEMENT* 0)
(intern "*RELATIVE_MOVEMENT*" (find-package "UARM::MOVETOREQUEST"))
(shadow '*RELATIVE_MOVEMENT* (find-package "UARM::MOVETOREQUEST"))
(defconstant uarm::MoveToRequest::*RELATIVE_MOVEMENT* 1)
(intern "*NO_INTERPOLATION*" (find-package "UARM::MOVETOREQUEST"))
(shadow '*NO_INTERPOLATION* (find-package "UARM::MOVETOREQUEST"))
(defconstant uarm::MoveToRequest::*NO_INTERPOLATION* 0)
(intern "*CUBIC_INTERPOLATION*" (find-package "UARM::MOVETOREQUEST"))
(shadow '*CUBIC_INTERPOLATION* (find-package "UARM::MOVETOREQUEST"))
(defconstant uarm::MoveToRequest::*CUBIC_INTERPOLATION* 1)
(intern "*LINEAR_INTERPOLATION*" (find-package "UARM::MOVETOREQUEST"))
(shadow '*LINEAR_INTERPOLATION* (find-package "UARM::MOVETOREQUEST"))
(defconstant uarm::MoveToRequest::*LINEAR_INTERPOLATION* 2)
(defclass uarm::MoveToRequest
  :super ros::object
  :slots (_position _eef_orientation _move_mode _movement_duration _ignore_orientation _interpolation_type _check_limits ))

(defmethod uarm::MoveToRequest
  (:init
   (&key
    ((:position __position) (instance geometry_msgs::Point :init))
    ((:eef_orientation __eef_orientation) 0.0)
    ((:move_mode __move_mode) 0)
    ((:movement_duration __movement_duration) (instance ros::time :init))
    ((:ignore_orientation __ignore_orientation) nil)
    ((:interpolation_type __interpolation_type) 0)
    ((:check_limits __check_limits) nil)
    )
   (send-super :init)
   (setq _position __position)
   (setq _eef_orientation (float __eef_orientation))
   (setq _move_mode (round __move_mode))
   (setq _movement_duration __movement_duration)
   (setq _ignore_orientation __ignore_orientation)
   (setq _interpolation_type (round __interpolation_type))
   (setq _check_limits __check_limits)
   self)
  (:position
   (&rest __position)
   (if (keywordp (car __position))
       (send* _position __position)
     (progn
       (if __position (setq _position (car __position)))
       _position)))
  (:eef_orientation
   (&optional __eef_orientation)
   (if __eef_orientation (setq _eef_orientation __eef_orientation)) _eef_orientation)
  (:move_mode
   (&optional __move_mode)
   (if __move_mode (setq _move_mode __move_mode)) _move_mode)
  (:movement_duration
   (&optional __movement_duration)
   (if __movement_duration (setq _movement_duration __movement_duration)) _movement_duration)
  (:ignore_orientation
   (&optional __ignore_orientation)
   (if __ignore_orientation (setq _ignore_orientation __ignore_orientation)) _ignore_orientation)
  (:interpolation_type
   (&optional __interpolation_type)
   (if __interpolation_type (setq _interpolation_type __interpolation_type)) _interpolation_type)
  (:check_limits
   (&optional __check_limits)
   (if __check_limits (setq _check_limits __check_limits)) _check_limits)
  (:serialization-length
   ()
   (+
    ;; geometry_msgs/Point _position
    (send _position :serialization-length)
    ;; float32 _eef_orientation
    4
    ;; int32 _move_mode
    4
    ;; duration _movement_duration
    8
    ;; bool _ignore_orientation
    1
    ;; int32 _interpolation_type
    4
    ;; bool _check_limits
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; geometry_msgs/Point _position
       (send _position :serialize s)
     ;; float32 _eef_orientation
       (sys::poke _eef_orientation (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int32 _move_mode
       (write-long _move_mode s)
     ;; duration _movement_duration
       (write-long (send _movement_duration :sec) s) (write-long (send _movement_duration :nsec) s)
     ;; bool _ignore_orientation
       (if _ignore_orientation (write-byte -1 s) (write-byte 0 s))
     ;; int32 _interpolation_type
       (write-long _interpolation_type s)
     ;; bool _check_limits
       (if _check_limits (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; geometry_msgs/Point _position
     (send _position :deserialize buf ptr-) (incf ptr- (send _position :serialization-length))
   ;; float32 _eef_orientation
     (setq _eef_orientation (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int32 _move_mode
     (setq _move_mode (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; duration _movement_duration
     (send _movement_duration :sec (sys::peek buf ptr- :integer)) (incf ptr- 4)  (send _movement_duration :nsec (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _ignore_orientation
     (setq _ignore_orientation (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; int32 _interpolation_type
     (setq _interpolation_type (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _check_limits
     (setq _check_limits (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass uarm::MoveToResponse
  :super ros::object
  :slots (_position _elapsed _error ))

(defmethod uarm::MoveToResponse
  (:init
   (&key
    ((:position __position) (instance geometry_msgs::Point :init))
    ((:elapsed __elapsed) (instance ros::time :init))
    ((:error __error) nil)
    )
   (send-super :init)
   (setq _position __position)
   (setq _elapsed __elapsed)
   (setq _error __error)
   self)
  (:position
   (&rest __position)
   (if (keywordp (car __position))
       (send* _position __position)
     (progn
       (if __position (setq _position (car __position)))
       _position)))
  (:elapsed
   (&optional __elapsed)
   (if __elapsed (setq _elapsed __elapsed)) _elapsed)
  (:error
   (&optional __error)
   (if __error (setq _error __error)) _error)
  (:serialization-length
   ()
   (+
    ;; geometry_msgs/Point _position
    (send _position :serialization-length)
    ;; duration _elapsed
    8
    ;; bool _error
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; geometry_msgs/Point _position
       (send _position :serialize s)
     ;; duration _elapsed
       (write-long (send _elapsed :sec) s) (write-long (send _elapsed :nsec) s)
     ;; bool _error
       (if _error (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; geometry_msgs/Point _position
     (send _position :deserialize buf ptr-) (incf ptr- (send _position :serialization-length))
   ;; duration _elapsed
     (send _elapsed :sec (sys::peek buf ptr- :integer)) (incf ptr- 4)  (send _elapsed :nsec (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _error
     (setq _error (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass uarm::MoveTo
  :super ros::object
  :slots ())

(setf (get uarm::MoveTo :md5sum-) "b5950699ca93b2e0816f732b4daecc97")
(setf (get uarm::MoveTo :datatype-) "uarm/MoveTo")
(setf (get uarm::MoveTo :request) uarm::MoveToRequest)
(setf (get uarm::MoveTo :response) uarm::MoveToResponse)

(defmethod uarm::MoveToRequest
  (:response () (instance uarm::MoveToResponse :init)))

(setf (get uarm::MoveToRequest :md5sum-) "b5950699ca93b2e0816f732b4daecc97")
(setf (get uarm::MoveToRequest :datatype-) "uarm/MoveToRequest")
(setf (get uarm::MoveToRequest :definition-)
      "
geometry_msgs/Point position
float32 eef_orientation
int32 move_mode
duration movement_duration
bool ignore_orientation
int32 interpolation_type
bool check_limits


int32 ABSOLUTE_MOVEMENT = 0
int32 RELATIVE_MOVEMENT = 1






int32 NO_INTERPOLATION = 0
int32 CUBIC_INTERPOLATION = 1
int32 LINEAR_INTERPOLATION = 2


================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z
---

geometry_msgs/Point position
duration elapsed
bool error


================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z
")

(setf (get uarm::MoveToResponse :md5sum-) "b5950699ca93b2e0816f732b4daecc97")
(setf (get uarm::MoveToResponse :datatype-) "uarm/MoveToResponse")
(setf (get uarm::MoveToResponse :definition-)
      "
geometry_msgs/Point position
float32 eef_orientation
int32 move_mode
duration movement_duration
bool ignore_orientation
int32 interpolation_type
bool check_limits


int32 ABSOLUTE_MOVEMENT = 0
int32 RELATIVE_MOVEMENT = 1






int32 NO_INTERPOLATION = 0
int32 CUBIC_INTERPOLATION = 1
int32 LINEAR_INTERPOLATION = 2


================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z
---

geometry_msgs/Point position
duration elapsed
bool error


================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z
")



(provide :uarm/MoveTo "b5950699ca93b2e0816f732b4daecc97")


