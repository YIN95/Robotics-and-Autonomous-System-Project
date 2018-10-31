#!/usr/bin/env python

from __future__ import division
from __future__ import print_function

import rospy

from geometry_msgs.msg import Pose2D
from gp9_path_planning.msg import PathList

from obstacle_map import ObstacleMap
from visibility_graph import Vertex, Graph


def build_graph(path_to_map, robot_radius):
    obst_map = ObstacleMap(robot_radius)
    obst_map.construct_obstacle_map(path_to_map)
    graph = Graph(obst_map.obstacles, obst_map.map_dimensions)
    graph.build_visibility_graph()
    return graph


class PathPublisher:

    def __init__(self, visibility_graph):

        self.sub_pose = rospy.Subscriber('/pose', Pose2D, self._pose_callback)
        self.sub_global_desired_pose = rospy.Subscriber('/global_desired_pose', Pose2D,
                                                   self._global_desired_pose_callback)
        self.pub_path = rospy.Publisher('/path', PathList, queue_size=1)
        self.position = Vertex(0.225, 0.225)
        self.desired_position = Vertex(0.225, 0.225)
        self.graph = visibility_graph

        self.new_position = False

    def _pose_callback(self, pose):
        self.position = Vertex(pose.x, pose.y)

    def _global_desired_pose_callback(self, desired_pose):
        rospy.loginfo("In global callback")
        rospy.loginfo("===================================")
        self.desired_position = Vertex(desired_pose.x, desired_pose.y)
        self.new_position = True
    
    def _find_path(self):

        # remove the first element in shortest path since its the starting position
        vertex_path = self.graph.shortest_path(self.position, self.desired_position)[1:]
        path = []
        for vertex in vertex_path:
            pose = Pose2D()
            pose.x = vertex.x
            pose.y = vertex.y
            path.append(pose)

        self.new_position = False
        path_list = PathList()
        path_list.list = path
        return path_list

    def publish_path(self):
        path = self._find_path()
        self.pub_path.publish(path)


if __name__ == '__main__':
    rospy.init_node('planner_publisher')
    control_frequency = 30
    rate = rospy.Rate(control_frequency)

    path_to_map = "/home/ras19/catkin_ws/src/gp9_path_planning/maps/maze.txt"
    robot_radius = 0.17
    pb = PathPublisher(visibility_graph=build_graph(path_to_map, robot_radius))

    while not rospy.is_shutdown():

        if pb.new_position:
            pb.publish_path()

        rate.sleep()
