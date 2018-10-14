from __future__ import division
from __future__ import print_function

import numpy as np
import matplotlib.pyplot as plt
import shapely.geometry as sh

from obstacle_map import ObstacleMap


class Vertex:

    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __eq__(self, other):
        return True if self.x == other.x and self.y == other.y else False

    def __repr__(self):
        return "(%f, %f)" % (self.x, self.y)


class Edge:

    def __init__(self, start, end):
        self.start = start
        self.end = end
        self.cost = np.sqrt((end.x - start.x) ** 2 + (end.y - start.y) ** 2)

    def __repr__(self):
        return "%s" % self.to_list()

    def plot(self):
        plt.plot([self.start.x, self.end.x], [self.start.y, self.end.y], 'r', alpha=0.2)

    def to_list(self):
        return [(self.start.x, self.start.y), (self.end.x, self.end.y)]


class Graph:

    def __init__(self, obstacles, map_dim):
        self.obstacles = obstacles
        self.visibility_graph = []
        self.vertices = []
        self.edges = []
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
                        self.edges.append(edge)

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

            # todo: Some rounding error here. Otherwise it should work!
            # if edge is going through obstacle and has its endpoints as two vertices of that obstacle

            elif start_tuple in obst.exterior.coords and \
                    end_tuple in obst.exterior.coords and \
                    not sh_edge.touches(obst):
                return True

            # todo: add if edge is one of the vertices of an obstacle and crosses through it: return True

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
                        if self.map_dimensions['min_x'] < x < self.map_dimensions['max_x'] and \
                                self.map_dimensions['min_y'] < y < self.map_dimensions['max_y']:
                            v = Vertex(x, y)
                            if v not in self.vertices:
                                self.vertices.append(v)

            # Adding exterior vertices
            for x, y in obst.exterior.coords:
                if self.map_dimensions['min_x'] < x < self.map_dimensions['max_x'] and \
                        self.map_dimensions['min_y'] < y < self.map_dimensions['max_y']:
                    v = Vertex(x, y)
                    if v not in self.vertices:
                        self.vertices.append(v)

    def _add_vertex(self, v):
        # throw exception if v in obstacles
        # check if already in graph, no duplicates pls
        pass

    def shortest_path(self, vertex1, vertex2):
        self._add_vertex(vertex1)
        self._add_vertex(vertex2)

        # input Dijkstra or A*.


if __name__ == "__main__":

    r = 0.10
    axis = [-0.5, 3, -0.5, 5.5]

    obst_map = ObstacleMap(r)
    obst_map.construct_obstacle_map("../maps/maze3.txt")
    # obstacles = obst_map.obstacles
    # dims = obst_map.map_dimensions

    graph = Graph(obst_map.obstacles, obst_map.map_dimensions)
    graph.build_visibility_graph()
    graph.plot_graph(axis)

    a = 0

