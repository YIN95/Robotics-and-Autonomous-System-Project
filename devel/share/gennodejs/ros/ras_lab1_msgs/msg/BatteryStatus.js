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

class BatteryStatus {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.on_batt = null;
      this.cell1 = null;
      this.cell2 = null;
      this.cell3 = null;
    }
    else {
      if (initObj.hasOwnProperty('on_batt')) {
        this.on_batt = initObj.on_batt
      }
      else {
        this.on_batt = 0;
      }
      if (initObj.hasOwnProperty('cell1')) {
        this.cell1 = initObj.cell1
      }
      else {
        this.cell1 = 0.0;
      }
      if (initObj.hasOwnProperty('cell2')) {
        this.cell2 = initObj.cell2
      }
      else {
        this.cell2 = 0.0;
      }
      if (initObj.hasOwnProperty('cell3')) {
        this.cell3 = initObj.cell3
      }
      else {
        this.cell3 = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type BatteryStatus
    // Serialize message field [on_batt]
    bufferOffset = _serializer.uint8(obj.on_batt, buffer, bufferOffset);
    // Serialize message field [cell1]
    bufferOffset = _serializer.float32(obj.cell1, buffer, bufferOffset);
    // Serialize message field [cell2]
    bufferOffset = _serializer.float32(obj.cell2, buffer, bufferOffset);
    // Serialize message field [cell3]
    bufferOffset = _serializer.float32(obj.cell3, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type BatteryStatus
    let len;
    let data = new BatteryStatus(null);
    // Deserialize message field [on_batt]
    data.on_batt = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [cell1]
    data.cell1 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [cell2]
    data.cell2 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [cell3]
    data.cell3 = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 13;
  }

  static datatype() {
    // Returns string type for a message object
    return 'ras_lab1_msgs/BatteryStatus';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '0cacd621f2d12e6814d77d4a2f6b6051';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Say if battery is in use, of if a wall adaptator is present
    # value : 1 if on battery, 0 if adaptator present
    uint8 on_batt
    
    # cell voltage
    float32 cell1
    float32 cell2
    float32 cell3
    
    
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new BatteryStatus(null);
    if (msg.on_batt !== undefined) {
      resolved.on_batt = msg.on_batt;
    }
    else {
      resolved.on_batt = 0
    }

    if (msg.cell1 !== undefined) {
      resolved.cell1 = msg.cell1;
    }
    else {
      resolved.cell1 = 0.0
    }

    if (msg.cell2 !== undefined) {
      resolved.cell2 = msg.cell2;
    }
    else {
      resolved.cell2 = 0.0
    }

    if (msg.cell3 !== undefined) {
      resolved.cell3 = msg.cell3;
    }
    else {
      resolved.cell3 = 0.0
    }

    return resolved;
    }
};

module.exports = BatteryStatus;
