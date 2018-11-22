// Auto-generated. Do not edit!

// (in-package phidgets.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class lidar_controlRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.pause = null;
      this.pan_servo_index = null;
      this.tilt_servo_index = null;
      this.sensor_index = null;
      this.no_of_sensors = null;
      this.sensor_type = null;
      this.sensor_coupling = null;
      this.speed = null;
      this.acceleration = null;
      this.pan_position_left = null;
      this.pan_position_right = null;
      this.pan_position_left_angle_degrees = null;
      this.pan_position_right_angle_degrees = null;
      this.tilt_position_up = null;
      this.tilt_position_down = null;
      this.tilt_position_up_angle_degrees = null;
      this.tilt_position_down_angle_degrees = null;
      this.tilt_steps = null;
      this.cycle_time_sec = null;
    }
    else {
      if (initObj.hasOwnProperty('pause')) {
        this.pause = initObj.pause
      }
      else {
        this.pause = false;
      }
      if (initObj.hasOwnProperty('pan_servo_index')) {
        this.pan_servo_index = initObj.pan_servo_index
      }
      else {
        this.pan_servo_index = 0;
      }
      if (initObj.hasOwnProperty('tilt_servo_index')) {
        this.tilt_servo_index = initObj.tilt_servo_index
      }
      else {
        this.tilt_servo_index = 0;
      }
      if (initObj.hasOwnProperty('sensor_index')) {
        this.sensor_index = initObj.sensor_index
      }
      else {
        this.sensor_index = 0;
      }
      if (initObj.hasOwnProperty('no_of_sensors')) {
        this.no_of_sensors = initObj.no_of_sensors
      }
      else {
        this.no_of_sensors = 0;
      }
      if (initObj.hasOwnProperty('sensor_type')) {
        this.sensor_type = initObj.sensor_type
      }
      else {
        this.sensor_type = [];
      }
      if (initObj.hasOwnProperty('sensor_coupling')) {
        this.sensor_coupling = initObj.sensor_coupling
      }
      else {
        this.sensor_coupling = [];
      }
      if (initObj.hasOwnProperty('speed')) {
        this.speed = initObj.speed
      }
      else {
        this.speed = 0.0;
      }
      if (initObj.hasOwnProperty('acceleration')) {
        this.acceleration = initObj.acceleration
      }
      else {
        this.acceleration = 0.0;
      }
      if (initObj.hasOwnProperty('pan_position_left')) {
        this.pan_position_left = initObj.pan_position_left
      }
      else {
        this.pan_position_left = 0.0;
      }
      if (initObj.hasOwnProperty('pan_position_right')) {
        this.pan_position_right = initObj.pan_position_right
      }
      else {
        this.pan_position_right = 0.0;
      }
      if (initObj.hasOwnProperty('pan_position_left_angle_degrees')) {
        this.pan_position_left_angle_degrees = initObj.pan_position_left_angle_degrees
      }
      else {
        this.pan_position_left_angle_degrees = 0.0;
      }
      if (initObj.hasOwnProperty('pan_position_right_angle_degrees')) {
        this.pan_position_right_angle_degrees = initObj.pan_position_right_angle_degrees
      }
      else {
        this.pan_position_right_angle_degrees = 0.0;
      }
      if (initObj.hasOwnProperty('tilt_position_up')) {
        this.tilt_position_up = initObj.tilt_position_up
      }
      else {
        this.tilt_position_up = 0.0;
      }
      if (initObj.hasOwnProperty('tilt_position_down')) {
        this.tilt_position_down = initObj.tilt_position_down
      }
      else {
        this.tilt_position_down = 0.0;
      }
      if (initObj.hasOwnProperty('tilt_position_up_angle_degrees')) {
        this.tilt_position_up_angle_degrees = initObj.tilt_position_up_angle_degrees
      }
      else {
        this.tilt_position_up_angle_degrees = 0.0;
      }
      if (initObj.hasOwnProperty('tilt_position_down_angle_degrees')) {
        this.tilt_position_down_angle_degrees = initObj.tilt_position_down_angle_degrees
      }
      else {
        this.tilt_position_down_angle_degrees = 0.0;
      }
      if (initObj.hasOwnProperty('tilt_steps')) {
        this.tilt_steps = initObj.tilt_steps
      }
      else {
        this.tilt_steps = 0;
      }
      if (initObj.hasOwnProperty('cycle_time_sec')) {
        this.cycle_time_sec = initObj.cycle_time_sec
      }
      else {
        this.cycle_time_sec = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type lidar_controlRequest
    // Serialize message field [pause]
    bufferOffset = _serializer.bool(obj.pause, buffer, bufferOffset);
    // Serialize message field [pan_servo_index]
    bufferOffset = _serializer.int32(obj.pan_servo_index, buffer, bufferOffset);
    // Serialize message field [tilt_servo_index]
    bufferOffset = _serializer.int32(obj.tilt_servo_index, buffer, bufferOffset);
    // Serialize message field [sensor_index]
    bufferOffset = _serializer.int32(obj.sensor_index, buffer, bufferOffset);
    // Serialize message field [no_of_sensors]
    bufferOffset = _serializer.int32(obj.no_of_sensors, buffer, bufferOffset);
    // Serialize message field [sensor_type]
    bufferOffset = _arraySerializer.int32(obj.sensor_type, buffer, bufferOffset, null);
    // Serialize message field [sensor_coupling]
    bufferOffset = _arraySerializer.int32(obj.sensor_coupling, buffer, bufferOffset, null);
    // Serialize message field [speed]
    bufferOffset = _serializer.float32(obj.speed, buffer, bufferOffset);
    // Serialize message field [acceleration]
    bufferOffset = _serializer.float32(obj.acceleration, buffer, bufferOffset);
    // Serialize message field [pan_position_left]
    bufferOffset = _serializer.float32(obj.pan_position_left, buffer, bufferOffset);
    // Serialize message field [pan_position_right]
    bufferOffset = _serializer.float32(obj.pan_position_right, buffer, bufferOffset);
    // Serialize message field [pan_position_left_angle_degrees]
    bufferOffset = _serializer.float32(obj.pan_position_left_angle_degrees, buffer, bufferOffset);
    // Serialize message field [pan_position_right_angle_degrees]
    bufferOffset = _serializer.float32(obj.pan_position_right_angle_degrees, buffer, bufferOffset);
    // Serialize message field [tilt_position_up]
    bufferOffset = _serializer.float32(obj.tilt_position_up, buffer, bufferOffset);
    // Serialize message field [tilt_position_down]
    bufferOffset = _serializer.float32(obj.tilt_position_down, buffer, bufferOffset);
    // Serialize message field [tilt_position_up_angle_degrees]
    bufferOffset = _serializer.float32(obj.tilt_position_up_angle_degrees, buffer, bufferOffset);
    // Serialize message field [tilt_position_down_angle_degrees]
    bufferOffset = _serializer.float32(obj.tilt_position_down_angle_degrees, buffer, bufferOffset);
    // Serialize message field [tilt_steps]
    bufferOffset = _serializer.int32(obj.tilt_steps, buffer, bufferOffset);
    // Serialize message field [cycle_time_sec]
    bufferOffset = _serializer.float32(obj.cycle_time_sec, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type lidar_controlRequest
    let len;
    let data = new lidar_controlRequest(null);
    // Deserialize message field [pause]
    data.pause = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [pan_servo_index]
    data.pan_servo_index = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [tilt_servo_index]
    data.tilt_servo_index = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [sensor_index]
    data.sensor_index = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [no_of_sensors]
    data.no_of_sensors = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [sensor_type]
    data.sensor_type = _arrayDeserializer.int32(buffer, bufferOffset, null)
    // Deserialize message field [sensor_coupling]
    data.sensor_coupling = _arrayDeserializer.int32(buffer, bufferOffset, null)
    // Deserialize message field [speed]
    data.speed = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [acceleration]
    data.acceleration = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [pan_position_left]
    data.pan_position_left = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [pan_position_right]
    data.pan_position_right = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [pan_position_left_angle_degrees]
    data.pan_position_left_angle_degrees = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [pan_position_right_angle_degrees]
    data.pan_position_right_angle_degrees = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [tilt_position_up]
    data.tilt_position_up = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [tilt_position_down]
    data.tilt_position_down = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [tilt_position_up_angle_degrees]
    data.tilt_position_up_angle_degrees = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [tilt_position_down_angle_degrees]
    data.tilt_position_down_angle_degrees = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [tilt_steps]
    data.tilt_steps = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [cycle_time_sec]
    data.cycle_time_sec = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 4 * object.sensor_type.length;
    length += 4 * object.sensor_coupling.length;
    return length + 73;
  }

  static datatype() {
    // Returns string type for a service object
    return 'phidgets/lidar_controlRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'acbedaa0dacc8068c8686729472cbefb';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool pause
    int32 pan_servo_index
    int32 tilt_servo_index
    int32 sensor_index
    int32 no_of_sensors
    int32[] sensor_type
    int32[] sensor_coupling
    float32 speed
    float32 acceleration
    float32 pan_position_left
    float32 pan_position_right
    float32 pan_position_left_angle_degrees
    float32 pan_position_right_angle_degrees
    float32 tilt_position_up
    float32 tilt_position_down
    float32 tilt_position_up_angle_degrees
    float32 tilt_position_down_angle_degrees
    int32 tilt_steps
    float32 cycle_time_sec
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new lidar_controlRequest(null);
    if (msg.pause !== undefined) {
      resolved.pause = msg.pause;
    }
    else {
      resolved.pause = false
    }

    if (msg.pan_servo_index !== undefined) {
      resolved.pan_servo_index = msg.pan_servo_index;
    }
    else {
      resolved.pan_servo_index = 0
    }

    if (msg.tilt_servo_index !== undefined) {
      resolved.tilt_servo_index = msg.tilt_servo_index;
    }
    else {
      resolved.tilt_servo_index = 0
    }

    if (msg.sensor_index !== undefined) {
      resolved.sensor_index = msg.sensor_index;
    }
    else {
      resolved.sensor_index = 0
    }

    if (msg.no_of_sensors !== undefined) {
      resolved.no_of_sensors = msg.no_of_sensors;
    }
    else {
      resolved.no_of_sensors = 0
    }

    if (msg.sensor_type !== undefined) {
      resolved.sensor_type = msg.sensor_type;
    }
    else {
      resolved.sensor_type = []
    }

    if (msg.sensor_coupling !== undefined) {
      resolved.sensor_coupling = msg.sensor_coupling;
    }
    else {
      resolved.sensor_coupling = []
    }

    if (msg.speed !== undefined) {
      resolved.speed = msg.speed;
    }
    else {
      resolved.speed = 0.0
    }

    if (msg.acceleration !== undefined) {
      resolved.acceleration = msg.acceleration;
    }
    else {
      resolved.acceleration = 0.0
    }

    if (msg.pan_position_left !== undefined) {
      resolved.pan_position_left = msg.pan_position_left;
    }
    else {
      resolved.pan_position_left = 0.0
    }

    if (msg.pan_position_right !== undefined) {
      resolved.pan_position_right = msg.pan_position_right;
    }
    else {
      resolved.pan_position_right = 0.0
    }

    if (msg.pan_position_left_angle_degrees !== undefined) {
      resolved.pan_position_left_angle_degrees = msg.pan_position_left_angle_degrees;
    }
    else {
      resolved.pan_position_left_angle_degrees = 0.0
    }

    if (msg.pan_position_right_angle_degrees !== undefined) {
      resolved.pan_position_right_angle_degrees = msg.pan_position_right_angle_degrees;
    }
    else {
      resolved.pan_position_right_angle_degrees = 0.0
    }

    if (msg.tilt_position_up !== undefined) {
      resolved.tilt_position_up = msg.tilt_position_up;
    }
    else {
      resolved.tilt_position_up = 0.0
    }

    if (msg.tilt_position_down !== undefined) {
      resolved.tilt_position_down = msg.tilt_position_down;
    }
    else {
      resolved.tilt_position_down = 0.0
    }

    if (msg.tilt_position_up_angle_degrees !== undefined) {
      resolved.tilt_position_up_angle_degrees = msg.tilt_position_up_angle_degrees;
    }
    else {
      resolved.tilt_position_up_angle_degrees = 0.0
    }

    if (msg.tilt_position_down_angle_degrees !== undefined) {
      resolved.tilt_position_down_angle_degrees = msg.tilt_position_down_angle_degrees;
    }
    else {
      resolved.tilt_position_down_angle_degrees = 0.0
    }

    if (msg.tilt_steps !== undefined) {
      resolved.tilt_steps = msg.tilt_steps;
    }
    else {
      resolved.tilt_steps = 0
    }

    if (msg.cycle_time_sec !== undefined) {
      resolved.cycle_time_sec = msg.cycle_time_sec;
    }
    else {
      resolved.cycle_time_sec = 0.0
    }

    return resolved;
    }
};

class lidar_controlResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.ack = null;
    }
    else {
      if (initObj.hasOwnProperty('ack')) {
        this.ack = initObj.ack
      }
      else {
        this.ack = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type lidar_controlResponse
    // Serialize message field [ack]
    bufferOffset = _serializer.int32(obj.ack, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type lidar_controlResponse
    let len;
    let data = new lidar_controlResponse(null);
    // Deserialize message field [ack]
    data.ack = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'phidgets/lidar_controlResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '35e806e08fe8e25fde5b4c88fa52f05b';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32 ack
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new lidar_controlResponse(null);
    if (msg.ack !== undefined) {
      resolved.ack = msg.ack;
    }
    else {
      resolved.ack = 0
    }

    return resolved;
    }
};

module.exports = {
  Request: lidar_controlRequest,
  Response: lidar_controlResponse,
  md5sum() { return '63541d856b007db47fcb5fb28b699f7b'; },
  datatype() { return 'phidgets/lidar_control'; }
};
