#!/usr/bin/env python

from __future__ import print_function

import roslib
#roslib.load_manifest('my_package')
import sys
import rospy
import cv2
from std_msgs.msg import String
from sensor_msgs.msg import Image
from cv_bridge import CvBridge, CvBridgeError

class TargetClassification:
    
    def __init__(self):
        self.bridge = CvBridge()
        self.sub_detection = rospy.Subscriber("/classification/image", Image, self.subdetectionCallback)
        #self.pub_detection = rospy.Publisher("/classification/img_subbed",Image)

    def subdetectionCallback(self, data):
        try:
            target = self.bridge.imgmsg_to_cv2(data, "bgr8")
        except CvBridgeError as e:
            print(e)
        
        cv2.imshow("target-sub", target)
        cv2.waitKey(3)

        # try:
        #     self.pub_detection.publish(self.bridge.cv2_to_imgmsg(target, "bgr8"))
        # except CvBridgeError as e:
        #     print(e)

def main(args):
    tc = TargetClassification()
    rospy.init_node('target_classification', anonymous=True)
    try:
        rospy.spin()
    except KeyboardInterrupt:
        print("Shutting down")

if __name__ == '__main__':
    main(sys.argv)