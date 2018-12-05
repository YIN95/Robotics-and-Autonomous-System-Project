import numpy as np
import matplotlib.pyplot as plt
import itertools
from obstacle_map import ObstacleMap
import shapely.geometry as sh
from visibility_graph import Vertex, Graph


def initGrid(grid):
    width = grid[0]
    height = grid[1]
    numWidth = grid[2]
    numHeight = grid[3]
    exploreArray = []
    wList = np.linspace(0.225, width, num=numWidth)
    hList = np.linspace(0.225, height, num=numHeight)
    for s in itertools.product(wList,hList):
        exploreArray.append(s)

    return np.array(exploreArray)


def build_graph(path_to_map, robot_radius):
    obst_map = ObstacleMap(robot_radius)
    obst_map.construct_obstacle_map(path_to_map)
    graph = Graph(obst_map.obstacles, obst_map.map_dimensions, robot_radius)
    graph.build_visibility_graph()
    return graph


def inObstacle(point, map):
    p = sh.Point(point[0], point[1])
    in_obst = False
    for obst in map.obstacles:
        if obst.contains(p):
            in_obst = True

    return in_obst

    
def removePointsInObstacle(exploreArray, map, plot=False):
    newexploreArray = []
    for p in exploreArray:
        if plot:
            plt.plot(p[0], p[1], 'ro')
            for obst in map.obstacles:
                ObstacleMap.plot_polygon(obst)
            plt.show()
        isInObstacle = inObstacle(p, map)
        if not isInObstacle:
            newexploreArray.append(list(p))
    return np.array(newexploreArray)


def costOfPath(path):
    cost = 0
    for i in range(len(path) - 1):
        cost += path[i].distance(path[i + 1])
    return cost


def createCostMatrix(exploreArray, map):

    vertices = [Vertex(point[0], point[1]) for point in exploreArray]
    numVertices = len(vertices)
    costMatrix = np.zeros((numVertices, numVertices))

    for i, v1 in enumerate(vertices):
        for j, v2 in enumerate(vertices):
            if not v1 == v2:
                # start and end included!
                shortest_path = map.shortest_path(v1, v2)
                cost = costOfPath(shortest_path)
                costMatrix[i, j] = cost

    return costMatrix

def explore(path_to_map, robot_radius, grid):
    
    
    mapGraph = build_graph(path_to_map, robot_radius)
    exploreArray = initGrid(grid)
    newexploreArray = removePointsInObstacle(exploreArray, mapGraph)
    costMatrix = createCostMatrix(newexploreArray, mapGraph)

    return costMatrix, newexploreArray