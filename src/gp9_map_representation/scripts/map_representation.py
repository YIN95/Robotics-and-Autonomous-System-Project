#!/usr/bin/env python

from __future__ import division
from __future__ import print_function

import rospy
from nav_msgs.msg import OccupancyGrid
from nav_msgs.msg import MapMetaData

import numpy as np

class MapRepresentation:

    def __init__(self, cell_size, maze_path=None):
        if maze_path is None:
            self.path_to_maze = '/home/ras19/catkin_ws/src/ras_project/ras_maze/ras_maze_map/maps/lab_maze_2018.txt'
        else:
            self.path_to_maze = maze_path

        self.grid_matrix = np.array([])
        self.occupancy_grid = np.array([])

        self.start_array = np.array([])
        self.end_array = np.array([])
        self.number_of_walls = 0
        self.cell_size = cell_size

        # Maximum dimensions of maze
        self.max_x = 0
        self.max_y = 0

        self.largest_dimension = ''
        self.smallest_dimension = ''

    def construct_representation(self):
        self._read_maze()
        self._initialize_matrix()
        self._fill_matrix_with_walls()
        self._create_occupancy_grid()

    def _read_maze(self):
        start_array = []
        end_array = []
        with open(self.path_to_maze) as f:
            for line in f:
                point_list = line.split()
                start_point = point_list[0:2]
                end_point = point_list[2:4]
                start_array.append(start_point)
                end_array.append(end_point)
        # Convert to floats, they come as strings!
        self.start_array = np.array(start_array, dtype=float)
        self.end_array = np.array(end_array, dtype=float)
        self.max_x = self.end_array[:, 0].max(0)
        self.max_y = self.end_array[:, 1].max(0)
        self.number_of_walls = self.start_array.shape[0]

    def _initialize_matrix(self):
        largest_dim_number_of_cells, smallest_dim_number_of_cells = self._calculate_number_of_cells()

        if self.largest_dimension == 'x':
            self.grid_matrix = np.zeros((largest_dim_number_of_cells, smallest_dim_number_of_cells))
        else:  # largest dimension is y
            self.grid_matrix = np.zeros((smallest_dim_number_of_cells, largest_dim_number_of_cells))

    def _calculate_number_of_cells(self):

        max_list = [self.max_x, self.max_y]
        largest_dim_value = np.max(max_list)
        largest_index = np.argmax(max_list) # if 0: largest in x. Else: largest in y
        smallest_dim_value = max_list[1 - largest_index]
        smallest_dim_number_of_cells = smallest_dim_value / self.cell_size

        factor = largest_dim_value / smallest_dim_value
        largest_dim_number_of_cells = factor * smallest_dim_number_of_cells

        self.largest_dimension = 'x' if largest_index == 0 else 'y'
        self.smallest_dimension = 'x' if largest_index == 1 else 'y'

        # floor number of cells so they cover the whole space
        largest_dim_number_of_cells = int(np.ceil(largest_dim_number_of_cells))
        smallest_dim_number_of_cells = int(np.ceil(smallest_dim_number_of_cells))

        return largest_dim_number_of_cells, smallest_dim_number_of_cells

    def _fill_matrix_with_walls(self):
        for wall_index in range(self.number_of_walls):
            self._fill_matrix_with_wall(wall_index)

    def _fill_matrix_with_wall(self, wall_index):
        sample_factor = 100  # sample this number of points for each cellwidth to color the cells
        sample_resolution = self.cell_size / sample_factor
        for t in np.arange(0 + sample_resolution, 1, sample_resolution):
            point = self._wall_parametrization(wall_index, t)
            self._color_cell_with_point_inside(point)

    def _wall_parametrization(self, wall_number, t):
        new_point = self.start_array[wall_number, :] + \
                    t * (self.end_array[wall_number, :] - self.start_array[wall_number, :])
        return new_point

    def _color_cell_with_point_inside(self, point):
        x_index, y_index = np.floor(point / self.cell_size).astype(int)
        self.grid_matrix[x_index, y_index] = 100

    def _create_occupancy_grid(self):
        self.occupancy_grid = self.grid_matrix.flatten('F').astype(np.int8)


if __name__ == '__main__':
    rospy.init_node('occupancy_publisher')
    pub = rospy.Publisher('/maprepr', OccupancyGrid, queue_size=1)
    rate = rospy.Rate(1)

    cell_size = 0.10  # in meters
    map_repr = MapRepresentation(cell_size)
    map_repr.construct_representation()

    # Constructing occupancy message
    occupancy_info = MapMetaData()
    #occupancy_info.map_load_time = rospy.get_time()  # not working with this line
    occupancy_info.width = map_repr.grid_matrix.shape[0]
    occupancy_info.height = map_repr.grid_matrix.shape[1]
    occupancy_info.resolution = map_repr.cell_size

    occupancy_msg = OccupancyGrid()
    occupancy_msg.data = map_repr.occupancy_grid
    occupancy_msg.info = occupancy_info

    pub.publish(occupancy_msg)

    while not rospy.is_shutdown():
        pub.publish(occupancy_msg)
        rate.sleep()
    