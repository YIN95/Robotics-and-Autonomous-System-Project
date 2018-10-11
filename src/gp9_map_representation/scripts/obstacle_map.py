from __future__ import division
from __future__ import print_function

from copy import copy
from collections import OrderedDict

import numpy as np
import matplotlib.pyplot as plt
import shapely.geometry as sh


class LineBox:

    def __init__(self):
        self.left_point = np.array([])
        self.right_point = np.array([])
        self.extended_left_point = np.array([])
        self.extended_right_point = np.array([])

        self.angle = 0
        self.radius = 0

        self.ordered_vertices = []

    def construct_box(self, start_point, end_point, radius):
        self.radius = radius
        self._get_left_and_right(start_point, end_point)
        self._get_angle()
        self._get_extended_points()
        self._get_ordered_vertices()

    def plot_box(self, axis_size=[-0.5, 3, -0.5, 3]):

        plt.plot([self.left_point[0], self.right_point[0]], [self.left_point[1], self.right_point[1]], 'r')

        for i in range(4):
            first_point = self.ordered_vertices[i]
            second_point = self.ordered_vertices[(i + 1) % 4]
            plt.plot([first_point[0], second_point[0]],
                     [first_point[1], second_point[1]],
                     'b')

        plt.axis('equal')
        plt.axis(axis_size)
        plt.show()

    def _get_left_and_right(self, start_point, end_point):
        self.left_point = start_point if start_point[0] < end_point[0] else end_point
        self.right_point = start_point if (self.left_point == end_point).all() else end_point

    def _get_angle(self):
        if self.left_point[0] == self.right_point[0]:  # if x-coord of left and right points are equal, the angle is 90!
            if self.left_point[1] > self.right_point[1]:  # if left is above, angle is -90
                self.angle = -np.pi / 2
            else:  # if left is below, angle is 90
                self.angle = np.pi / 2
        else:
            dx = (self.right_point - self.left_point)[0]
            dy = (self.right_point - self.left_point)[1]
            self.angle = np.arctan(dy / dx)

    def _get_extended_points(self):
        self.extended_left_point = self.left_point - self.radius * np.array([np.cos(self.angle), np.sin(self.angle)])
        self.extended_right_point = self.right_point + self.radius * np.array([np.cos(self.angle), np.sin(self.angle)])

    def _get_ordered_vertices(self):

        normal_angle = np.pi / 2 + self.angle
        normal_vector = np.array([np.cos(normal_angle), np.sin(normal_angle)])
        first_vertex = self.extended_left_point + self.radius * normal_vector
        second_vertex = self.extended_left_point - self.radius * normal_vector
        third_vertex = self.extended_right_point - self.radius * normal_vector
        fourth_vertex = self.extended_right_point + self.radius * normal_vector

        self.ordered_vertices = [first_vertex, second_vertex, third_vertex, fourth_vertex]


class ObstacleMap:

    def __init__(self, radius):
        self.radius = radius
        self.number_of_boxes = 0
        self.polygons = []
        self.obstacles = []

    def construct_obstacle_map(self, path_to_maze):
        self._create_polygons(path_to_maze)
        self._create_obstacles()

    def plot_map(self, axis_size=[-0.5, 3, -0.5, 3]):
        for obstacle in self.obstacles:
            self.plot_polygon(obstacle)

        plt.axis('equal')
        plt.axis(axis_size)
        plt.show()

    def _create_polygons(self, path_to_maze):
        with open(path_to_maze) as f:
            for line in f:
                point_list = line.split()
                start_point = np.array(point_list[0:2], dtype=float)
                end_point = np.array(point_list[2:4], dtype=float)
                lb = LineBox()
                lb.construct_box(start_point, end_point, self.radius)
                self.polygons.append(sh.Polygon(lb.ordered_vertices))

            self.number_of_boxes = len(self.polygons)

    def _create_obstacles(self):

        obstacle_list = copy(self.polygons)
        while len(obstacle_list) > 1:

            box_counter = 1
            primary_box = obstacle_list[0]

            merged_boxes = False
            for secondary_box in obstacle_list[1:]:

                merged_box, is_merged = self.merge_obstacles(primary_box, secondary_box)

                if is_merged:
                    obstacle_list.append(merged_box)
                    obstacle_list.remove(primary_box)
                    obstacle_list.remove(secondary_box)
                    merged_boxes = True
                    break  # restart from beginning of while loop
                else:
                    box_counter += 1

            if not merged_boxes:
                self.obstacles.append(primary_box)
                obstacle_list.remove(primary_box)

        # Add the last merged box which will be the bounding box of the maze
        # taking item 0 since they are not merged
        if isinstance(merged_box, tuple):
            self.obstacles.append(merged_box[1])
        else:
            self.obstacles.append(merged_box)

    @staticmethod
    def plot_polygon(polygon):

        # todo: Make sure it works for multiple holes

        ordered_vertices = polygon.exterior.coords
        number_of_vertex = len(ordered_vertices)
        for i in range(number_of_vertex):
            first_point = ordered_vertices[i]
            second_point = ordered_vertices[(i + 1) % number_of_vertex]
            plt.plot([first_point[0], second_point[0]],
                     [first_point[1], second_point[1]],
                     'b')

        interiors = polygon.interiors
        has_interior = len(interiors) > 0
        if has_interior:
            holes = [interiors[i] for i in range(len(interiors))]
            for hole in holes:
                inner_vertices = list(hole.coords)
                number_of_vertex = len(inner_vertices)
                for i in range(number_of_vertex):
                    first_point = inner_vertices[i]
                    second_point = inner_vertices[(i + 1) % number_of_vertex]
                    plt.plot([first_point[0], second_point[0]],
                             [first_point[1], second_point[1]],
                             'b')

                #
                # for vertex in inner_vertices:
                #     plt.scatter(vertex[0], vertex[1], c='b')


    @staticmethod
    def merge_obstacles(poly1, poly2):
        """
        Takes sh Polygons as input, outputs a new shapely Polygon if they overlap.
        Otherwise it outputs the two input Polygons
        """

        # debug for boundary box case

        is_merged = True

        try:
            poly3 = poly1.union(poly2)
            coords = list(poly3.exterior.coords)
            coords = list(OrderedDict.fromkeys(coords))
            vertices = copy(coords)

            for i in range(len(coords)):
                first = coords[i]
                second = coords[(i + 1) % len(coords)]
                third = coords[(i + 2) % len(coords)]

                if first[0] == second[0] == third[0]:
                    vertices.remove(second)

                elif first[1] == second[1] == third[1]:
                    vertices.remove(second)

            interiors = poly3.interiors
            has_holes = len(interiors) > 0
            if has_holes:
                # todo: Make sure it works for multiple holes
                holes = [interiors[i] for i in range(len(interiors))]
                return sh.Polygon(vertices, holes), is_merged
            else:
                return sh.Polygon(vertices), is_merged

        except AttributeError:
            is_merged = False
            return (poly1, poly2), is_merged



if __name__ == '__main__':

    r = 0.1

    obstacle_map = ObstacleMap(r)
    obstacle_map.construct_obstacle_map('../maps/maze3.txt')
    obstacle_map.plot_map([-0.5, 3, -0.5, 6])


    a = 0






