// Generated by gencpp from file uarm/MoveToJoints.msg
// DO NOT EDIT!


#ifndef UARM_MESSAGE_MOVETOJOINTS_H
#define UARM_MESSAGE_MOVETOJOINTS_H

#include <ros/service_traits.h>


#include <uarm/MoveToJointsRequest.h>
#include <uarm/MoveToJointsResponse.h>


namespace uarm
{

struct MoveToJoints
{

typedef MoveToJointsRequest Request;
typedef MoveToJointsResponse Response;
Request request;
Response response;

typedef Request RequestType;
typedef Response ResponseType;

}; // struct MoveToJoints
} // namespace uarm


namespace ros
{
namespace service_traits
{


template<>
struct MD5Sum< ::uarm::MoveToJoints > {
  static const char* value()
  {
    return "112a3367014960c210096553f33b43c1";
  }

  static const char* value(const ::uarm::MoveToJoints&) { return value(); }
};

template<>
struct DataType< ::uarm::MoveToJoints > {
  static const char* value()
  {
    return "uarm/MoveToJoints";
  }

  static const char* value(const ::uarm::MoveToJoints&) { return value(); }
};


// service_traits::MD5Sum< ::uarm::MoveToJointsRequest> should match 
// service_traits::MD5Sum< ::uarm::MoveToJoints > 
template<>
struct MD5Sum< ::uarm::MoveToJointsRequest>
{
  static const char* value()
  {
    return MD5Sum< ::uarm::MoveToJoints >::value();
  }
  static const char* value(const ::uarm::MoveToJointsRequest&)
  {
    return value();
  }
};

// service_traits::DataType< ::uarm::MoveToJointsRequest> should match 
// service_traits::DataType< ::uarm::MoveToJoints > 
template<>
struct DataType< ::uarm::MoveToJointsRequest>
{
  static const char* value()
  {
    return DataType< ::uarm::MoveToJoints >::value();
  }
  static const char* value(const ::uarm::MoveToJointsRequest&)
  {
    return value();
  }
};

// service_traits::MD5Sum< ::uarm::MoveToJointsResponse> should match 
// service_traits::MD5Sum< ::uarm::MoveToJoints > 
template<>
struct MD5Sum< ::uarm::MoveToJointsResponse>
{
  static const char* value()
  {
    return MD5Sum< ::uarm::MoveToJoints >::value();
  }
  static const char* value(const ::uarm::MoveToJointsResponse&)
  {
    return value();
  }
};

// service_traits::DataType< ::uarm::MoveToJointsResponse> should match 
// service_traits::DataType< ::uarm::MoveToJoints > 
template<>
struct DataType< ::uarm::MoveToJointsResponse>
{
  static const char* value()
  {
    return DataType< ::uarm::MoveToJoints >::value();
  }
  static const char* value(const ::uarm::MoveToJointsResponse&)
  {
    return value();
  }
};

} // namespace service_traits
} // namespace ros

#endif // UARM_MESSAGE_MOVETOJOINTS_H
