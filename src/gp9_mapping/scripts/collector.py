#!/usr/bin/env python

from __future__ import print_function
from __future__ import division

import rospy
from sensor_msgs.msg import LaserScan
from geometry_msgs.msg import Pose2D
from geometry_msgs.msg import Twist

from math import pi


class Pose:

    def __init__(self, x, y, theta):
        self.x = x
        self.y = y
        self.theta = theta


class LaserCollector:

    def __init__(self, path):
        self.subscriber_laser = rospy.Subscriber("/scan", LaserScan, self.callback_laser)
        self.subscriber_pose = rospy.Subscriber("/pose", Pose2D, self.callback_pose)
        self.subscriber_pose = rospy.Subscriber("/velocity_estimate", Twist, self.callback_velocity)
        self.current_pose = Pose(0.225, 0.225, pi / 2)
        self.angular_speed = 0
        self.previous_write_time = rospy.get_rostime()
        self.seconds_between_writes = 2
        self.f = open(path, 'w+')

    def callback_pose(self, pose):
        self.current_pose = Pose(pose.x, pose.y, pose.theta)

    def callback_velocity(self, twist):
        self.angular_speed = twist.angular.z

    def callback_laser(self, laser):

        if (rospy.get_rostime() - self.previous_write_time).to_sec() > self.seconds_between_writes:
            turning = self.angular_speed > 0.8
            rospy.loginfo("Turning...")
            if not turning:
                rospy.loginfo("writing measurements!")
                ranges = laser.ranges
                string = '(%s, %s, %s), %s\n' % (self.current_pose.x, self.current_pose.y, self.current_pose.theta, ranges)
                self.f.write(string)
                self.previous_write_time = rospy.get_rostime()


if __name__ == '__main__':
    rospy.init_node('laser_collector')
    control_frequency = 10
    rate = rospy.Rate(control_frequency)

    collector = LaserCollector("/home/ras19/catkin_ws/src/gp9_mapping/measurements/measurements2.txt")

    while not rospy.is_shutdown():
        rospy.spin()
        rate.sleep()
