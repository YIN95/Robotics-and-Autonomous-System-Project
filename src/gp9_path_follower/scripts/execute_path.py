#!/usr/bin/env python

from __future__ import division
from __future__ import print_function

import rospy

from std_msgs.msg import Bool
from geometry_msgs.msg import Pose2D
from gp9_path_planning.msg import PathList


class PathExecutor:

    def __init__(self):

        self.sub_path_list = rospy.Subscriber('/path', PathList, self.path_callback)
        self.sub_close_enough = rospy.Subscriber('/close_enough', Bool, self.close_enough_callback)
        self.pub_desired_pose = rospy.Publisher('/desired_pose', Pose2D, queue_size=1)
        self.is_close_enough = False
        self.path = []

    def path_callback(self, path_list):
        self.path = path_list.list

    def close_enough_callback(self, close_enough):
        self.is_close_enough = close_enough.data

    def execute_path(self):

        if self.is_close_enough:
            if len(self.path) > 0:
                pose = self.path[0]
                desired_pose = Pose2D()
                desired_pose.x = pose.x
                desired_pose.y = pose.y
                self.path.pop(0)
                self.pub_desired_pose.publish(pose)


if __name__ == '__main__':
    rospy.init_node('path_executor')
    control_frequency = 10
    rate = rospy.Rate(control_frequency)

    pe = PathExecutor()

    while not rospy.is_shutdown():

        pe.execute_path()
        rate.sleep()