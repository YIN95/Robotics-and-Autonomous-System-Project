from __future__ import division
from __future__ import print_function

import rospy
from nav_msgs.msg import OccupancyGrid
from nav_msgs.msg import MapMetaData

import numpy as np
import matplotlib.pyplot as plt


class MapRepresentation:

    def __init__(self, sample_factor=100, maze_path=None):
        if maze_path is None:
            #self.path_to_maze = '/home/ras19/catkin_ws/src/ras_project/ras_maze/ras_maze_map/maps/lab_maze_2018.txt'
            self.path_to_maze = 'maze.txt'
        else:
            self.path_to_maze = maze_path

        self.grid_matrix = np.array([])
        self.occupancy_grid = np.array([])

        self.start_array = np.array([])
        self.end_array = np.array([])
        self.number_of_walls = 0
        self.sample_factor = sample_factor
        self.cell_size = 0

        # Maximum dimensions of maze
        self.max_x = 0
        self.max_y = 0

        self.largest_dimension = ''
        self.smallest_dimension = ''

    def visualize_walls(self):

        for wall_index in range(self.number_of_walls):
            start = self.start_array[wall_index, :] # x, y
            end = self.end_array[wall_index, :]
            plt.plot([start[0], end[0]], [start[1], end[1]], 'r-')

        plt.show()

    def construct_representation(self, number_of_cells_in_smallest_dim=100):
        self._read_maze()
        self._initialize_matrix(number_of_cells_in_smallest_dim)
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

    def _initialize_matrix(self, smallest_dim_num_cells):
        largest_dim_number_of_cells, smallest_dim_number_of_cells = \
            self._calculate_number_of_cells(smallest_dim_num_cells)

        if self.largest_dimension == 'x':
            self.grid_matrix = np.zeros((largest_dim_number_of_cells, smallest_dim_number_of_cells))
        else:  # largest dimension is y
            self.grid_matrix = np.zeros((smallest_dim_number_of_cells, largest_dim_number_of_cells))

    def _calculate_number_of_cells(self, smallest_dim_number_of_cells):

        max_list = [self.max_x, self.max_y]
        largest_dim_value = np.max(max_list)
        largest_index = np.argmax(max_list) # if 0: largest in x. Else: largest in y
        smallest_dim_value = max_list[1 - largest_index]
        factor = largest_dim_value / smallest_dim_value
        largest_dim_number_of_cells = factor * smallest_dim_number_of_cells

        self.largest_dimension = 'x' if largest_index == 0 else 'y'
        self.smallest_dimension = 'x' if largest_index == 1 else 'y'

        self.cell_size = smallest_dim_value / smallest_dim_number_of_cells

        # floor number of cells so they cover the whole space
        largest_dim_number_of_cells = int(np.ceil(largest_dim_number_of_cells))
        smallest_dim_number_of_cells = int(np.ceil(smallest_dim_number_of_cells))

        return largest_dim_number_of_cells, smallest_dim_number_of_cells

    def _fill_matrix_with_walls(self):
        for wall_index in range(self.number_of_walls):
            self.fill_matrix_with_wall(wall_index)

    def _fill_matrix_with_wall(self, wall_index):
        sample_resolution = self.cell_size / self.sample_factor
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
        self.occupancy_grid = self.grid_matrix.ravel().astype(np.int8)


if __name__ == '__main__':
    pub = rospy.Publisher('/maprepr', OccupancyGrid, 1)
    rospy.init_node('occupancy_publisher')
    rate = rospy.Rate(1)  # 10hz

    number_of_cells_in_smallest_dimension = 100

    map_repr = MapRepresentation()
    map_repr.construct_representation(number_of_cells_in_smallest_dimension)

    # Constructing occupancy message
    occupancy_info = MapMetaData()
    occupancy_info.time = rospy.get_time()
    occupancy_info.width = map_repr.grid_matrix.shape[0]
    occupancy_info.height = map_repr.grid_matrix.shape[1]

    occupancy_msg = OccupancyGrid()
    occupancy_msg.data = map_repr.occupancy_grid
    occupancy_msg.info = occupancy_info

    while not rospy.is_shutdown():
        pub.publish(occupancy_msg)
        rate.sleep()
