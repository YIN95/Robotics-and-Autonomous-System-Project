
(cl:in-package :asdf)

(defsystem "ras_lab1_msgs-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :std_msgs-msg
)
  :components ((:file "_package")
    (:file "ADConverter" :depends-on ("_package_ADConverter"))
    (:file "_package_ADConverter" :depends-on ("_package"))
    (:file "BatteryStatus" :depends-on ("_package_BatteryStatus"))
    (:file "_package_BatteryStatus" :depends-on ("_package"))
    (:file "ControllerParams" :depends-on ("_package_ControllerParams"))
    (:file "_package_ControllerParams" :depends-on ("_package"))
    (:file "Encoders" :depends-on ("_package_Encoders"))
    (:file "_package_Encoders" :depends-on ("_package"))
    (:file "Odometry" :depends-on ("_package_Odometry"))
    (:file "_package_Odometry" :depends-on ("_package"))
    (:file "PWM" :depends-on ("_package_PWM"))
    (:file "_package_PWM" :depends-on ("_package"))
    (:file "ServoMotors" :depends-on ("_package_ServoMotors"))
    (:file "_package_ServoMotors" :depends-on ("_package"))
    (:file "WheelAngularVelocities" :depends-on ("_package_WheelAngularVelocities"))
    (:file "_package_WheelAngularVelocities" :depends-on ("_package"))
  ))