;; Auto-generated. Do not edit!


(when (boundp 'arduino_servo_control::SetServoAngles)
  (if (not (find-package "ARDUINO_SERVO_CONTROL"))
    (make-package "ARDUINO_SERVO_CONTROL"))
  (shadow 'SetServoAngles (find-package "ARDUINO_SERVO_CONTROL")))
(unless (find-package "ARDUINO_SERVO_CONTROL::SETSERVOANGLES")
  (make-package "ARDUINO_SERVO_CONTROL::SETSERVOANGLES"))
(unless (find-package "ARDUINO_SERVO_CONTROL::SETSERVOANGLESREQUEST")
  (make-package "ARDUINO_SERVO_CONTROL::SETSERVOANGLESREQUEST"))
(unless (find-package "ARDUINO_SERVO_CONTROL::SETSERVOANGLESRESPONSE")
  (make-package "ARDUINO_SERVO_CONTROL::SETSERVOANGLESRESPONSE"))

(in-package "ROS")





(defclass arduino_servo_control::SetServoAnglesRequest
  :super ros::object
  :slots (_angle_servo_0 _angle_servo_1 ))

(defmethod arduino_servo_control::SetServoAnglesRequest
  (:init
   (&key
    ((:angle_servo_0 __angle_servo_0) 0)
    ((:angle_servo_1 __angle_servo_1) 0)
    )
   (send-super :init)
   (setq _angle_servo_0 (round __angle_servo_0))
   (setq _angle_servo_1 (round __angle_servo_1))
   self)
  (:angle_servo_0
   (&optional __angle_servo_0)
   (if __angle_servo_0 (setq _angle_servo_0 __angle_servo_0)) _angle_servo_0)
  (:angle_servo_1
   (&optional __angle_servo_1)
   (if __angle_servo_1 (setq _angle_servo_1 __angle_servo_1)) _angle_servo_1)
  (:serialization-length
   ()
   (+
    ;; int64 _angle_servo_0
    8
    ;; int64 _angle_servo_1
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int64 _angle_servo_0
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _angle_servo_0 (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _angle_servo_0) (= (length (_angle_servo_0 . bv)) 2)) ;; bignum
              (write-long (ash (elt (_angle_servo_0 . bv) 0) 0) s)
              (write-long (ash (elt (_angle_servo_0 . bv) 1) -1) s))
             ((and (class _angle_servo_0) (= (length (_angle_servo_0 . bv)) 1)) ;; big1
              (write-long (elt (_angle_servo_0 . bv) 0) s)
              (write-long (if (>= _angle_servo_0 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _angle_servo_0 s)(write-long (if (>= _angle_servo_0 0) 0 #xffffffff) s)))
     ;; int64 _angle_servo_1
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _angle_servo_1 (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _angle_servo_1) (= (length (_angle_servo_1 . bv)) 2)) ;; bignum
              (write-long (ash (elt (_angle_servo_1 . bv) 0) 0) s)
              (write-long (ash (elt (_angle_servo_1 . bv) 1) -1) s))
             ((and (class _angle_servo_1) (= (length (_angle_servo_1 . bv)) 1)) ;; big1
              (write-long (elt (_angle_servo_1 . bv) 0) s)
              (write-long (if (>= _angle_servo_1 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _angle_servo_1 s)(write-long (if (>= _angle_servo_1 0) 0 #xffffffff) s)))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int64 _angle_servo_0
#+(or :alpha :irix6 :x86_64)
      (setf _angle_servo_0 (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _angle_servo_0 (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _angle_servo_1
#+(or :alpha :irix6 :x86_64)
      (setf _angle_servo_1 (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _angle_servo_1 (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;;
   self)
  )

(defclass arduino_servo_control::SetServoAnglesResponse
  :super ros::object
  :slots (_success ))

(defmethod arduino_servo_control::SetServoAnglesResponse
  (:init
   (&key
    ((:success __success) nil)
    )
   (send-super :init)
   (setq _success __success)
   self)
  (:success
   (&optional __success)
   (if __success (setq _success __success)) _success)
  (:serialization-length
   ()
   (+
    ;; bool _success
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _success
       (if _success (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _success
     (setq _success (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass arduino_servo_control::SetServoAngles
  :super ros::object
  :slots ())

(setf (get arduino_servo_control::SetServoAngles :md5sum-) "9f74ea09edde7d0924376ba2d9b77543")
(setf (get arduino_servo_control::SetServoAngles :datatype-) "arduino_servo_control/SetServoAngles")
(setf (get arduino_servo_control::SetServoAngles :request) arduino_servo_control::SetServoAnglesRequest)
(setf (get arduino_servo_control::SetServoAngles :response) arduino_servo_control::SetServoAnglesResponse)

(defmethod arduino_servo_control::SetServoAnglesRequest
  (:response () (instance arduino_servo_control::SetServoAnglesResponse :init)))

(setf (get arduino_servo_control::SetServoAnglesRequest :md5sum-) "9f74ea09edde7d0924376ba2d9b77543")
(setf (get arduino_servo_control::SetServoAnglesRequest :datatype-) "arduino_servo_control/SetServoAnglesRequest")
(setf (get arduino_servo_control::SetServoAnglesRequest :definition-)
      "
int64 angle_servo_0
int64 angle_servo_1
---
bool success

")

(setf (get arduino_servo_control::SetServoAnglesResponse :md5sum-) "9f74ea09edde7d0924376ba2d9b77543")
(setf (get arduino_servo_control::SetServoAnglesResponse :datatype-) "arduino_servo_control/SetServoAnglesResponse")
(setf (get arduino_servo_control::SetServoAnglesResponse :definition-)
      "
int64 angle_servo_0
int64 angle_servo_1
---
bool success

")



(provide :arduino_servo_control/SetServoAngles "9f74ea09edde7d0924376ba2d9b77543")


