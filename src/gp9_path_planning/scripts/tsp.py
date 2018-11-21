from explore import explore
import numpy as np
class Solution:
    def __init__(self,X,start_node):
        self.X = X 
        self.start_node = start_node 
        self.array = [[0]*(2**len(self.X)) for i in range(len(self.X))] 
    def transfer(self,sets):
        su = 0
        for s in sets:
            su = su + 2**s 
        return su

    def tsp(self):
        s = self.start_node
        num = len(self.X)
        cities = range(num) 
        past_sets = [s] 
        cities.pop(cities.index(s)) 
        node = s
        return self.solve(node,cities) 
    def solve(self,node,future_sets):
        if len(future_sets) == 0:
            return self.X[node][self.start_node]
        d = 99999
        distance = []
        for i in range(len(future_sets)):
            s_i = future_sets[i]
            copy = future_sets[:]
            copy.pop(i) 
            distance.append(self.X[node][s_i] + self.solve(s_i,copy))
        d = min(distance)
        next_one = future_sets[distance.index(d)]
        c = self.transfer(future_sets)
        self.array[node][c] = next_one
        return d

def tsp(path_to_map, robot_radius, grid):
    D, A = explore(path_to_map, robot_radius, grid)
    print("CostMatrix: ")
    print(D)
    S = Solution(D,0)
    PathLength = S.tsp()

    print("PathLength: ")
    print(PathLength)
    
    M = S.array
    lists = range(len(S.X))
    start = S.start_node

    ShortestPath = []
    ShortestPath.append(list(A[start]))
    
    while len(lists) > 0:
        lists.pop(lists.index(start))
        m = S.transfer(lists)
        next_node = S.array[start][m]
        # print (start,"--->" ,next_node)
        start = next_node
        ShortestPath.append(list(A[next_node]))

    return np.array(ShortestPath)

if __name__ == '__main__':
    path_to_map = '/home/ras19/catkin_ws/src/gp9_path_planning/maps/maze.txt'
    robot_radius = 0.16
    grid = [2.41, 2.41, 4, 4]
    ShortestPath = tsp(path_to_map, robot_radius, grid)
    print("Shortest Path: ")
    print(ShortestPath)
    np.savetxt('ShortestPath.txt', ShortestPath, fmt='%f')