// Auto-generated. Do not edit!

// (in-package ras_lab1_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class PWM {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.PWM1 = null;
      this.PWM2 = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('PWM1')) {
        this.PWM1 = initObj.PWM1
      }
      else {
        this.PWM1 = 0;
      }
      if (initObj.hasOwnProperty('PWM2')) {
        this.PWM2 = initObj.PWM2
      }
      else {
        this.PWM2 = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type PWM
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [PWM1]
    bufferOffset = _serializer.int32(obj.PWM1, buffer, bufferOffset);
    // Serialize message field [PWM2]
    bufferOffset = _serializer.int32(obj.PWM2, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type PWM
    let len;
    let data = new PWM(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [PWM1]
    data.PWM1 = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [PWM2]
    data.PWM2 = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 8;
  }

  static datatype() {
    // Returns string type for a message object
    return 'ras_lab1_msgs/PWM';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '7536f824b238f3bc8ae162f5a97c5bfc';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # PWM should be between -255 and 255
    # 1 --> left
    # 2 --> right
    Header header
    
    int32 PWM1
    int32 PWM2
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new PWM(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.PWM1 !== undefined) {
      resolved.PWM1 = msg.PWM1;
    }
    else {
      resolved.PWM1 = 0
    }

    if (msg.PWM2 !== undefined) {
      resolved.PWM2 = msg.PWM2;
    }
    else {
      resolved.PWM2 = 0
    }

    return resolved;
    }
};

module.exports = PWM;
