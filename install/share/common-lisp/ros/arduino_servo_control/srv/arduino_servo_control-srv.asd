
(cl:in-package :asdf)

(defsystem "arduino_servo_control-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "SetServoAngles" :depends-on ("_package_SetServoAngles"))
    (:file "_package_SetServoAngles" :depends-on ("_package"))
  ))