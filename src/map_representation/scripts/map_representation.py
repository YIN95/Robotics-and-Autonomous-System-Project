from __future__ import division
from __future__ import print_function

import numpy as np


class Map_representation():

    def __init__(self, sample_factor=10, maze_path=None):
        if maze_path is None:
            self.path_to_maze = '/home/ras19/catkin_ws/src/ras_project/ras_maze/ras_maze_map/maps/lab_maze_2018.txt'
        else:
            self.path_to_maze = maze_path

        self.start_array = np.array([])
        self.end_array = np.array([])
        self.number_of_walls = 0
        self.sample_factor = sample_factor

    def read_maze(self):
        start_array = []
        end_array = []
        with open(self.path_to_maze) as f:
            for line in f:
                x1 = line.split()[0]
                y1 = line.split()[1]
                x2 = line.split()[2]
                y2 = line.split()[3]
                start_point = np.array((x1, y1))
                start_array.append(start_point)
                end_point = np.array((x2, y2))
                end_array.append(end_point)
        self.start_array = np.array(start_array)
        self.end_array = np.array(end_array)
        self.number_of_walls = self.start_array.shape[0]

    def wall_parametrization(self, wall_number, t):

        # todo: debug this function visually. Use matplotlib

        new_point = self.start_array[wall_number, :] + \
                    t * (self.end_array[wall_number, :] - self.start_array[wall_number, :])
        return new_point

    def construct_matrix(self, number_of_cells=100):
        self.read_maze()
        sample_resolution = 1 / (number_of_cells * self.sample_factor)

        # Initialize zero filled matrix with cells. Think about dimensions in x and y.

        for wall_index in range(self.number_of_walls):

            # Put code block below inside fill_matrix method
            for t in range(0, number_of_cells, sample_resolution):
                point = self.wall_parametrization(wall_index, t)


    def fill_matrix(self):
        pass



if __name__ == '__main__':
    map_rep = Map_representation()
    map_rep.construct_matrix()