#!/usr/bin/env python

from __future__ import print_function
from __future__ import division

import rospy
from geometry_msgs.msg import Pose2D
from std_msgs.msg import Bool


class BatteryMapper:

    def __init__(self):
        self.maze_path = "/home/ras19/catkin_ws/src/gp9_path_planning/maps/maze.txt"
        self.new_path = "/home/ras19/catkin_ws/src/gp9_path_planning/maps/updated_maze.txt"
        self._create_new_file()
        self.subscriber_battery = rospy.Subscriber("/findBattery", Pose2D, self.callback_battery)
        self.publisher_battery = rospy.Publisher("/update_map", Bool)
        self.dx = -0.01
        self.dy = -0.01

    def _create_new_file(self):
        with open(self.maze_path) as f:
            with open(self.new_path, 'w+') as f_new:
                lines = f.readlines()
                for line in lines:
                    f_new.write(line)

    def callback_battery(self, battery):
        x1 = battery.x
        y1 = battery.y
        x2 = x1 + self.dx
        y2 = y1 + self.dy
        line = "\n%.2f %.2f %.2f %.2f" % (x1, y1, x2, y2)

        with open(self.new_path, 'a+') as f:
            f.write(line)

        self.publisher_battery.publish(Bool(data=True))


if __name__ == '__main__':
    rospy.init_node('battery_mapper')
    control_frequency = 10
    rate = rospy.Rate(control_frequency)

    mapper = BatteryMapper()

    while not rospy.is_shutdown():
        rospy.spin()
        rate.sleep()

