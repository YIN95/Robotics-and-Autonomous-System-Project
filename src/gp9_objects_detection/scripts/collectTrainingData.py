import numpy as np
import cv2
import datetime
import os
global path
global label
global img

def get_img_path(path):
    img_paths = []
    for maindir, subdir, filenames in os.walk(path):
        for filename in filenames:
            img_paths.append(os.path.join(path,filename))
    return img_paths


def collect(x, y, path, label, img):
    nums = len(get_img_path(path))
    time = str(datetime.datetime.now())
    imgname = label + str(nums) + '_' + time[len(time)-6:-1] + ".jpg"
    cv2.imwrite(os.path.join(path, imgname), img)

def OnMouseAction(event, x, y, flags, param):
    global path
    global label
    size = 128
    if event == cv2.EVENT_LBUTTONDOWN:
        print x
        print y
        print path
        print label
        if ((x-64) < 0):
            x = 64
        if ((y-64) < 0):
            y = 64
        if ((x+64) > 640):
            x = 640-64
        if ((y+64) > 480):
            y = 480-64
        image = img[y-64:y+64, x-64:x+64, :]
        
        collect(x, y, path, label, image)

######################################

def main():
    global path
    global label
    global img

    cap = cv2.VideoCapture(0)
    cap.set(3, 640)
    cap.set(4, 480)
    cv2.namedWindow('frame')
    cv2.setMouseCallback('frame', OnMouseAction)

    path = '/home/ras19/Data/1'
    label = 'ball'
    path_ball = '/home/ras19/Data/1'
    path_cube = '/home/ras19/Data/2'
    path_cylinder = '/home/ras19/Data/3'
    path_cross = '/home/ras19/Data/4'
    path_triangle = '/home/ras19/Data/5'
    path_star = '/home/ras19/Data/6'
    path_others = '/home/ras19/Data/0'

    label_ball = 'ball'
    label_cube = 'cube'
    label_cylinder = 'cylinder'
    label_cross = 'cross'
    label_triangle = 'triangle'
    label_star = 'star'
    label_others = 'others'

    while(cap.isOpened()):
        ret, frame = cap.read()
        img = frame
        if ret==True:
            cv2.imshow('frame',frame)
            key = cv2.waitKey(1)
            if key & 0xFF == ord('q'):
                break
            elif key & 0xFF == ord('1'):
                path = path_ball
                label = label_ball
            elif key & 0xFF == ord('2'):
                path = path_cube
                label = label_cube
            elif key & 0xFF == ord('3'):
                path = path_cylinder
                label = label_cylinder
            elif key & 0xFF == ord('4'):
                path = path_cross
                label = label_cross
            elif key & 0xFF == ord('5'):
                path = path_triangle
                label = label_triangle
            elif key & 0xFF == ord('6'):
                path = path_star
                label = label_star
            elif key & 0xFF == ord('0'):
                path = path_others
                label = label_others
                
        

        else:
            break

    # Release everything if job is finished
    cap.release()
    cv2.destroyAllWindows() 

if __name__ == "__main__":
    main()
