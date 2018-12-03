#!/usr/bin/env python

from __future__ import division
from __future__ import print_function

from copy import deepcopy
from collections import defaultdict

import numpy as np
import matplotlib.pyplot as plt
import shapely.geometry as sh
import shapely.ops as ops

from obstacle_map import ObstacleMap


class Vertex:

    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __eq__(self, other):
        return True if self.x == other.x and self.y == other.y else False

    def __repr__(self):
        return "(%f, %f)" % (self.x, self.y)

    def __add__(self, other):
        return Vertex(self.x + other.x, self.y + other.y)

    def __sub__(self, other):
        return Vertex(self.x - other.x, self.y - other.y)

    def norm(self):
        return np.sqrt(self.x**2 + self.y**2)

    def mult(self, t):
        return Vertex(t * self.x, t * self.y)

    def __hash__(self):
        return hash(self.x) ^ hash(self.y) ^ hash((self.x, self.y))

    def distance(self, other):
        return np.sqrt((other.x - self.x) ** 2 + (other.y - self.y) ** 2)


class Edge:

    def __init__(self, start, end):
        self.start = start
        self.end = end
        self.cost = start.distance(end)

    def __eq__(self, other):
        if self.start == other.start and self.end == other.end:
            return True
        elif self.start == other.end and self.end == other.start:
            return True
        else:
            return False

    def __hash__(self):
        return hash(self.start) ^ hash(self.end)

    def __repr__(self):
        return "%s" % self.to_list()

    def plot(self):
        plt.plot([self.start.x, self.end.x], [self.start.y, self.end.y], 'r', alpha=0.1)

    def to_list(self):
        return [(self.start.x, self.start.y), (self.end.x, self.end.y)]


class Graph:

    def __init__(self, obstacles, map_dim, robot_radius):
        self.robot_radius = robot_radius
        self.obstacles = obstacles
        self.visibility_graph = defaultdict(set)
        self.vertices = list()
        self.edges = set()
        self.map_dimensions = map_dim

    def __len__(self):
        return len(self.vertices)

    def build_visibility_graph(self):
        self._get_vertices()
        for i, vertex1 in enumerate(self.vertices):
            for vertex2 in self.vertices[i:]:
                if not vertex1 == vertex2:
                    edge = Edge(vertex1, vertex2)
                    if not self._intersects_obstacle(edge):
                        self._add_visible_edge(edge)

    def plot_graph(self, axis_size=[-0.5, 3, -0.5, 3]):
        for obst in self.obstacles:
            ObstacleMap.plot_polygon(obst)

        for edge in self.edges:
            edge.plot()

        plt.axis('equal')
        plt.axis(axis_size)
        plt.show()

    def _intersects_obstacle(self, edge):
        start_tuple = (edge.start.x, edge.start.y)
        end_tuple = (edge.end.x, edge.end.y)
        sh_edge = sh.LineString(edge.to_list())
        for obst in self.obstacles:
            if sh_edge.crosses(obst):
                return True

            # if edge is going through obstacle and has its endpoints as two vertices of that obstacle
            elif start_tuple in obst.exterior.coords and \
                    end_tuple in obst.exterior.coords and \
                    not sh_edge.touches(obst):
                return True

            # Interior check!
            interiors = obst.interiors
            has_interior = len(interiors) > 0
            if has_interior:
                holes = [interiors[i] for i in range(len(interiors))]
                for hole in holes:
                    inner_vertices = list(hole.coords)
                    if start_tuple in inner_vertices and \
                            end_tuple in inner_vertices and \
                            not sh_edge.touches(obst):
                        return True

                    # Check if edge goes between two different holes
                    elif (start_tuple in inner_vertices) != (end_tuple in inner_vertices) and \
                            not sh_edge.touches(obst):
                        return True

        return False

    def _get_vertices(self):
        for obst in self.obstacles:

            # Adding interior vertices, excluding those outside of bounding walls
            interiors = obst.interiors
            has_interior = len(interiors) > 0
            if has_interior:
                holes = [interiors[i] for i in range(len(interiors))]
                for hole in holes:
                    inner_vertices = list(hole.coords)
                    for x, y in inner_vertices:
                        v = Vertex(x, y)
                        if self._is_within_bounding_walls(v):
                            if v not in self.vertices:
                                self.vertices.append(v)

            # Adding exterior vertices
            for x, y in obst.exterior.coords:
                v = Vertex(x, y)
                if self._is_within_bounding_walls(v):
                    if v not in self.vertices:
                        self.vertices.append(v)

    def _is_within_bounding_walls(self, vertex):
        return self.map_dimensions['min_x'] < vertex.x < self.map_dimensions['max_x'] and \
               self.map_dimensions['min_y'] < vertex.y < self.map_dimensions['max_y']

    def _is_on_bounding_walls(self, vertex):
        return self.map_dimensions['min_x'] == vertex.x or vertex.x == self.map_dimensions['max_x'] or \
               self.map_dimensions['min_y'] == vertex.y or vertex.y == self.map_dimensions['max_y']

    def _add_new_vertex(self, v):

        if v in self.vertices:
            return

        p = sh.Point(v.x, v.y)
        within_bounds = self._is_within_bounding_walls(v)
        on_bounds = self._is_on_bounding_walls(v)
        print(v)
        if within_bounds:
            print("within bounds")
            for obst in self.obstacles:
                if obst.contains(p):
                    print("before shifting point %s" % v)
                    v = self._shift_point_outside_of_obstacle(p, obst)
                    p = sh.Point(v.x, v.y)
                    print("after shifting point %s" % v)

        else: # outside of bounds
            print("outside of bounds")
            for obst in self.obstacles:
                origin = sh.Point(self.map_dimensions['min_x'], self.map_dimensions['min_y'])
                if obst.contains(origin):
                    print("before shifting point %s" % v)
                    v = self._shift_point_inside_the_maze(p, obst)
                    p = sh.Point(v.x, v.y)
                    print("after shifting point %s" % v)
                    break

        self.vertices.append(v)
        for vertex in self.vertices[:-1]:
            edge = Edge(v, vertex)
            if not self._intersects_obstacle(edge):
                self._add_visible_edge(edge)

        return v

    def _shift_point_outside_of_obstacle(self, point, obst):
        nearest = ops.nearest_points(point, obst.boundary)[1]

        point = Vertex(point.x, point.y)
        nearest = Vertex(nearest.x, nearest.y)
        unit_vector = (nearest - point).mult(1 / (point - nearest).norm())

        shifted_point = nearest + unit_vector.mult(0.01)

        return shifted_point


    def _shift_point_inside_the_maze(self, point, bounding_obst):
        nearest = ops.nearest_points(point, list(bounding_obst.boundary)[1])[1]

        point = Vertex(point.x, point.y)
        nearest = Vertex(nearest.x, nearest.y)
        print("point: %s" % point)
        print("nearest: %s" % nearest)
        unit_vector = (nearest - point).mult(1 / (point - nearest).norm())

        shifted_point = nearest + unit_vector.mult(0.01)
        print("shifted_point: %s" % shifted_point)
        print("=========================")
        return shifted_point

    def _add_visible_edge(self, e):
        self.visibility_graph[e.start].add(e.end)
        self.visibility_graph[e.end].add(e.start)
        self.edges.add(e)

    def _dijkstra(self, start, goal):

        # Creating a temporary graph to not store all start and goal positions
        temp_graph = deepcopy(self)
        start = temp_graph._add_new_vertex(start)
        goal = temp_graph._add_new_vertex(goal)

        unvisited = set()
        distances = {}
        previous = {}

        for v in temp_graph.vertices:
            distances[v] = np.inf
            previous[v] = None
            unvisited.add(v)

        distances[start] = 0

        while len(unvisited) > 0:

            # vertex = min(distances, key=distances.get)  # vertex with smallest distance
            vertex = temp_graph._get_unvisited_vertex_with_smallest_distance(unvisited, distances)
            unvisited.remove(vertex)
            if vertex == goal:
                break

            neighbor_vertices = temp_graph.visibility_graph[vertex]
            for neighbor in neighbor_vertices:
                new_distance = distances[vertex] + vertex.distance(neighbor)
                if new_distance < distances[neighbor]:
                    distances[neighbor] = new_distance
                    previous[neighbor] = vertex

        return previous, start, goal

    @staticmethod
    def _get_unvisited_vertex_with_smallest_distance(unvisited, distances):
        smallest_distance = np.inf
        best_vertex = None
        for vertex in unvisited:
            distance = distances[vertex]
            if distance < smallest_distance:
                smallest_distance = distance
                best_vertex = vertex

        return best_vertex

    def shortest_path(self, start, goal):

        previous, start, goal = self._dijkstra(start, goal)
        vertex = goal
        path = []
        if previous[goal] is not None or start == goal:
            while vertex is not None:
                path.append(vertex)
                vertex = previous[vertex]

        path.reverse()

        return path

    def plot_path(self, path, axis_size=[-0.5, 3, -0.5, 3]):

        plt.plot(path[0].x, path[0].y, 'bo', label='start')
        plt.plot(path[-1].x, path[-1].y, 'go', label='goal')

        for i in range(len(path) - 1):
            from_ = path[i]
            to = path[i + 1]
            plt.plot([from_.x, to.x], [from_.y, to.y], 'g')

        plt.legend()
        self.plot_graph(axis_size=axis_size)
        plt.show()
