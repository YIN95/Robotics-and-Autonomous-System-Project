
(cl:in-package :asdf)

(defsystem "gp9_path_planning-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
               :std_msgs-msg
)
  :components ((:file "_package")
    (:file "PathList" :depends-on ("_package_PathList"))
    (:file "_package_PathList" :depends-on ("_package"))
  ))