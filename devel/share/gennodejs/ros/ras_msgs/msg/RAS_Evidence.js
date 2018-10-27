// Auto-generated. Do not edit!

// (in-package ras_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let geometry_msgs = _finder('geometry_msgs');
let sensor_msgs = _finder('sensor_msgs');

//-----------------------------------------------------------

class RAS_Evidence {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.stamp = null;
      this.group_number = null;
      this.image_evidence = null;
      this.object_id = null;
      this.object_location = null;
    }
    else {
      if (initObj.hasOwnProperty('stamp')) {
        this.stamp = initObj.stamp
      }
      else {
        this.stamp = {secs: 0, nsecs: 0};
      }
      if (initObj.hasOwnProperty('group_number')) {
        this.group_number = initObj.group_number
      }
      else {
        this.group_number = 0;
      }
      if (initObj.hasOwnProperty('image_evidence')) {
        this.image_evidence = initObj.image_evidence
      }
      else {
        this.image_evidence = new sensor_msgs.msg.Image();
      }
      if (initObj.hasOwnProperty('object_id')) {
        this.object_id = initObj.object_id
      }
      else {
        this.object_id = '';
      }
      if (initObj.hasOwnProperty('object_location')) {
        this.object_location = initObj.object_location
      }
      else {
        this.object_location = new geometry_msgs.msg.TransformStamped();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type RAS_Evidence
    // Serialize message field [stamp]
    bufferOffset = _serializer.time(obj.stamp, buffer, bufferOffset);
    // Serialize message field [group_number]
    bufferOffset = _serializer.uint8(obj.group_number, buffer, bufferOffset);
    // Serialize message field [image_evidence]
    bufferOffset = sensor_msgs.msg.Image.serialize(obj.image_evidence, buffer, bufferOffset);
    // Serialize message field [object_id]
    bufferOffset = _serializer.string(obj.object_id, buffer, bufferOffset);
    // Serialize message field [object_location]
    bufferOffset = geometry_msgs.msg.TransformStamped.serialize(obj.object_location, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type RAS_Evidence
    let len;
    let data = new RAS_Evidence(null);
    // Deserialize message field [stamp]
    data.stamp = _deserializer.time(buffer, bufferOffset);
    // Deserialize message field [group_number]
    data.group_number = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [image_evidence]
    data.image_evidence = sensor_msgs.msg.Image.deserialize(buffer, bufferOffset);
    // Deserialize message field [object_id]
    data.object_id = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [object_location]
    data.object_location = geometry_msgs.msg.TransformStamped.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += sensor_msgs.msg.Image.getMessageSize(object.image_evidence);
    length += object.object_id.length;
    length += geometry_msgs.msg.TransformStamped.getMessageSize(object.object_location);
    return length + 13;
  }

  static datatype() {
    // Returns string type for a message object
    return 'ras_msgs/RAS_Evidence';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '71fcfca56843bccb15bf61ddab2df9eb';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    # <a href="http://wiki.ros.org/tf">tf</a> package. 
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new RAS_Evidence(null);
    if (msg.stamp !== undefined) {
      resolved.stamp = msg.stamp;
    }
    else {
      resolved.stamp = {secs: 0, nsecs: 0}
    }

    if (msg.group_number !== undefined) {
      resolved.group_number = msg.group_number;
    }
    else {
      resolved.group_number = 0
    }

    if (msg.image_evidence !== undefined) {
      resolved.image_evidence = sensor_msgs.msg.Image.Resolve(msg.image_evidence)
    }
    else {
      resolved.image_evidence = new sensor_msgs.msg.Image()
    }

    if (msg.object_id !== undefined) {
      resolved.object_id = msg.object_id;
    }
    else {
      resolved.object_id = ''
    }

    if (msg.object_location !== undefined) {
      resolved.object_location = geometry_msgs.msg.TransformStamped.Resolve(msg.object_location)
    }
    else {
      resolved.object_location = new geometry_msgs.msg.TransformStamped()
    }

    return resolved;
    }
};

// Constants for message
RAS_Evidence.Constants = {
  AN_OBJECT: 'An Object',
  RED_CUBE: 'Red Cube',
  RED_HOLLOW_CUBE: 'Red Hollow Cube',
  BLUE_CUBE: 'Blue Cube',
  GREEN_CUBE: 'Green Cube',
  YELLOW_CUBE: 'Yellow Cube',
  YELLOW_BALL: 'Yellow Ball',
  RED_BALL: 'Red Ball',
  RED_CYLINDER: 'Red Cylinder',
  GREEN_CYLINDER: 'Green Cylinder',
  GREEN_HOLLOW_CUBE: 'Green Hollow Cube',
  BLUE_TRIANGLE: 'Blue Triangle',
  PURPLE_CROSS: 'Purple Cross',
  PURPLE_STAR: 'Purple Star',
  ORANGE_CROSS: 'Orange Cross',
  PATRIC: 'Patric',
}

module.exports = RAS_Evidence;
