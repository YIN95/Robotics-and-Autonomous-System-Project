#!/usr/bin/env python

from __future__ import print_function
from __future__ import division

import rospy
import sys
sys.path.append('/home/ras19/catkin_ws/src/gp9_path_planning/scripts/')

import numpy as np
import shapely.geometry as sh
from obstacle_map import LineBox
from geometry_msgs.msg import Pose2D
from std_msgs.msg import Bool


class BatteryMapper:

    def __init__(self):
        self.maze_path = "/home/ras19/catkin_ws/src/gp9_path_planning/maps/maze2018.txt"
        self.new_path = "/home/ras19/catkin_ws/src/gp9_path_planning/maps/updated_maze.txt"
        self._create_new_file()
        self.subscriber_battery = rospy.Subscriber("/findBattery", Pose2D, self.callback_battery)
        self.publisher_battery = rospy.Publisher("/update_map", Bool, queue_size=1)
        self.dx = -0.01
        self.dy = -0.01
        self.batteries = []
        self.battery_expansion = 0.10

    def _create_new_file(self):
        with open(self.maze_path) as f:
            with open(self.new_path, 'w+') as f_new:
                lines = f.readlines()
                for line in lines:
                    f_new.write(line)

    def callback_battery(self, battery):
        x1 = battery.x
        y1 = battery.y

        battery_already_detected = self._is_detected(battery)
        
        if not battery_already_detected:

            x2 = x1 + self.dx
            y2 = y1 + self.dy
            battery_line = (x1, y1, x2, y2)
            self._add_battery(battery_line)
            line_to_write = "\n%.2f %.2f %.2f %.2f" % battery_line

            rospy.loginfo("writing battery position to file!")
            with open(self.new_path, 'a') as f:
                f.write(line_to_write)

            self.publisher_battery.publish(Bool(data=True))

    def _is_detected(self, battery):
        battery_pos = sh.Point(battery.x, battery.y)
        battery_already_detected = False
        for polygon in self.batteries:
            if polygon.contains(battery_pos):
                battery_already_detected = True
                rospy.loginfo("Already detected this battery")
                break

        return battery_already_detected

    def _add_battery(self, battery_line):
        x1, y1, x2, y2 = battery_line
        linebox = LineBox()
        linebox.construct_box(np.array((x1, y1)), np.array((x2, y2)), self.battery_expansion)
        battery_polygon = sh.Polygon(linebox.ordered_vertices)
        self.batteries.append(battery_polygon)



if __name__ == '__main__':
    rospy.init_node('battery_mapper')
    control_frequency = 10
    rate = rospy.Rate(control_frequency)

    mapper = BatteryMapper()

    while not rospy.is_shutdown():
        rospy.spin()
        rate.sleep()

