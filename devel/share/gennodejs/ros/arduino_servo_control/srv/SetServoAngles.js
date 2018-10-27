// Auto-generated. Do not edit!

// (in-package arduino_servo_control.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class SetServoAnglesRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.angle_servo_0 = null;
      this.angle_servo_1 = null;
    }
    else {
      if (initObj.hasOwnProperty('angle_servo_0')) {
        this.angle_servo_0 = initObj.angle_servo_0
      }
      else {
        this.angle_servo_0 = 0;
      }
      if (initObj.hasOwnProperty('angle_servo_1')) {
        this.angle_servo_1 = initObj.angle_servo_1
      }
      else {
        this.angle_servo_1 = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SetServoAnglesRequest
    // Serialize message field [angle_servo_0]
    bufferOffset = _serializer.int64(obj.angle_servo_0, buffer, bufferOffset);
    // Serialize message field [angle_servo_1]
    bufferOffset = _serializer.int64(obj.angle_servo_1, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SetServoAnglesRequest
    let len;
    let data = new SetServoAnglesRequest(null);
    // Deserialize message field [angle_servo_0]
    data.angle_servo_0 = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [angle_servo_1]
    data.angle_servo_1 = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 16;
  }

  static datatype() {
    // Returns string type for a service object
    return 'arduino_servo_control/SetServoAnglesRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'd092f7e1f5b91100a4b5a0975cd73973';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    int64 angle_servo_0
    int64 angle_servo_1
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SetServoAnglesRequest(null);
    if (msg.angle_servo_0 !== undefined) {
      resolved.angle_servo_0 = msg.angle_servo_0;
    }
    else {
      resolved.angle_servo_0 = 0
    }

    if (msg.angle_servo_1 !== undefined) {
      resolved.angle_servo_1 = msg.angle_servo_1;
    }
    else {
      resolved.angle_servo_1 = 0
    }

    return resolved;
    }
};

class SetServoAnglesResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.success = null;
    }
    else {
      if (initObj.hasOwnProperty('success')) {
        this.success = initObj.success
      }
      else {
        this.success = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SetServoAnglesResponse
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SetServoAnglesResponse
    let len;
    let data = new SetServoAnglesResponse(null);
    // Deserialize message field [success]
    data.success = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'arduino_servo_control/SetServoAnglesResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '358e233cde0c8a8bcfea4ce193f8fc15';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool success
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SetServoAnglesResponse(null);
    if (msg.success !== undefined) {
      resolved.success = msg.success;
    }
    else {
      resolved.success = false
    }

    return resolved;
    }
};

module.exports = {
  Request: SetServoAnglesRequest,
  Response: SetServoAnglesResponse,
  md5sum() { return '9f74ea09edde7d0924376ba2d9b77543'; },
  datatype() { return 'arduino_servo_control/SetServoAngles'; }
};
