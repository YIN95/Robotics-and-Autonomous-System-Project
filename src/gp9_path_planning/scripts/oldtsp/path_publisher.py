#!/usr/bin/env python

from __future__ import division
from __future__ import print_function

import rospy

from std_msgs.msg import Bool
from geometry_msgs.msg import Pose2D
from gp9_path_planning.msg import PathList

from obstacle_map import ObstacleMap
from visibility_graph import Vertex, Graph


def build_graph(path_to_map, robot_radius):
    obst_map = ObstacleMap(robot_radius)
    obst_map.construct_obstacle_map(path_to_map)
    graph = Graph(obst_map.obstacles, obst_map.map_dimensions, robot_radius)
    graph.build_visibility_graph()
    return graph


class PathPublisher:

    def __init__(self):

        start_x = rospy.get_param("robot/starting_position/x")
        start_y = rospy.get_param("robot/starting_position/y")
        self.path_to_maze = rospy.get_param("/maze/path")
        self.path_to_updated_maze = rospy.get_param("/maze/path_updated")
        self.robot_radius = rospy.get_param("/robot/radius")

        self.sub_pose = rospy.Subscriber('/pose', Pose2D, self._pose_callback)
        self.sub_update_map = rospy.Subscriber('/update_map', Bool, self._update_map_callback)
        self.sub_global_desired_pose = rospy.Subscriber('/global_desired_pose', Pose2D,
                                                   self._global_desired_pose_callback)
        self.pub_global_desired_pose = rospy.Publisher('/global_desired_pose', 
                                                    Pose2D, queue_size=1)
        self.pub_path = rospy.Publisher('/path', PathList, queue_size=1)
        self.position = Vertex(start_x, start_y)
        self.desired_position = Vertex(start_x, start_y)
        self.desired_angle = 0
        self.graph = build_graph(self.path_to_maze, self.robot_radius)

        self.new_position = False

    def _pose_callback(self, pose):
        self.position = Vertex(pose.x, pose.y)

    def _global_desired_pose_callback(self, desired_pose):
        self.desired_position = Vertex(desired_pose.x, desired_pose.y)
        self.desired_angle = desired_pose.theta
        self.new_position = True

    def _update_map_callback(self, _):
        """
        What comes in the _ is not important (it's a Bool.data = True),
        just that we receive it means that we should update the map.
        """

        rospy.loginfo("Rebuilding the visibility graph")
        self.graph = build_graph(self.path_to_updated_maze, self.robot_radius)
        rospy.loginfo("Done building new graph")
    
    def _find_path(self):

        # remove the first element in shortest path since its the starting position
        vertex_path = self.graph.shortest_path(self.position, self.desired_position)[1:]
        path = []
        for vertex in vertex_path:
            pose = Pose2D()
            pose.x = vertex.x
            pose.y = vertex.y
            path.append(pose)

        if (vertex_path[-1] - self.desired_position).norm() > 1e-6:
            pose.theta = self.desired_angle
            self.pub_global_desired_pose.publish(pose)

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

    pb = PathPublisher()

    while not rospy.is_shutdown():

        if pb.new_position:
            pb.publish_path()

        rate.sleep()