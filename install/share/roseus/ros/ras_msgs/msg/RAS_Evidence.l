;; Auto-generated. Do not edit!


(when (boundp 'ras_msgs::RAS_Evidence)
  (if (not (find-package "RAS_MSGS"))
    (make-package "RAS_MSGS"))
  (shadow 'RAS_Evidence (find-package "RAS_MSGS")))
(unless (find-package "RAS_MSGS::RAS_EVIDENCE")
  (make-package "RAS_MSGS::RAS_EVIDENCE"))

(in-package "ROS")
;;//! \htmlinclude RAS_Evidence.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "SENSOR_MSGS"))
  (ros::roseus-add-msgs "sensor_msgs"))


(intern "*AN_OBJECT*" (find-package "RAS_MSGS::RAS_EVIDENCE"))
(shadow '*AN_OBJECT* (find-package "RAS_MSGS::RAS_EVIDENCE"))
(defconstant ras_msgs::RAS_Evidence::*AN_OBJECT* "An Object")
(intern "*RED_CUBE*" (find-package "RAS_MSGS::RAS_EVIDENCE"))
(shadow '*RED_CUBE* (find-package "RAS_MSGS::RAS_EVIDENCE"))
(defconstant ras_msgs::RAS_Evidence::*RED_CUBE* "Red Cube")
(intern "*RED_HOLLOW_CUBE*" (find-package "RAS_MSGS::RAS_EVIDENCE"))
(shadow '*RED_HOLLOW_CUBE* (find-package "RAS_MSGS::RAS_EVIDENCE"))
(defconstant ras_msgs::RAS_Evidence::*RED_HOLLOW_CUBE* "Red Hollow Cube")
(intern "*BLUE_CUBE*" (find-package "RAS_MSGS::RAS_EVIDENCE"))
(shadow '*BLUE_CUBE* (find-package "RAS_MSGS::RAS_EVIDENCE"))
(defconstant ras_msgs::RAS_Evidence::*BLUE_CUBE* "Blue Cube")
(intern "*GREEN_CUBE*" (find-package "RAS_MSGS::RAS_EVIDENCE"))
(shadow '*GREEN_CUBE* (find-package "RAS_MSGS::RAS_EVIDENCE"))
(defconstant ras_msgs::RAS_Evidence::*GREEN_CUBE* "Green Cube")
(intern "*YELLOW_CUBE*" (find-package "RAS_MSGS::RAS_EVIDENCE"))
(shadow '*YELLOW_CUBE* (find-package "RAS_MSGS::RAS_EVIDENCE"))
(defconstant ras_msgs::RAS_Evidence::*YELLOW_CUBE* "Yellow Cube")
(intern "*YELLOW_BALL*" (find-package "RAS_MSGS::RAS_EVIDENCE"))
(shadow '*YELLOW_BALL* (find-package "RAS_MSGS::RAS_EVIDENCE"))
(defconstant ras_msgs::RAS_Evidence::*YELLOW_BALL* "Yellow Ball")
(intern "*RED_BALL*" (find-package "RAS_MSGS::RAS_EVIDENCE"))
(shadow '*RED_BALL* (find-package "RAS_MSGS::RAS_EVIDENCE"))
(defconstant ras_msgs::RAS_Evidence::*RED_BALL* "Red Ball")
(intern "*RED_CYLINDER*" (find-package "RAS_MSGS::RAS_EVIDENCE"))
(shadow '*RED_CYLINDER* (find-package "RAS_MSGS::RAS_EVIDENCE"))
(defconstant ras_msgs::RAS_Evidence::*RED_CYLINDER* "Red Cylinder")
(intern "*GREEN_CYLINDER*" (find-package "RAS_MSGS::RAS_EVIDENCE"))
(shadow '*GREEN_CYLINDER* (find-package "RAS_MSGS::RAS_EVIDENCE"))
(defconstant ras_msgs::RAS_Evidence::*GREEN_CYLINDER* "Green Cylinder")
(intern "*GREEN_HOLLOW_CUBE*" (find-package "RAS_MSGS::RAS_EVIDENCE"))
(shadow '*GREEN_HOLLOW_CUBE* (find-package "RAS_MSGS::RAS_EVIDENCE"))
(defconstant ras_msgs::RAS_Evidence::*GREEN_HOLLOW_CUBE* "Green Hollow Cube")
(intern "*BLUE_TRIANGLE*" (find-package "RAS_MSGS::RAS_EVIDENCE"))
(shadow '*BLUE_TRIANGLE* (find-package "RAS_MSGS::RAS_EVIDENCE"))
(defconstant ras_msgs::RAS_Evidence::*BLUE_TRIANGLE* "Blue Triangle")
(intern "*PURPLE_CROSS*" (find-package "RAS_MSGS::RAS_EVIDENCE"))
(shadow '*PURPLE_CROSS* (find-package "RAS_MSGS::RAS_EVIDENCE"))
(defconstant ras_msgs::RAS_Evidence::*PURPLE_CROSS* "Purple Cross")
(intern "*PURPLE_STAR*" (find-package "RAS_MSGS::RAS_EVIDENCE"))
(shadow '*PURPLE_STAR* (find-package "RAS_MSGS::RAS_EVIDENCE"))
(defconstant ras_msgs::RAS_Evidence::*PURPLE_STAR* "Purple Star")
(intern "*ORANGE_CROSS*" (find-package "RAS_MSGS::RAS_EVIDENCE"))
(shadow '*ORANGE_CROSS* (find-package "RAS_MSGS::RAS_EVIDENCE"))
(defconstant ras_msgs::RAS_Evidence::*ORANGE_CROSS* "Orange Cross")
(intern "*PATRIC*" (find-package "RAS_MSGS::RAS_EVIDENCE"))
(shadow '*PATRIC* (find-package "RAS_MSGS::RAS_EVIDENCE"))
(defconstant ras_msgs::RAS_Evidence::*PATRIC* "Patric")
(defclass ras_msgs::RAS_Evidence
  :super ros::object
  :slots (_stamp _group_number _image_evidence _object_id _object_location ))

(defmethod ras_msgs::RAS_Evidence
  (:init
   (&key
    ((:stamp __stamp) (instance ros::time :init))
    ((:group_number __group_number) 0)
    ((:image_evidence __image_evidence) (instance sensor_msgs::Image :init))
    ((:object_id __object_id) "")
    ((:object_location __object_location) (instance geometry_msgs::TransformStamped :init))
    )
   (send-super :init)
   (setq _stamp __stamp)
   (setq _group_number (round __group_number))
   (setq _image_evidence __image_evidence)
   (setq _object_id (string __object_id))
   (setq _object_location __object_location)
   self)
  (:stamp
   (&optional __stamp)
   (if __stamp (setq _stamp __stamp)) _stamp)
  (:group_number
   (&optional __group_number)
   (if __group_number (setq _group_number __group_number)) _group_number)
  (:image_evidence
   (&rest __image_evidence)
   (if (keywordp (car __image_evidence))
       (send* _image_evidence __image_evidence)
     (progn
       (if __image_evidence (setq _image_evidence (car __image_evidence)))
       _image_evidence)))
  (:object_id
   (&optional __object_id)
   (if __object_id (setq _object_id __object_id)) _object_id)
  (:object_location
   (&rest __object_location)
   (if (keywordp (car __object_location))
       (send* _object_location __object_location)
     (progn
       (if __object_location (setq _object_location (car __object_location)))
       _object_location)))
  (:serialization-length
   ()
   (+
    ;; time _stamp
    8
    ;; uint8 _group_number
    1
    ;; sensor_msgs/Image _image_evidence
    (send _image_evidence :serialization-length)
    ;; string _object_id
    4 (length _object_id)
    ;; geometry_msgs/TransformStamped _object_location
    (send _object_location :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; time _stamp
       (write-long (send _stamp :sec) s) (write-long (send _stamp :nsec) s)
     ;; uint8 _group_number
       (write-byte _group_number s)
     ;; sensor_msgs/Image _image_evidence
       (send _image_evidence :serialize s)
     ;; string _object_id
       (write-long (length _object_id) s) (princ _object_id s)
     ;; geometry_msgs/TransformStamped _object_location
       (send _object_location :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; time _stamp
     (send _stamp :sec (sys::peek buf ptr- :integer)) (incf ptr- 4)  (send _stamp :nsec (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uint8 _group_number
     (setq _group_number (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; sensor_msgs/Image _image_evidence
     (send _image_evidence :deserialize buf ptr-) (incf ptr- (send _image_evidence :serialization-length))
   ;; string _object_id
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _object_id (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; geometry_msgs/TransformStamped _object_location
     (send _object_location :deserialize buf ptr-) (incf ptr- (send _object_location :serialization-length))
   ;;
   self)
  )

(setf (get ras_msgs::RAS_Evidence :md5sum-) "71fcfca56843bccb15bf61ddab2df9eb")
(setf (get ras_msgs::RAS_Evidence :datatype-) "ras_msgs/RAS_Evidence")
(setf (get ras_msgs::RAS_Evidence :definition-)
      "#### Timestamp of the msg ####
time stamp

#### Group number####
uint8 group_number

#### RGB Image frame which shows detected/identified object ####
sensor_msgs/Image image_evidence

#### String that indicates which object has been detected/recognized ####
string object_id

# object_id should be one of the following (use these constants)
# an_object: object was detected but not identified
# red_hollow_cube: red cube with hole on top
string an_object=An Object
string red_cube=Red Cube
string red_hollow_cube=Red Hollow Cube
string blue_cube=Blue Cube
string green_cube=Green Cube
string yellow_cube=Yellow Cube
string yellow_ball=Yellow Ball
string red_ball=Red Ball
string red_cylinder=Red Cylinder
string green_cylinder=Green Cylinder
string green_hollow_cube=Green Hollow Cube
string blue_triangle=Blue Triangle
string purple_cross=Purple Cross
string purple_star=Purple Star
string orange_cross=Orange Cross
string patric=Patric

#### Location of the object in the /map frame ####
# MAKE SURE THE LOCATION IS EXPRESSED IN THE /map FRAME!
# we only care about X,Y position coordinate
geometry_msgs/TransformStamped object_location

# More info: https://anywiki.csc.kth.se/DD2425/doku.php?id=ras2017:object_evidence

================================================================================
MSG: sensor_msgs/Image
# This message contains an uncompressed image
# (0, 0) is at top-left corner of image
#

Header header        # Header timestamp should be acquisition time of image
                     # Header frame_id should be optical frame of camera
                     # origin of frame should be optical center of cameara
                     # +x should point to the right in the image
                     # +y should point down in the image
                     # +z should point into to plane of the image
                     # If the frame_id here and the frame_id of the CameraInfo
                     # message associated with the image conflict
                     # the behavior is undefined

uint32 height         # image height, that is, number of rows
uint32 width          # image width, that is, number of columns

# The legal values for encoding are in file src/image_encodings.cpp
# If you want to standardize a new string format, join
# ros-users@lists.sourceforge.net and send an email proposing a new encoding.

string encoding       # Encoding of pixels -- channel meaning, ordering, size
                      # taken from the list of strings in include/sensor_msgs/image_encodings.h

uint8 is_bigendian    # is this data bigendian?
uint32 step           # Full row length in bytes
uint8[] data          # actual matrix data, size is (step * rows)

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
# 0: no frame
# 1: global frame
string frame_id

================================================================================
MSG: geometry_msgs/TransformStamped
# This expresses a transform from coordinate frame header.frame_id
# to the coordinate frame child_frame_id
#
# This message is mostly used by the 
# <a href=\"http://wiki.ros.org/tf\">tf</a> package. 
# See its documentation for more information.

Header header
string child_frame_id # the frame id of the child frame
Transform transform

================================================================================
MSG: geometry_msgs/Transform
# This represents the transform between two coordinate frames in free space.

Vector3 translation
Quaternion rotation

================================================================================
MSG: geometry_msgs/Vector3
# This represents a vector in free space. 
# It is only meant to represent a direction. Therefore, it does not
# make sense to apply a translation to it (e.g., when applying a 
# generic rigid transformation to a Vector3, tf2 will only apply the
# rotation). If you want your data to be translatable too, use the
# geometry_msgs/Point message instead.

float64 x
float64 y
float64 z
================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w

")



(provide :ras_msgs/RAS_Evidence "71fcfca56843bccb15bf61ddab2df9eb")


