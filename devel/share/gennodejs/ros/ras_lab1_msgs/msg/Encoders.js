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

class Encoders {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.encoder1 = null;
      this.encoder2 = null;
      this.delta_encoder1 = null;
      this.delta_encoder2 = null;
      this.timestamp = null;
    }
    else {
      if (initObj.hasOwnProperty('encoder1')) {
        this.encoder1 = initObj.encoder1
      }
      else {
        this.encoder1 = 0;
      }
      if (initObj.hasOwnProperty('encoder2')) {
        this.encoder2 = initObj.encoder2
      }
      else {
        this.encoder2 = 0;
      }
      if (initObj.hasOwnProperty('delta_encoder1')) {
        this.delta_encoder1 = initObj.delta_encoder1
      }
      else {
        this.delta_encoder1 = 0;
      }
      if (initObj.hasOwnProperty('delta_encoder2')) {
        this.delta_encoder2 = initObj.delta_encoder2
      }
      else {
        this.delta_encoder2 = 0;
      }
      if (initObj.hasOwnProperty('timestamp')) {
        this.timestamp = initObj.timestamp
      }
      else {
        this.timestamp = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Encoders
    // Serialize message field [encoder1]
    bufferOffset = _serializer.int32(obj.encoder1, buffer, bufferOffset);
    // Serialize message field [encoder2]
    bufferOffset = _serializer.int32(obj.encoder2, buffer, bufferOffset);
    // Serialize message field [delta_encoder1]
    bufferOffset = _serializer.int32(obj.delta_encoder1, buffer, bufferOffset);
    // Serialize message field [delta_encoder2]
    bufferOffset = _serializer.int32(obj.delta_encoder2, buffer, bufferOffset);
    // Serialize message field [timestamp]
    bufferOffset = _serializer.int32(obj.timestamp, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Encoders
    let len;
    let data = new Encoders(null);
    // Deserialize message field [encoder1]
    data.encoder1 = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [encoder2]
    data.encoder2 = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [delta_encoder1]
    data.delta_encoder1 = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [delta_encoder2]
    data.delta_encoder2 = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [timestamp]
    data.timestamp = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 20;
  }

  static datatype() {
    // Returns string type for a message object
    return 'ras_lab1_msgs/Encoders';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '6363193e7f66cd2bf0e60c5eb25e1bd5';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # encoder: absolute encoder value
    # delta_encoder: differential encoder value
    # tiemstamp: in milliseconds
    # 1 --> left
    # 2 --> right
    int32 encoder1
    int32 encoder2
    int32 delta_encoder1
    int32 delta_encoder2
    int32 timestamp
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Encoders(null);
    if (msg.encoder1 !== undefined) {
      resolved.encoder1 = msg.encoder1;
    }
    else {
      resolved.encoder1 = 0
    }

    if (msg.encoder2 !== undefined) {
      resolved.encoder2 = msg.encoder2;
    }
    else {
      resolved.encoder2 = 0
    }

    if (msg.delta_encoder1 !== undefined) {
      resolved.delta_encoder1 = msg.delta_encoder1;
    }
    else {
      resolved.delta_encoder1 = 0
    }

    if (msg.delta_encoder2 !== undefined) {
      resolved.delta_encoder2 = msg.delta_encoder2;
    }
    else {
      resolved.delta_encoder2 = 0
    }

    if (msg.timestamp !== undefined) {
      resolved.timestamp = msg.timestamp;
    }
    else {
      resolved.timestamp = 0
    }

    return resolved;
    }
};

module.exports = Encoders;
