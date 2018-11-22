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

class ControllerParams {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.K = null;
      this.KI = null;
      this.INT_MAX = null;
      this.ticks = null;
      this.r = null;
      this.r_l = null;
      this.r_r = null;
      this.B = null;
    }
    else {
      if (initObj.hasOwnProperty('K')) {
        this.K = initObj.K
      }
      else {
        this.K = 0;
      }
      if (initObj.hasOwnProperty('KI')) {
        this.KI = initObj.KI
      }
      else {
        this.KI = 0;
      }
      if (initObj.hasOwnProperty('INT_MAX')) {
        this.INT_MAX = initObj.INT_MAX
      }
      else {
        this.INT_MAX = 0;
      }
      if (initObj.hasOwnProperty('ticks')) {
        this.ticks = initObj.ticks
      }
      else {
        this.ticks = 0;
      }
      if (initObj.hasOwnProperty('r')) {
        this.r = initObj.r
      }
      else {
        this.r = 0.0;
      }
      if (initObj.hasOwnProperty('r_l')) {
        this.r_l = initObj.r_l
      }
      else {
        this.r_l = 0.0;
      }
      if (initObj.hasOwnProperty('r_r')) {
        this.r_r = initObj.r_r
      }
      else {
        this.r_r = 0.0;
      }
      if (initObj.hasOwnProperty('B')) {
        this.B = initObj.B
      }
      else {
        this.B = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ControllerParams
    // Serialize message field [K]
    bufferOffset = _serializer.uint16(obj.K, buffer, bufferOffset);
    // Serialize message field [KI]
    bufferOffset = _serializer.uint16(obj.KI, buffer, bufferOffset);
    // Serialize message field [INT_MAX]
    bufferOffset = _serializer.uint16(obj.INT_MAX, buffer, bufferOffset);
    // Serialize message field [ticks]
    bufferOffset = _serializer.uint16(obj.ticks, buffer, bufferOffset);
    // Serialize message field [r]
    bufferOffset = _serializer.float32(obj.r, buffer, bufferOffset);
    // Serialize message field [r_l]
    bufferOffset = _serializer.float32(obj.r_l, buffer, bufferOffset);
    // Serialize message field [r_r]
    bufferOffset = _serializer.float32(obj.r_r, buffer, bufferOffset);
    // Serialize message field [B]
    bufferOffset = _serializer.float32(obj.B, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ControllerParams
    let len;
    let data = new ControllerParams(null);
    // Deserialize message field [K]
    data.K = _deserializer.uint16(buffer, bufferOffset);
    // Deserialize message field [KI]
    data.KI = _deserializer.uint16(buffer, bufferOffset);
    // Deserialize message field [INT_MAX]
    data.INT_MAX = _deserializer.uint16(buffer, bufferOffset);
    // Deserialize message field [ticks]
    data.ticks = _deserializer.uint16(buffer, bufferOffset);
    // Deserialize message field [r]
    data.r = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [r_l]
    data.r_l = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [r_r]
    data.r_r = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [B]
    data.B = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 24;
  }

  static datatype() {
    // Returns string type for a message object
    return 'ras_lab1_msgs/ControllerParams';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '8950f824993d2867219a00186d4620f7';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # PI Control parameters
    uint16 K
    uint16 KI
    uint16 INT_MAX
    uint16 ticks
    
    # Robot dimensions
    float32 r
    float32 r_l
    float32 r_r
    float32 B
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ControllerParams(null);
    if (msg.K !== undefined) {
      resolved.K = msg.K;
    }
    else {
      resolved.K = 0
    }

    if (msg.KI !== undefined) {
      resolved.KI = msg.KI;
    }
    else {
      resolved.KI = 0
    }

    if (msg.INT_MAX !== undefined) {
      resolved.INT_MAX = msg.INT_MAX;
    }
    else {
      resolved.INT_MAX = 0
    }

    if (msg.ticks !== undefined) {
      resolved.ticks = msg.ticks;
    }
    else {
      resolved.ticks = 0
    }

    if (msg.r !== undefined) {
      resolved.r = msg.r;
    }
    else {
      resolved.r = 0.0
    }

    if (msg.r_l !== undefined) {
      resolved.r_l = msg.r_l;
    }
    else {
      resolved.r_l = 0.0
    }

    if (msg.r_r !== undefined) {
      resolved.r_r = msg.r_r;
    }
    else {
      resolved.r_r = 0.0
    }

    if (msg.B !== undefined) {
      resolved.B = msg.B;
    }
    else {
      resolved.B = 0.0
    }

    return resolved;
    }
};

module.exports = ControllerParams;
