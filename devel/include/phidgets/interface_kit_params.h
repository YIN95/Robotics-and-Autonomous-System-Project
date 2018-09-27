// Generated by gencpp from file phidgets/interface_kit_params.msg
// DO NOT EDIT!


#ifndef PHIDGETS_MESSAGE_INTERFACE_KIT_PARAMS_H
#define PHIDGETS_MESSAGE_INTERFACE_KIT_PARAMS_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>

#include <std_msgs/Header.h>

namespace phidgets
{
template <class ContainerAllocator>
struct interface_kit_params_
{
  typedef interface_kit_params_<ContainerAllocator> Type;

  interface_kit_params_()
    : header()
    , index(0)
    , value_type(0)
    , value(0)  {
    }
  interface_kit_params_(const ContainerAllocator& _alloc)
    : header(_alloc)
    , index(0)
    , value_type(0)
    , value(0)  {
  (void)_alloc;
    }



   typedef  ::std_msgs::Header_<ContainerAllocator>  _header_type;
  _header_type header;

   typedef int32_t _index_type;
  _index_type index;

   typedef int32_t _value_type_type;
  _value_type_type value_type;

   typedef int32_t _value_type;
  _value_type value;





  typedef boost::shared_ptr< ::phidgets::interface_kit_params_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::phidgets::interface_kit_params_<ContainerAllocator> const> ConstPtr;

}; // struct interface_kit_params_

typedef ::phidgets::interface_kit_params_<std::allocator<void> > interface_kit_params;

typedef boost::shared_ptr< ::phidgets::interface_kit_params > interface_kit_paramsPtr;
typedef boost::shared_ptr< ::phidgets::interface_kit_params const> interface_kit_paramsConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::phidgets::interface_kit_params_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::phidgets::interface_kit_params_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace phidgets

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': False, 'IsMessage': True, 'HasHeader': True}
// {'nav_msgs': ['/opt/ros/kinetic/share/nav_msgs/cmake/../msg'], 'sensor_msgs': ['/opt/ros/kinetic/share/sensor_msgs/cmake/../msg'], 'actionlib_msgs': ['/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg'], 'std_msgs': ['/opt/ros/kinetic/share/std_msgs/cmake/../msg'], 'geometry_msgs': ['/opt/ros/kinetic/share/geometry_msgs/cmake/../msg'], 'phidgets': ['/home/ras19/catkin_ws/src/ras_project/ras_phidget/msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::phidgets::interface_kit_params_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::phidgets::interface_kit_params_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::phidgets::interface_kit_params_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::phidgets::interface_kit_params_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::phidgets::interface_kit_params_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::phidgets::interface_kit_params_<ContainerAllocator> const>
  : TrueType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::phidgets::interface_kit_params_<ContainerAllocator> >
{
  static const char* value()
  {
    return "b369436f357b4695ea7db89ef60fcefd";
  }

  static const char* value(const ::phidgets::interface_kit_params_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xb369436f357b4695ULL;
  static const uint64_t static_value2 = 0xea7db89ef60fcefdULL;
};

template<class ContainerAllocator>
struct DataType< ::phidgets::interface_kit_params_<ContainerAllocator> >
{
  static const char* value()
  {
    return "phidgets/interface_kit_params";
  }

  static const char* value(const ::phidgets::interface_kit_params_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::phidgets::interface_kit_params_<ContainerAllocator> >
{
  static const char* value()
  {
    return "Header header\n\
int32 index\n\
int32 value_type\n\
int32 value\n\
 \n\
\n\
================================================================================\n\
MSG: std_msgs/Header\n\
# Standard metadata for higher-level stamped data types.\n\
# This is generally used to communicate timestamped data \n\
# in a particular coordinate frame.\n\
# \n\
# sequence ID: consecutively increasing ID \n\
uint32 seq\n\
#Two-integer timestamp that is expressed as:\n\
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')\n\
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')\n\
# time-handling sugar is provided by the client library\n\
time stamp\n\
#Frame this data is associated with\n\
# 0: no frame\n\
# 1: global frame\n\
string frame_id\n\
";
  }

  static const char* value(const ::phidgets::interface_kit_params_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::phidgets::interface_kit_params_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.header);
      stream.next(m.index);
      stream.next(m.value_type);
      stream.next(m.value);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct interface_kit_params_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::phidgets::interface_kit_params_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::phidgets::interface_kit_params_<ContainerAllocator>& v)
  {
    s << indent << "header: ";
    s << std::endl;
    Printer< ::std_msgs::Header_<ContainerAllocator> >::stream(s, indent + "  ", v.header);
    s << indent << "index: ";
    Printer<int32_t>::stream(s, indent + "  ", v.index);
    s << indent << "value_type: ";
    Printer<int32_t>::stream(s, indent + "  ", v.value_type);
    s << indent << "value: ";
    Printer<int32_t>::stream(s, indent + "  ", v.value);
  }
};

} // namespace message_operations
} // namespace ros

#endif // PHIDGETS_MESSAGE_INTERFACE_KIT_PARAMS_H
