
(cl:in-package :asdf)

(defsystem "uarm-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
)
  :components ((:file "_package")
    (:file "AttachDetach" :depends-on ("_package_AttachDetach"))
    (:file "_package_AttachDetach" :depends-on ("_package"))
    (:file "GetPositions" :depends-on ("_package_GetPositions"))
    (:file "_package_GetPositions" :depends-on ("_package"))
    (:file "MoveTo" :depends-on ("_package_MoveTo"))
    (:file "_package_MoveTo" :depends-on ("_package"))
    (:file "MoveToJoints" :depends-on ("_package_MoveToJoints"))
    (:file "_package_MoveToJoints" :depends-on ("_package"))
    (:file "Pump" :depends-on ("_package_Pump"))
    (:file "_package_Pump" :depends-on ("_package"))
  ))