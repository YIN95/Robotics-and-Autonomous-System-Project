# !/usr/bin/env python
from __future__ import print_function
from __future__ import division

import rospy
from sensor_msgs.msg import LaserScan
from geometry_msgs.msg import Pose2D

from math import pi


class Pose:

    def __init__(self, x, y, theta):
        self.x = x
        self.y = y
        self.theta = theta


class LaserCollector:

    def __init__(self, path):
        self.path = path
        self.subscriber_laser = rospy.Subscriber("/scan", LaserScan, self.callback_laser)
        self.subscriber_pose = rospy.Subscriber("/pose", Pose2D, self.callback_pose)
        self.current_pose = Pose(0.225, 0.225, pi/2)
        self.counter = 0
        self.seconds_between_writes = 2
        self.localization_frequency = 7

    def callback_laser(self, laser):

        if self.counter == int(self.seconds_between_writes * self.localization_frequency):
            ranges = laser.ranges
            string = '(%s, %s, %s), %s' % (self.current_pose.x, self.current_pose.y, self.current_pose.theta, ranges)
            with open(self.path, 'a+') as f:
                f.write(string)
            self.counter = 0
        else:
            self.counter += 1

    def callback_pose(self, pose):
        self.current_pose = Pose(pose.x, pose.y, pose.theta)


if __name__ == '__main__':
    rospy.init_node('laser_collector')
    control_frequency = 1
    rate = rospy.Rate(control_frequency)

    collector = LaserCollector()

    while not rospy.is_shutdown():
        rospy.spin()
        rate.sleep()

