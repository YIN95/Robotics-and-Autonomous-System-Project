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

class AttachDetachRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.attach = null;
    }
    else {
      if (initObj.hasOwnProperty('attach')) {
        this.attach = initObj.attach
      }
      else {
        this.attach = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type AttachDetachRequest
    // Serialize message field [attach]
    bufferOffset = _serializer.bool(obj.attach, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type AttachDetachRequest
    let len;
    let data = new AttachDetachRequest(null);
    // Deserialize message field [attach]
    data.attach = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'uarm/AttachDetachRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'b4c9c23f471124df2ba7b8aa21eb56fe';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    bool attach
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new AttachDetachRequest(null);
    if (msg.attach !== undefined) {
      resolved.attach = msg.attach;
    }
    else {
      resolved.attach = false
    }

    return resolved;
    }
};

class AttachDetachResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.attach = null;
    }
    else {
      if (initObj.hasOwnProperty('attach')) {
        this.attach = initObj.attach
      }
      else {
        this.attach = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type AttachDetachResponse
    // Serialize message field [attach]
    bufferOffset = _serializer.bool(obj.attach, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type AttachDetachResponse
    let len;
    let data = new AttachDetachResponse(null);
    // Deserialize message field [attach]
    data.attach = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'uarm/AttachDetachResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'b4c9c23f471124df2ba7b8aa21eb56fe';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    bool attach
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new AttachDetachResponse(null);
    if (msg.attach !== undefined) {
      resolved.attach = msg.attach;
    }
    else {
      resolved.attach = false
    }

    return resolved;
    }
};

module.exports = {
  Request: AttachDetachRequest,
  Response: AttachDetachResponse,
  md5sum() { return '15a30b512eac3d5d3679caf838a84beb'; },
  datatype() { return 'uarm/AttachDetach'; }
};
