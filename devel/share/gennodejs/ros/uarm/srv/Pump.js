// Auto-generated. Do not edit!

// (in-package uarm.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class PumpRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.pump_status = null;
    }
    else {
      if (initObj.hasOwnProperty('pump_status')) {
        this.pump_status = initObj.pump_status
      }
      else {
        this.pump_status = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type PumpRequest
    // Serialize message field [pump_status]
    bufferOffset = _serializer.bool(obj.pump_status, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type PumpRequest
    let len;
    let data = new PumpRequest(null);
    // Deserialize message field [pump_status]
    data.pump_status = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'uarm/PumpRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '7f77d32e62bdec27de7408effdd28bd9';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    bool pump_status
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new PumpRequest(null);
    if (msg.pump_status !== undefined) {
      resolved.pump_status = msg.pump_status;
    }
    else {
      resolved.pump_status = false
    }

    return resolved;
    }
};

class PumpResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.pump_status = null;
    }
    else {
      if (initObj.hasOwnProperty('pump_status')) {
        this.pump_status = initObj.pump_status
      }
      else {
        this.pump_status = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type PumpResponse
    // Serialize message field [pump_status]
    bufferOffset = _serializer.bool(obj.pump_status, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type PumpResponse
    let len;
    let data = new PumpResponse(null);
    // Deserialize message field [pump_status]
    data.pump_status = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'uarm/PumpResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '7f77d32e62bdec27de7408effdd28bd9';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    bool pump_status
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new PumpResponse(null);
    if (msg.pump_status !== undefined) {
      resolved.pump_status = msg.pump_status;
    }
    else {
      resolved.pump_status = false
    }

    return resolved;
    }
};

module.exports = {
  Request: PumpRequest,
  Response: PumpResponse,
  md5sum() { return 'ff5a115a491fb65f575572e4a97ae33c'; },
  datatype() { return 'uarm/Pump'; }
};
