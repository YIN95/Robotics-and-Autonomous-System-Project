// Auto-generated. Do not edit!

// (in-package ras_lab1_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class ServoMotors {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.servo1 = null;
      this.servoangle = null;
    }
    else {
      if (initObj.hasOwnProperty('servo1')) {
        this.servo1 = initObj.servo1
      }
      else {
        this.servo1 = 0;
      }
      if (initObj.hasOwnProperty('servoangle')) {
        this.servoangle = initObj.servoangle
      }
      else {
        this.servoangle = new Array(8).fill(0);
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ServoMotors
    // Serialize message field [servo1]
    bufferOffset = _serializer.uint8(obj.servo1, buffer, bufferOffset);
    // Check that the constant length array field [servoangle] has the right length
    if (obj.servoangle.length !== 8) {
      throw new Error('Unable to serialize array field servoangle - length must be 8')
    }
    // Serialize message field [servoangle]
    bufferOffset = _arraySerializer.uint8(obj.servoangle, buffer, bufferOffset, 8);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ServoMotors
    let len;
    let data = new ServoMotors(null);
    // Deserialize message field [servo1]
    data.servo1 = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [servoangle]
    data.servoangle = _arrayDeserializer.uint8(buffer, bufferOffset, 8)
    return data;
  }

  static getMessageSize(object) {
    return 9;
  }

  static datatype() {
    // Returns string type for a message object
    return 'ras_lab1_msgs/ServoMotors';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'f51d948c20e299a516b60c1bba9b447f';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # desired angular position
    # range 0-180 degrees
    
    uint8 servo1
    uint8[8] servoangle
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ServoMotors(null);
    if (msg.servo1 !== undefined) {
      resolved.servo1 = msg.servo1;
    }
    else {
      resolved.servo1 = 0
    }

    if (msg.servoangle !== undefined) {
      resolved.servoangle = msg.servoangle;
    }
    else {
      resolved.servoangle = new Array(8).fill(0)
    }

    return resolved;
    }
};

module.exports = ServoMotors;
