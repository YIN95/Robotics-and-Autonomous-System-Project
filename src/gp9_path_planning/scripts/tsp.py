from explore import explore
import numpy as np
import pdb
import matplotlib.pyplot as plt 
from matplotlib.lines import Line2D


def initpara():
    alpha = 0.98
    t = (1,100)
    markovlen = 1000
 
    return alpha,t,markovlen

def tsp(path_to_map, robot_radius, grid):
    distmat, A = explore(path_to_map, robot_radius, grid)
    print("CostMatrix: ")
    print(distmat)
    num = distmat.shape[0]
    solutionnew = np.arange(num)
 
    solutioncurrent = solutionnew.copy()
    valuecurrent =99000  #np.max
    #print(valuecurrent)
    
    solutionbest = solutionnew.copy()
    valuebest = 99000 #np.max
    
    alpha,t2,markovlen = initpara()
    t = t2[1]
    
    result = [] #
    while t > t2[0]:
        for i in np.arange(markovlen):
    
            if np.random.rand() > 0.5:
                while True:
                    loc1 = np.int(np.ceil(np.random.rand()*(num-1)))
                    loc2 = np.int(np.ceil(np.random.rand()*(num-1)))
                    ## print(loc1,loc2)
                    if loc1 != loc2:
                        break
                solutionnew[loc1],solutionnew[loc2] = solutionnew[loc2],solutionnew[loc1]
            else: 
                while True:
                    loc1 = np.int(np.ceil(np.random.rand()*(num-1)))
                    loc2 = np.int(np.ceil(np.random.rand()*(num-1))) 
                    loc3 = np.int(np.ceil(np.random.rand()*(num-1)))
    
                    if((loc1 != loc2)&(loc2 != loc3)&(loc1 != loc3)):
                        break
    
                if loc1 > loc2:
                    loc1,loc2 = loc2,loc1
                if loc2 > loc3:
                    loc2,loc3 = loc3,loc2
                if loc1 > loc2:
                    loc1,loc2 = loc2,loc1
    
                tmplist = solutionnew[loc1:loc2].copy()
                solutionnew[loc1:loc3-loc2+1+loc1] = solutionnew[loc2:loc3+1].copy()
                solutionnew[loc3-loc2+1+loc1:loc3+1] = tmplist.copy()  
    
            valuenew = 0
            for i in range(num-1):
                valuenew += distmat[solutionnew[i]][solutionnew[i+1]]
            valuenew += distmat[solutionnew[0]][solutionnew[num-1]]
            
            if valuenew<valuecurrent:       
                valuecurrent = valuenew
                solutioncurrent = solutionnew.copy()
    
                if valuenew < valuebest:
                    valuebest = valuenew
                    solutionbest = solutionnew.copy()
            else:
                if np.random.rand() < np.exp(-(valuenew-valuecurrent)/t):
                    valuecurrent = valuenew
                    solutioncurrent = solutionnew.copy()
                else:
                    solutionnew = solutioncurrent.copy()
        print (valuebest)    
        t = alpha*t
        result.append(valuebest)
    print(valuebest)
    ShortestPath = []
    flag = 0
    for index in solutionbest:
        if (flag<1):
            flag = False
            flag += 1
        else:
            ShortestPath.append(list(A[index]))
        
    return A, solutionbest, ShortestPath

def visualize(Index, Path):
    figure, ax = plt.subplots()
    oldIndex = Index[0]
    for index in Index:
        plt.plot(Path[index][0],Path[index][1],marker='*')
        line = [(Path[oldIndex][0], Path[oldIndex][1]), (Path[index][0], Path[index][1])]
        (line_xs, line_ys) = zip(*line)
        # ax.add_line(Line2D(line_xs, line_ys, linewidth=1, color='blue'))
        oldIndex = index
    # plt.show()

if __name__ == '__main__':
    path_to_map = '/home/ras19/catkin_ws/src/gp9_path_planning/maps/updated_maze.txt'
    robot_radius = 0.16
    grid = [2.4, 2.4, 6, 6]
    A, ShortestIndex, ShortestPath = tsp(path_to_map, robot_radius, grid)
    print("shortest path index:")
    print(ShortestIndex)
    print("shortest path:")
    print(ShortestPath)
    np.savetxt('ShortestPath.txt', ShortestPath, fmt='%f')
    # visualize(ShortestIndex, ShortestPath)

    