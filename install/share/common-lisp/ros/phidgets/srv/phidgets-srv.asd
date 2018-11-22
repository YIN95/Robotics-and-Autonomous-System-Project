
(cl:in-package :asdf)

(defsystem "phidgets-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "interface_kit" :depends-on ("_package_interface_kit"))
    (:file "_package_interface_kit" :depends-on ("_package"))
    (:file "lidar_control" :depends-on ("_package_lidar_control"))
    (:file "_package_lidar_control" :depends-on ("_package"))
  ))