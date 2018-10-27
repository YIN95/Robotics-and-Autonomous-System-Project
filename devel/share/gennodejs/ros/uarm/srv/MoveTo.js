// Auto-generated. Do not edit!

// (in-package uarm.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------


//-----------------------------------------------------------

class MoveToRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.position = null;
      this.eef_orientation = null;
      this.move_mode = null;
      this.movement_duration = null;
      this.ignore_orientation = null;
      this.interpolation_type = null;
      this.check_limits = null;
    }
    else {
      if (initObj.hasOwnProperty('position')) {
        this.position = initObj.position
      }
      else {
        this.position = new geometry_msgs.msg.Point();
      }
      if (initObj.hasOwnProperty('eef_orientation')) {
        this.eef_orientation = initObj.eef_orientation
      }
      else {
        this.eef_orientation = 0.0;
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
      if (initObj.hasOwnProperty('ignore_orientation')) {
        this.ignore_orientation = initObj.ignore_orientation
      }
      else {
        this.ignore_orientation = false;
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
    // Serializes a message object of type MoveToRequest
    // Serialize message field [position]
    bufferOffset = geometry_msgs.msg.Point.serialize(obj.position, buffer, bufferOffset);
    // Serialize message field [eef_orientation]
    bufferOffset = _serializer.float32(obj.eef_orientation, buffer, bufferOffset);
    // Serialize message field [move_mode]
    bufferOffset = _serializer.int32(obj.move_mode, buffer, bufferOffset);
    // Serialize message field [movement_duration]
    bufferOffset = _serializer.duration(obj.movement_duration, buffer, bufferOffset);
    // Serialize message field [ignore_orientation]
    bufferOffset = _serializer.bool(obj.ignore_orientation, buffer, bufferOffset);
    // Serialize message field [interpolation_type]
    bufferOffset = _serializer.int32(obj.interpolation_type, buffer, bufferOffset);
    // Serialize message field [check_limits]
    bufferOffset = _serializer.bool(obj.check_limits, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type MoveToRequest
    let len;
    let data = new MoveToRequest(null);
    // Deserialize message field [position]
    data.position = geometry_msgs.msg.Point.deserialize(buffer, bufferOffset);
    // Deserialize message field [eef_orientation]
    data.eef_orientation = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [move_mode]
    data.move_mode = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [movement_duration]
    data.movement_duration = _deserializer.duration(buffer, bufferOffset);
    // Deserialize message field [ignore_orientation]
    data.ignore_orientation = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [interpolation_type]
    data.interpolation_type = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [check_limits]
    data.check_limits = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 46;
  }

  static datatype() {
    // Returns string type for a service object
    return 'uarm/MoveToRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'ab030bae93172a56ee5d849ac8b8bebb';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    geometry_msgs/Point position
    float32 eef_orientation
    int32 move_mode
    duration movement_duration
    bool ignore_orientation
    int32 interpolation_type
    bool check_limits
    
    
    int32 ABSOLUTE_MOVEMENT = 0
    int32 RELATIVE_MOVEMENT = 1
    
    
    
    
    
    
    int32 NO_INTERPOLATION = 0
    int32 CUBIC_INTERPOLATION = 1
    int32 LINEAR_INTERPOLATION = 2
    
    
    ================================================================================
    MSG: geometry_msgs/Point
    # This contains the position of a point in free space
    float64 x
    float64 y
    float64 z
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new MoveToRequest(null);
    if (msg.position !== undefined) {
      resolved.position = geometry_msgs.msg.Point.Resolve(msg.position)
    }
    else {
      resolved.position = new geometry_msgs.msg.Point()
    }

    if (msg.eef_orientation !== undefined) {
      resolved.eef_orientation = msg.eef_orientation;
    }
    else {
      resolved.eef_orientation = 0.0
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

    if (msg.ignore_orientation !== undefined) {
      resolved.ignore_orientation = msg.ignore_orientation;
    }
    else {
      resolved.ignore_orientation = false
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
MoveToRequest.Constants = {
  ABSOLUTE_MOVEMENT: 0,
  RELATIVE_MOVEMENT: 1,
  NO_INTERPOLATION: 0,
  CUBIC_INTERPOLATION: 1,
  LINEAR_INTERPOLATION: 2,
}

class MoveToResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.position = null;
      this.elapsed = null;
      this.error = null;
    }
    else {
      if (initObj.hasOwnProperty('position')) {
        this.position = initObj.position
      }
      else {
        this.position = new geometry_msgs.msg.Point();
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
    // Serializes a message object of type MoveToResponse
    // Serialize message field [position]
    bufferOffset = geometry_msgs.msg.Point.serialize(obj.position, buffer, bufferOffset);
    // Serialize message field [elapsed]
    bufferOffset = _serializer.duration(obj.elapsed, buffer, bufferOffset);
    // Serialize message field [error]
    bufferOffset = _serializer.bool(obj.error, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type MoveToResponse
    let len;
    let data = new MoveToResponse(null);
    // Deserialize message field [position]
    data.position = geometry_msgs.msg.Point.deserialize(buffer, bufferOffset);
    // Deserialize message field [elapsed]
    data.elapsed = _deserializer.duration(buffer, bufferOffset);
    // Deserialize message field [error]
    data.error = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 33;
  }

  static datatype() {
    // Returns string type for a service object
    return 'uarm/MoveToResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '8f9784c5f3f87c5aee051029211ee037';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    geometry_msgs/Point position
    duration elapsed
    bool error
    
    
    ================================================================================
    MSG: geometry_msgs/Point
    # This contains the position of a point in free space
    float64 x
    float64 y
    float64 z
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new MoveToResponse(null);
    if (msg.position !== undefined) {
      resolved.position = geometry_msgs.msg.Point.Resolve(msg.position)
    }
    else {
      resolved.position = new geometry_msgs.msg.Point()
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
  Request: MoveToRequest,
  Response: MoveToResponse,
  md5sum() { return 'b5950699ca93b2e0816f732b4daecc97'; },
  datatype() { return 'uarm/MoveTo'; }
};
