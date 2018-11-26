#!/usr/bin/env python

from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

import roslib
import sys
import rospy
import cv2
import argparse
import numpy as np
import os
import tensorflow as tf
import copy

from std_msgs.msg import String
from sensor_msgs.msg import Image
from cv_bridge import CvBridge, CvBridgeError
from std_msgs.msg import Int32

class TargetClassification:
    
    def __init__(self):
        self.bridge = CvBridge()
        self.sub_detection = rospy.Subscriber("/classification/image", Image, self.subdetectionCallback, queue_size=1)
        #self.pub_detection = rospy.Publisher("/classification/img_subbed",Image)
        self.pub_state = rospy.Publisher("/classification/state", Int32, queue_size=1)
        self.pub_shape = rospy.Publisher("/classification/shape", Int32, queue_size=1)

        ### parapeters ###
        self.model_file = "/home/ras19/catkin_ws/src/gp9_objects_detection/tf_files/graph_shape_new.pb"
        self.label_file = "/home/ras19/catkin_ws/src/gp9_objects_detection/tf_files/labels_shape.txt"
        self.input_height = 128
        self.input_width = 128
        self.input_mean = 128
        self.input_std = 128
        self.input_layer = "input"
        self.output_layer = "final_result"
        self.graph = self.load_graph(self.model_file)
        self.labels = self.load_labels(self.label_file)
        self.input_name = "import/" + self.input_layer
        self.output_name = "import/" + self.output_layer
        self.input_operation = self.graph.get_operation_by_name(self.input_name);
        self.output_operation = self.graph.get_operation_by_name(self.output_name);
        self.classification_result = -1
        self.green = (0, 255, 0)
        self.template = "{} (score={:0.5f})"
        self.count = 1
        self.traget = []
        self.busy = 0

    def load_graph(self, model_file):
        graph = tf.Graph()
        graph_def =  tf.GraphDef()

        with open(model_file, "rb") as f:
            graph_def.ParseFromString(f.read())
        with graph.as_default():
            tf.import_graph_def(graph_def)
        
        return graph

    def load_labels(self, label_file):
        label = []
        proto_as_ascii_lines = tf.gfile.GFile(label_file).readlines()
        for l in proto_as_ascii_lines:
            label.append(l.rstrip())
        return label
    
    def read_tensor_from_camera(self, image_reader, input_height=128, input_width=128, input_mean=0, input_std=128):
        float_caster = tf.cast(image_reader, tf.float32)
        dims_expander = tf.expand_dims(float_caster, 0);
        resized = tf.image.resize_bilinear(dims_expander, [input_height, input_width])
        normalized = tf.divide(tf.subtract(resized, [input_mean]), [input_std])
        sess = tf.Session()
        result = sess.run(normalized)

        return result

    def subdetectionCallback(self, data):
        try:
            self.busy = 1
            self.pub_state.publish(self.busy)
        except Exception, e:
            print(e)

        try:
            target = self.bridge.imgmsg_to_cv2(data, "bgr8")
        except CvBridgeError as e:
            print(e)
        
        image_reader = tf.image.convert_image_dtype(target, dtype=tf.uint8, name='jpeg_reader')
        t = self.read_tensor_from_camera(image_reader)
        
        with tf.Session(graph=self.graph) as sess:
            results = sess.run(self.output_operation.outputs[0],
                               {self.input_operation.outputs[0]: t})

        results = np.squeeze(results)
        top_k = results.argsort()[-5:][::-1]
        
        self.classification_result = top_k[0]
        # cv2.putText(target, self.template.format(self.labels[self.classification_result], results[self.classification_result]), (20, 20), cv2.FONT_HERSHEY_COMPLEX, 0.8, self.green, 1)
        # self.pub_shape.publish(self.classification_result)
        cv2.putText(target, self.labels[self.classification_result], (10, 25), cv2.FONT_HERSHEY_COMPLEX, 1, (255, 0, 255), 2)
        rospy.loginfo("index: %d",self.classification_result)
        rospy.loginfo("index: %f",results[self.classification_result])
        cv2.imshow("target-sub", target)
        cv2.waitKey(3)
        try:
            self.busy = 0
            if ((self.classification_result == 5) and (results[self.classification_result] > 0.50)):
                self.pub_shape.publish(self.classification_result)
            
            elif (results[self.classification_result] > 0.58):
                self.pub_shape.publish(self.classification_result)
            else:
                self.pub_shape.publish(99)
            self.pub_state.publish(self.busy)
        except Exception, e:
            print(e)
        # try:
        #     self.pub_detection.publish(self.bridge.cv2_to_imgmsg(target, "bgr8"))
        # except CvBridgeError as e:
        #     print(e)

def main(args):
    
    
    tc = TargetClassification()
    rospy.init_node('target_classification', anonymous=True)
    rate = rospy.Rate(0.5)
    while not rospy.is_shutdown():
        rate.sleep()

    # try:
    #     rospy.spin()
    # except KeyboardInterrupt:
    #     print("Shutting down")


  
if __name__ == '__main__':
    main(sys.argv)
