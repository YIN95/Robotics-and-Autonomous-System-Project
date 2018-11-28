#!/usr/bin/env python

from __future__ import print_function
from __future__ import division

import rospy
from geometry_msgs.msg import Pose2D
from math import pi
import math
import numpy as np

class Pose:

    def __init__(self, x, y, theta):
        self.x = x
        self.y = y
        self.theta = theta


class Collector:

    def __init__(self, path_to_write):
        self.subscriber_pose = rospy.Subscriber("/pose", Pose2D, self.callback_pose)
        self.current_pose = Pose(0.225, 0.225, pi / 2)
        self.sizex = 241
        self.sizey = 241
        self.D = 25
        self.R = 15
        self.alpha = 45.0/180
        self.Area = np.zeros((self.sizex, self.sizey))
        self.mapX = 0
        self.mapY = 0
        self.path = path_to_write
        self.index = 0
        np.savetxt(path_to_write, self.Area,fmt='%d')

    def callback_pose(self, pose):
        self.current_pose = Pose(pose.x, pose.y, pose.theta)
        self.index += 1
        if (self.index > 100):
            self.index = 0
            self.mapX = int(self.current_pose.x * 100)
            self.mapY = int(self.current_pose.y * 100)
            rospy.loginfo("x %d", self.mapX)
            rospy.loginfo("y %d", self.mapY)
            xl = min(max(0, self.mapX-40), self.sizex)
            xr = min(max(0, self.mapX+40), self.sizex)
            yl = min(max(0, self.mapY-40), self.sizey)
            yr = min(max(0, self.mapY+40), self.sizey)
            
            visionCenterX = self.mapX + self.D*math.sin(self.current_pose.theta)
            visionCenterY = self.mapY + self.D*math.cos(self.current_pose.theta)
            
            for i in range(xl, xr):
                for j in range(yl, yr):
                    if (self.dis(i, j, visionCenterX, visionCenterY) < self.R):
                        self.Area[i, j] = 1

            np.savetxt(self.path, self.Area,fmt='%d')

    def dis (self, x1, y1, x2, y2):
        l1 = x1 - x2
        l2 = y1 - y2
        distance = math.sqrt(l1*l1 + l2*l2)

        return distance
if __name__ == '__main__':
    rospy.init_node('detectedPath')
    control_frequency = 10
    rate = rospy.Rate(control_frequency)

    collector = Collector("/home/ras19/catkin_ws/src/gp9_objects_detection/scripts/detectedPath.txt")

    while not rospy.is_shutdown():
        rospy.spin()
        rate.sleep()
