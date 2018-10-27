
(cl:in-package :asdf)

(defsystem "phidgets-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :std_msgs-msg
)
  :components ((:file "_package")
    (:file "interface_kit_params" :depends-on ("_package_interface_kit_params"))
    (:file "_package_interface_kit_params" :depends-on ("_package"))
    (:file "motor_encoder" :depends-on ("_package_motor_encoder"))
    (:file "_package_motor_encoder" :depends-on ("_package"))
    (:file "motor_params" :depends-on ("_package_motor_params"))
    (:file "_package_motor_params" :depends-on ("_package"))
  ))