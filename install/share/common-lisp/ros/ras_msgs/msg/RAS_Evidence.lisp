; Auto-generated. Do not edit!


(cl:in-package ras_msgs-msg)


;//! \htmlinclude RAS_Evidence.msg.html

(cl:defclass <RAS_Evidence> (roslisp-msg-protocol:ros-message)
  ((stamp
    :reader stamp
    :initarg :stamp
    :type cl:real
    :initform 0)
   (group_number
    :reader group_number
    :initarg :group_number
    :type cl:fixnum
    :initform 0)
   (image_evidence
    :reader image_evidence
    :initarg :image_evidence
    :type sensor_msgs-msg:Image
    :initform (cl:make-instance 'sensor_msgs-msg:Image))
   (object_id
    :reader object_id
    :initarg :object_id
    :type cl:string
    :initform "")
   (object_location
    :reader object_location
    :initarg :object_location
    :type geometry_msgs-msg:TransformStamped
    :initform (cl:make-instance 'geometry_msgs-msg:TransformStamped)))
)

(cl:defclass RAS_Evidence (<RAS_Evidence>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <RAS_Evidence>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'RAS_Evidence)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ras_msgs-msg:<RAS_Evidence> is deprecated: use ras_msgs-msg:RAS_Evidence instead.")))

(cl:ensure-generic-function 'stamp-val :lambda-list '(m))
(cl:defmethod stamp-val ((m <RAS_Evidence>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ras_msgs-msg:stamp-val is deprecated.  Use ras_msgs-msg:stamp instead.")
  (stamp m))

(cl:ensure-generic-function 'group_number-val :lambda-list '(m))
(cl:defmethod group_number-val ((m <RAS_Evidence>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ras_msgs-msg:group_number-val is deprecated.  Use ras_msgs-msg:group_number instead.")
  (group_number m))

(cl:ensure-generic-function 'image_evidence-val :lambda-list '(m))
(cl:defmethod image_evidence-val ((m <RAS_Evidence>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ras_msgs-msg:image_evidence-val is deprecated.  Use ras_msgs-msg:image_evidence instead.")
  (image_evidence m))

(cl:ensure-generic-function 'object_id-val :lambda-list '(m))
(cl:defmethod object_id-val ((m <RAS_Evidence>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ras_msgs-msg:object_id-val is deprecated.  Use ras_msgs-msg:object_id instead.")
  (object_id m))

(cl:ensure-generic-function 'object_location-val :lambda-list '(m))
(cl:defmethod object_location-val ((m <RAS_Evidence>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ras_msgs-msg:object_location-val is deprecated.  Use ras_msgs-msg:object_location instead.")
  (object_location m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<RAS_Evidence>)))
    "Constants for message type '<RAS_Evidence>"
  '((:AN_OBJECT . An Object)
    (:RED_CUBE . Red Cube)
    (:RED_HOLLOW_CUBE . Red Hollow Cube)
    (:BLUE_CUBE . Blue Cube)
    (:GREEN_CUBE . Green Cube)
    (:YELLOW_CUBE . Yellow Cube)
    (:YELLOW_BALL . Yellow Ball)
    (:RED_BALL . Red Ball)
    (:RED_CYLINDER . Red Cylinder)
    (:GREEN_CYLINDER . Green Cylinder)
    (:GREEN_HOLLOW_CUBE . Green Hollow Cube)
    (:BLUE_TRIANGLE . Blue Triangle)
    (:PURPLE_CROSS . Purple Cross)
    (:PURPLE_STAR . Purple Star)
    (:ORANGE_CROSS . Orange Cross)
    (:PATRIC . Patric))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'RAS_Evidence)))
    "Constants for message type 'RAS_Evidence"
  '((:AN_OBJECT . An Object)
    (:RED_CUBE . Red Cube)
    (:RED_HOLLOW_CUBE . Red Hollow Cube)
    (:BLUE_CUBE . Blue Cube)
    (:GREEN_CUBE . Green Cube)
    (:YELLOW_CUBE . Yellow Cube)
    (:YELLOW_BALL . Yellow Ball)
    (:RED_BALL . Red Ball)
    (:RED_CYLINDER . Red Cylinder)
    (:GREEN_CYLINDER . Green Cylinder)
    (:GREEN_HOLLOW_CUBE . Green Hollow Cube)
    (:BLUE_TRIANGLE . Blue Triangle)
    (:PURPLE_CROSS . Purple Cross)
    (:PURPLE_STAR . Purple Star)
    (:ORANGE_CROSS . Orange Cross)
    (:PATRIC . Patric))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <RAS_Evidence>) ostream)
  "Serializes a message object of type '<RAS_Evidence>"
  (cl:let ((__sec (cl:floor (cl:slot-value msg 'stamp)))
        (__nsec (cl:round (cl:* 1e9 (cl:- (cl:slot-value msg 'stamp) (cl:floor (cl:slot-value msg 'stamp)))))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 0) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __nsec) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'group_number)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'image_evidence) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'object_id))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'object_id))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'object_location) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <RAS_Evidence>) istream)
  "Deserializes a message object of type '<RAS_Evidence>"
    (cl:let ((__sec 0) (__nsec 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 0) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __nsec) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'stamp) (cl:+ (cl:coerce __sec 'cl:double-float) (cl:/ __nsec 1e9))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'group_number)) (cl:read-byte istream))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'image_evidence) istream)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'object_id) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'object_id) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'object_location) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<RAS_Evidence>)))
  "Returns string type for a message object of type '<RAS_Evidence>"
  "ras_msgs/RAS_Evidence")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'RAS_Evidence)))
  "Returns string type for a message object of type 'RAS_Evidence"
  "ras_msgs/RAS_Evidence")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<RAS_Evidence>)))
  "Returns md5sum for a message object of type '<RAS_Evidence>"
  "71fcfca56843bccb15bf61ddab2df9eb")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'RAS_Evidence)))
  "Returns md5sum for a message object of type 'RAS_Evidence"
  "71fcfca56843bccb15bf61ddab2df9eb")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<RAS_Evidence>)))
  "Returns full string definition for message of type '<RAS_Evidence>"
  (cl:format cl:nil "#### Timestamp of the msg ####~%time stamp~%~%#### Group number####~%uint8 group_number~%~%#### RGB Image frame which shows detected/identified object ####~%sensor_msgs/Image image_evidence~%~%#### String that indicates which object has been detected/recognized ####~%string object_id~%~%# object_id should be one of the following (use these constants)~%# an_object: object was detected but not identified~%# red_hollow_cube: red cube with hole on top~%string an_object=An Object~%string red_cube=Red Cube~%string red_hollow_cube=Red Hollow Cube~%string blue_cube=Blue Cube~%string green_cube=Green Cube~%string yellow_cube=Yellow Cube~%string yellow_ball=Yellow Ball~%string red_ball=Red Ball~%string red_cylinder=Red Cylinder~%string green_cylinder=Green Cylinder~%string green_hollow_cube=Green Hollow Cube~%string blue_triangle=Blue Triangle~%string purple_cross=Purple Cross~%string purple_star=Purple Star~%string orange_cross=Orange Cross~%string patric=Patric~%~%#### Location of the object in the /map frame ####~%# MAKE SURE THE LOCATION IS EXPRESSED IN THE /map FRAME!~%# we only care about X,Y position coordinate~%geometry_msgs/TransformStamped object_location~%~%# More info: https://anywiki.csc.kth.se/DD2425/doku.php?id=ras2017:object_evidence~%~%================================================================================~%MSG: sensor_msgs/Image~%# This message contains an uncompressed image~%# (0, 0) is at top-left corner of image~%#~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of cameara~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%                     # If the frame_id here and the frame_id of the CameraInfo~%                     # message associated with the image conflict~%                     # the behavior is undefined~%~%uint32 height         # image height, that is, number of rows~%uint32 width          # image width, that is, number of columns~%~%# The legal values for encoding are in file src/image_encodings.cpp~%# If you want to standardize a new string format, join~%# ros-users@lists.sourceforge.net and send an email proposing a new encoding.~%~%string encoding       # Encoding of pixels -- channel meaning, ordering, size~%                      # taken from the list of strings in include/sensor_msgs/image_encodings.h~%~%uint8 is_bigendian    # is this data bigendian?~%uint32 step           # Full row length in bytes~%uint8[] data          # actual matrix data, size is (step * rows)~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/TransformStamped~%# This expresses a transform from coordinate frame header.frame_id~%# to the coordinate frame child_frame_id~%#~%# This message is mostly used by the ~%# <a href=\"http://wiki.ros.org/tf\">tf</a> package. ~%# See its documentation for more information.~%~%Header header~%string child_frame_id # the frame id of the child frame~%Transform transform~%~%================================================================================~%MSG: geometry_msgs/Transform~%# This represents the transform between two coordinate frames in free space.~%~%Vector3 translation~%Quaternion rotation~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'RAS_Evidence)))
  "Returns full string definition for message of type 'RAS_Evidence"
  (cl:format cl:nil "#### Timestamp of the msg ####~%time stamp~%~%#### Group number####~%uint8 group_number~%~%#### RGB Image frame which shows detected/identified object ####~%sensor_msgs/Image image_evidence~%~%#### String that indicates which object has been detected/recognized ####~%string object_id~%~%# object_id should be one of the following (use these constants)~%# an_object: object was detected but not identified~%# red_hollow_cube: red cube with hole on top~%string an_object=An Object~%string red_cube=Red Cube~%string red_hollow_cube=Red Hollow Cube~%string blue_cube=Blue Cube~%string green_cube=Green Cube~%string yellow_cube=Yellow Cube~%string yellow_ball=Yellow Ball~%string red_ball=Red Ball~%string red_cylinder=Red Cylinder~%string green_cylinder=Green Cylinder~%string green_hollow_cube=Green Hollow Cube~%string blue_triangle=Blue Triangle~%string purple_cross=Purple Cross~%string purple_star=Purple Star~%string orange_cross=Orange Cross~%string patric=Patric~%~%#### Location of the object in the /map frame ####~%# MAKE SURE THE LOCATION IS EXPRESSED IN THE /map FRAME!~%# we only care about X,Y position coordinate~%geometry_msgs/TransformStamped object_location~%~%# More info: https://anywiki.csc.kth.se/DD2425/doku.php?id=ras2017:object_evidence~%~%================================================================================~%MSG: sensor_msgs/Image~%# This message contains an uncompressed image~%# (0, 0) is at top-left corner of image~%#~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of cameara~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%                     # If the frame_id here and the frame_id of the CameraInfo~%                     # message associated with the image conflict~%                     # the behavior is undefined~%~%uint32 height         # image height, that is, number of rows~%uint32 width          # image width, that is, number of columns~%~%# The legal values for encoding are in file src/image_encodings.cpp~%# If you want to standardize a new string format, join~%# ros-users@lists.sourceforge.net and send an email proposing a new encoding.~%~%string encoding       # Encoding of pixels -- channel meaning, ordering, size~%                      # taken from the list of strings in include/sensor_msgs/image_encodings.h~%~%uint8 is_bigendian    # is this data bigendian?~%uint32 step           # Full row length in bytes~%uint8[] data          # actual matrix data, size is (step * rows)~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/TransformStamped~%# This expresses a transform from coordinate frame header.frame_id~%# to the coordinate frame child_frame_id~%#~%# This message is mostly used by the ~%# <a href=\"http://wiki.ros.org/tf\">tf</a> package. ~%# See its documentation for more information.~%~%Header header~%string child_frame_id # the frame id of the child frame~%Transform transform~%~%================================================================================~%MSG: geometry_msgs/Transform~%# This represents the transform between two coordinate frames in free space.~%~%Vector3 translation~%Quaternion rotation~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <RAS_Evidence>))
  (cl:+ 0
     8
     1
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'image_evidence))
     4 (cl:length (cl:slot-value msg 'object_id))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'object_location))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <RAS_Evidence>))
  "Converts a ROS message object to a list"
  (cl:list 'RAS_Evidence
    (cl:cons ':stamp (stamp msg))
    (cl:cons ':group_number (group_number msg))
    (cl:cons ':image_evidence (image_evidence msg))
    (cl:cons ':object_id (object_id msg))
    (cl:cons ':object_location (object_location msg))
))
