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

class ADConverter {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.ch1 = null;
      this.ch2 = null;
      this.ch3 = null;
      this.ch4 = null;
      this.ch5 = null;
      this.ch6 = null;
      this.ch7 = null;
      this.ch8 = null;
    }
    else {
      if (initObj.hasOwnProperty('ch1')) {
        this.ch1 = initObj.ch1
      }
      else {
        this.ch1 = 0;
      }
      if (initObj.hasOwnProperty('ch2')) {
        this.ch2 = initObj.ch2
      }
      else {
        this.ch2 = 0;
      }
      if (initObj.hasOwnProperty('ch3')) {
        this.ch3 = initObj.ch3
      }
      else {
        this.ch3 = 0;
      }
      if (initObj.hasOwnProperty('ch4')) {
        this.ch4 = initObj.ch4
      }
      else {
        this.ch4 = 0;
      }
      if (initObj.hasOwnProperty('ch5')) {
        this.ch5 = initObj.ch5
      }
      else {
        this.ch5 = 0;
      }
      if (initObj.hasOwnProperty('ch6')) {
        this.ch6 = initObj.ch6
      }
      else {
        this.ch6 = 0;
      }
      if (initObj.hasOwnProperty('ch7')) {
        this.ch7 = initObj.ch7
      }
      else {
        this.ch7 = 0;
      }
      if (initObj.hasOwnProperty('ch8')) {
        this.ch8 = initObj.ch8
      }
      else {
        this.ch8 = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ADConverter
    // Serialize message field [ch1]
    bufferOffset = _serializer.uint16(obj.ch1, buffer, bufferOffset);
    // Serialize message field [ch2]
    bufferOffset = _serializer.uint16(obj.ch2, buffer, bufferOffset);
    // Serialize message field [ch3]
    bufferOffset = _serializer.uint16(obj.ch3, buffer, bufferOffset);
    // Serialize message field [ch4]
    bufferOffset = _serializer.uint16(obj.ch4, buffer, bufferOffset);
    // Serialize message field [ch5]
    bufferOffset = _serializer.uint16(obj.ch5, buffer, bufferOffset);
    // Serialize message field [ch6]
    bufferOffset = _serializer.uint16(obj.ch6, buffer, bufferOffset);
    // Serialize message field [ch7]
    bufferOffset = _serializer.uint16(obj.ch7, buffer, bufferOffset);
    // Serialize message field [ch8]
    bufferOffset = _serializer.uint16(obj.ch8, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ADConverter
    let len;
    let data = new ADConverter(null);
    // Deserialize message field [ch1]
    data.ch1 = _deserializer.uint16(buffer, bufferOffset);
    // Deserialize message field [ch2]
    data.ch2 = _deserializer.uint16(buffer, bufferOffset);
    // Deserialize message field [ch3]
    data.ch3 = _deserializer.uint16(buffer, bufferOffset);
    // Deserialize message field [ch4]
    data.ch4 = _deserializer.uint16(buffer, bufferOffset);
    // Deserialize message field [ch5]
    data.ch5 = _deserializer.uint16(buffer, bufferOffset);
    // Deserialize message field [ch6]
    data.ch6 = _deserializer.uint16(buffer, bufferOffset);
    // Deserialize message field [ch7]
    data.ch7 = _deserializer.uint16(buffer, bufferOffset);
    // Deserialize message field [ch8]
    data.ch8 = _deserializer.uint16(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 16;
  }

  static datatype() {
    // Returns string type for a message object
    return 'ras_lab1_msgs/ADConverter';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'a5aa1c52a7841be08d11353384df8a9c';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # 8 * uint16 for IR sensors
    uint16 ch1
    uint16 ch2
    uint16 ch3
    uint16 ch4
    uint16 ch5
    uint16 ch6
    uint16 ch7
    uint16 ch8
    
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ADConverter(null);
    if (msg.ch1 !== undefined) {
      resolved.ch1 = msg.ch1;
    }
    else {
      resolved.ch1 = 0
    }

    if (msg.ch2 !== undefined) {
      resolved.ch2 = msg.ch2;
    }
    else {
      resolved.ch2 = 0
    }

    if (msg.ch3 !== undefined) {
      resolved.ch3 = msg.ch3;
    }
    else {
      resolved.ch3 = 0
    }

    if (msg.ch4 !== undefined) {
      resolved.ch4 = msg.ch4;
    }
    else {
      resolved.ch4 = 0
    }

    if (msg.ch5 !== undefined) {
      resolved.ch5 = msg.ch5;
    }
    else {
      resolved.ch5 = 0
    }

    if (msg.ch6 !== undefined) {
      resolved.ch6 = msg.ch6;
    }
    else {
      resolved.ch6 = 0
    }

    if (msg.ch7 !== undefined) {
      resolved.ch7 = msg.ch7;
    }
    else {
      resolved.ch7 = 0
    }

    if (msg.ch8 !== undefined) {
      resolved.ch8 = msg.ch8;
    }
    else {
      resolved.ch8 = 0
    }

    return resolved;
    }
};

module.exports = ADConverter;
