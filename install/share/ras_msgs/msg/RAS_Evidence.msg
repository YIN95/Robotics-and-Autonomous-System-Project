#### Timestamp of the msg ####
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
