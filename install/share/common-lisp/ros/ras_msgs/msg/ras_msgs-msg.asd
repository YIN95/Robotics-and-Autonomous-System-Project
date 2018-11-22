
(cl:in-package :asdf)

(defsystem "ras_msgs-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
               :sensor_msgs-msg
)
  :components ((:file "_package")
    (:file "RAS_Evidence" :depends-on ("_package_RAS_Evidence"))
    (:file "_package_RAS_Evidence" :depends-on ("_package"))
  ))