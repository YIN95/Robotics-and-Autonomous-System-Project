// Generated by gencpp from file ras_lab1_msgs/Encoders.msg
// DO NOT EDIT!


#ifndef RAS_LAB1_MSGS_MESSAGE_ENCODERS_H
#define RAS_LAB1_MSGS_MESSAGE_ENCODERS_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace ras_lab1_msgs
{
template <class ContainerAllocator>
struct Encoders_
{
  typedef Encoders_<ContainerAllocator> Type;

  Encoders_()
    : encoder1(0)
    , encoder2(0)
    , delta_encoder1(0)
    , delta_encoder2(0)
    , timestamp(0)  {
    }
  Encoders_(const ContainerAllocator& _alloc)
    : encoder1(0)
    , encoder2(0)
    , delta_encoder1(0)
    , delta_encoder2(0)
    , timestamp(0)  {
  (void)_alloc;
    }



   typedef int32_t _encoder1_type;
  _encoder1_type encoder1;

   typedef int32_t _encoder2_type;
  _encoder2_type encoder2;

   typedef int32_t _delta_encoder1_type;
  _delta_encoder1_type delta_encoder1;

   typedef int32_t _delta_encoder2_type;
  _delta_encoder2_type delta_encoder2;

   typedef int32_t _timestamp_type;
  _timestamp_type timestamp;





  typedef boost::shared_ptr< ::ras_lab1_msgs::Encoders_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::ras_lab1_msgs::Encoders_<ContainerAllocator> const> ConstPtr;

}; // struct Encoders_

typedef ::ras_lab1_msgs::Encoders_<std::allocator<void> > Encoders;

typedef boost::shared_ptr< ::ras_lab1_msgs::Encoders > EncodersPtr;
typedef boost::shared_ptr< ::ras_lab1_msgs::Encoders const> EncodersConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::ras_lab1_msgs::Encoders_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::ras_lab1_msgs::Encoders_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace ras_lab1_msgs

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': True, 'IsMessage': True, 'HasHeader': False}
// {'std_msgs': ['/opt/ros/kinetic/share/std_msgs/cmake/../msg'], 'ras_lab1_msgs': ['/home/ras29/catkin_ws/src/ras_lab1/ras_lab1_msgs/msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::ras_lab1_msgs::Encoders_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::ras_lab1_msgs::Encoders_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::ras_lab1_msgs::Encoders_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::ras_lab1_msgs::Encoders_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::ras_lab1_msgs::Encoders_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::ras_lab1_msgs::Encoders_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::ras_lab1_msgs::Encoders_<ContainerAllocator> >
{
  static const char* value()
  {
    return "6363193e7f66cd2bf0e60c5eb25e1bd5";
  }

  static const char* value(const ::ras_lab1_msgs::Encoders_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x6363193e7f66cd2bULL;
  static const uint64_t static_value2 = 0xf0e60c5eb25e1bd5ULL;
};

template<class ContainerAllocator>
struct DataType< ::ras_lab1_msgs::Encoders_<ContainerAllocator> >
{
  static const char* value()
  {
    return "ras_lab1_msgs/Encoders";
  }

  static const char* value(const ::ras_lab1_msgs::Encoders_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::ras_lab1_msgs::Encoders_<ContainerAllocator> >
{
  static const char* value()
  {
    return "# encoder: absolute encoder value\n\
# delta_encoder: differential encoder value\n\
# tiemstamp: in milliseconds\n\
# 1 --> left\n\
# 2 --> right\n\
int32 encoder1\n\
int32 encoder2\n\
int32 delta_encoder1\n\
int32 delta_encoder2\n\
int32 timestamp\n\
\n\
";
  }

  static const char* value(const ::ras_lab1_msgs::Encoders_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::ras_lab1_msgs::Encoders_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.encoder1);
      stream.next(m.encoder2);
      stream.next(m.delta_encoder1);
      stream.next(m.delta_encoder2);
      stream.next(m.timestamp);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct Encoders_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::ras_lab1_msgs::Encoders_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::ras_lab1_msgs::Encoders_<ContainerAllocator>& v)
  {
    s << indent << "encoder1: ";
    Printer<int32_t>::stream(s, indent + "  ", v.encoder1);
    s << indent << "encoder2: ";
    Printer<int32_t>::stream(s, indent + "  ", v.encoder2);
    s << indent << "delta_encoder1: ";
    Printer<int32_t>::stream(s, indent + "  ", v.delta_encoder1);
    s << indent << "delta_encoder2: ";
    Printer<int32_t>::stream(s, indent + "  ", v.delta_encoder2);
    s << indent << "timestamp: ";
    Printer<int32_t>::stream(s, indent + "  ", v.timestamp);
  }
};

} // namespace message_operations
} // namespace ros

#endif // RAS_LAB1_MSGS_MESSAGE_ENCODERS_H
