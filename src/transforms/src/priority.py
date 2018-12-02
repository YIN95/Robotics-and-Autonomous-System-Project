import numpy as np

origin_objects = np.loadtxt("objposition.txt", dtype='float')
print(origin_objects)
obj_num, _ = origin_objects.shape
print(obj_num)
pri_list = []
for i in range(obj_num):
    dis = origin_objects[i][0]*origin_objects[i][0] + origin_objects[i][1]*origin_objects[i][1]
    pri_list.append(dis)
print(pri_list)

pri_value = np.argsort(np.array(pri_list))
print(pri_value)
# new = np.argsort(origin_objects, axis=0)
# print(new)

new_objects = np.zeros(origin_objects.shape)
index = 0
for i in(pri_value):
    new_objects[index, :] = origin_objects[i, :]
    index += 1

print(new_objects)
np.savetxt('objposition.txt', new_objects,fmt='%f')