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

class MoveToJointsRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.j0 = null;
      this.j1 = null;
      this.j2 = null;
      this.j3 = null;
      this.move_mode = null;
      this.movement_duration = null;
      this.interpolation_type = null;
      this.check_limits = null;
    }
    else {
      if (initObj.hasOwnProperty('j0')) {
        this.j0 = initObj.j0
      }
      else {
        this.j0 = 0.0;
      }
      if (initObj.hasOwnProperty('j1')) {
        this.j1 = initObj.j1
      }
      else {
        this.j1 = 0.0;
      }
      if (initObj.hasOwnProperty('j2')) {
        this.j2 = initObj.j2
      }
      else {
        this.j2 = 0.0;
      }
      if (initObj.hasOwnProperty('j3')) {
        this.j3 = initObj.j3
      }
      else {
        this.j3 = 0.0;
      }
      if (initObj.hasOwnProperty('move_mode')) {
        this.move_mode = initObj.move_mode
      }
      else {
        this.move_mode = 0;
      }
      if (initObj.hasOwnProperty('movement_duration')) {
        this.movement_duration = initObj.movement_duration
      }
      else {
        this.movement_duration = {secs: 0, nsecs: 0};
      }
      if (initObj.hasOwnProperty('interpolation_type')) {
        this.interpolation_type = initObj.interpolation_type
      }
      else {
        this.interpolation_type = 0;
      }
      if (initObj.hasOwnProperty('check_limits')) {
        this.check_limits = initObj.check_limits
      }
      else {
        this.check_limits = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type MoveToJointsRequest
    // Serialize message field [j0]
    bufferOffset = _serializer.float32(obj.j0, buffer, bufferOffset);
    // Serialize message field [j1]
    bufferOffset = _serializer.float32(obj.j1, buffer, bufferOffset);
    // Serialize message field [j2]
    bufferOffset = _serializer.float32(obj.j2, buffer, bufferOffset);
    // Serialize message field [j3]
    bufferOffset = _serializer.float32(obj.j3, buffer, bufferOffset);
    // Serialize message field [move_mode]
    bufferOffset = _serializer.int32(obj.move_mode, buffer, bufferOffset);
    // Serialize message field [movement_duration]
    bufferOffset = _serializer.duration(obj.movement_duration, buffer, bufferOffset);
    // Serialize message field [interpolation_type]
    bufferOffset = _serializer.int32(obj.interpolation_type, buffer, bufferOffset);
    // Serialize message field [check_limits]
    bufferOffset = _serializer.bool(obj.check_limits, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type MoveToJointsRequest
    let len;
    let data = new MoveToJointsRequest(null);
    // Deserialize message field [j0]
    data.j0 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [j1]
    data.j1 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [j2]
    data.j2 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [j3]
    data.j3 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [move_mode]
    data.move_mode = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [movement_duration]
    data.movement_duration = _deserializer.duration(buffer, bufferOffset);
    // Deserialize message field [interpolation_type]
    data.interpolation_type = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [check_limits]
    data.check_limits = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 33;
  }

  static datatype() {
    // Returns string type for a service object
    return 'uarm/MoveToJointsRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '1317bde3345e465c5901b25c6961719b';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    float32 j0
    float32 j1
    float32 j2
    float32 j3
    int32 move_mode
    duration movement_duration
    int32 interpolation_type
    bool check_limits
    
    
    int32 ABSOLUTE_MOVEMENT = 0
    int32 RELATIVE_MOVEMENT = 1
    
    
    
    
    
    
    int32 NO_INTERPOLATION = 0
    int32 CUBIC_INTERPOLATION = 1
    int32 LINEAR_INTERPOLATION = 2
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new MoveToJointsRequest(null);
    if (msg.j0 !== undefined) {
      resolved.j0 = msg.j0;
    }
    else {
      resolved.j0 = 0.0
    }

    if (msg.j1 !== undefined) {
      resolved.j1 = msg.j1;
    }
    else {
      resolved.j1 = 0.0
    }

    if (msg.j2 !== undefined) {
      resolved.j2 = msg.j2;
    }
    else {
      resolved.j2 = 0.0
    }

    if (msg.j3 !== undefined) {
      resolved.j3 = msg.j3;
    }
    else {
      resolved.j3 = 0.0
    }

    if (msg.move_mode !== undefined) {
      resolved.move_mode = msg.move_mode;
    }
    else {
      resolved.move_mode = 0
    }

    if (msg.movement_duration !== undefined) {
      resolved.movement_duration = msg.movement_duration;
    }
    else {
      resolved.movement_duration = {secs: 0, nsecs: 0}
    }

    if (msg.interpolation_type !== undefined) {
      resolved.interpolation_type = msg.interpolation_type;
    }
    else {
      resolved.interpolation_type = 0
    }

    if (msg.check_limits !== undefined) {
      resolved.check_limits = msg.check_limits;
    }
    else {
      resolved.check_limits = false
    }

    return resolved;
    }
};

// Constants for message
MoveToJointsRequest.Constants = {
  ABSOLUTE_MOVEMENT: 0,
  RELATIVE_MOVEMENT: 1,
  NO_INTERPOLATION: 0,
  CUBIC_INTERPOLATION: 1,
  LINEAR_INTERPOLATION: 2,
}

class MoveToJointsResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.j0 = null;
      this.j1 = null;
      this.j2 = null;
      this.j3 = null;
      this.elapsed = null;
      this.error = null;
    }
    else {
      if (initObj.hasOwnProperty('j0')) {
        this.j0 = initObj.j0
      }
      else {
        this.j0 = 0.0;
      }
      if (initObj.hasOwnProperty('j1')) {
        this.j1 = initObj.j1
      }
      else {
        this.j1 = 0.0;
      }
      if (initObj.hasOwnProperty('j2')) {
        this.j2 = initObj.j2
      }
      else {
        this.j2 = 0.0;
      }
      if (initObj.hasOwnProperty('j3')) {
        this.j3 = initObj.j3
      }
      else {
        this.j3 = 0.0;
      }
      if (initObj.hasOwnProperty('elapsed')) {
        this.elapsed = initObj.elapsed
      }
      else {
        this.elapsed = {secs: 0, nsecs: 0};
      }
      if (initObj.hasOwnProperty('error')) {
        this.error = initObj.error
      }
      else {
        this.error = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type MoveToJointsResponse
    // Serialize message field [j0]
    bufferOffset = _serializer.float32(obj.j0, buffer, bufferOffset);
    // Serialize message field [j1]
    bufferOffset = _serializer.float32(obj.j1, buffer, bufferOffset);
    // Serialize message field [j2]
    bufferOffset = _serializer.float32(obj.j2, buffer, bufferOffset);
    // Serialize message field [j3]
    bufferOffset = _serializer.float32(obj.j3, buffer, bufferOffset);
    // Serialize message field [elapsed]
    bufferOffset = _serializer.duration(obj.elapsed, buffer, bufferOffset);
    // Serialize message field [error]
    bufferOffset = _serializer.bool(obj.error, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type MoveToJointsResponse
    let len;
    let data = new MoveToJointsResponse(null);
    // Deserialize message field [j0]
    data.j0 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [j1]
    data.j1 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [j2]
    data.j2 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [j3]
    data.j3 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [elapsed]
    data.elapsed = _deserializer.duration(buffer, bufferOffset);
    // Deserialize message field [error]
    data.error = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 25;
  }

  static datatype() {
    // Returns string type for a service object
    return 'uarm/MoveToJointsResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '69d7a513721b240d81ffb22ed1f2e600';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    float32 j0
    float32 j1
    float32 j2
    float32 j3
    duration elapsed
    bool error
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new MoveToJointsResponse(null);
    if (msg.j0 !== undefined) {
      resolved.j0 = msg.j0;
    }
    else {
      resolved.j0 = 0.0
    }

    if (msg.j1 !== undefined) {
      resolved.j1 = msg.j1;
    }
    else {
      resolved.j1 = 0.0
    }

    if (msg.j2 !== undefined) {
      resolved.j2 = msg.j2;
    }
    else {
      resolved.j2 = 0.0
    }

    if (msg.j3 !== undefined) {
      resolved.j3 = msg.j3;
    }
    else {
      resolved.j3 = 0.0
    }

    if (msg.elapsed !== undefined) {
      resolved.elapsed = msg.elapsed;
    }
    else {
      resolved.elapsed = {secs: 0, nsecs: 0}
    }

    if (msg.error !== undefined) {
      resolved.error = msg.error;
    }
    else {
      resolved.error = false
    }

    return resolved;
    }
};

module.exports = {
  Request: MoveToJointsRequest,
  Response: MoveToJointsResponse,
  md5sum() { return '112a3367014960c210096553f33b43c1'; },
  datatype() { return 'uarm/MoveToJoints'; }
};
