from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

import argparse
import sys
import time
import cv2 as cv
import numpy as np
import tensorflow as tf
import os

def load_graph(model_file):
    graph = tf.Graph()
    graph_def =  tf.GraphDef()

    with open(model_file, "rb") as f:
        graph_def.ParseFromString(f.read())
    with graph.as_default():
        tf.import_graph_def(graph_def)
    
    return graph

def read_tensor_from_camera(image_reader, input_height=128, input_width=128, input_mean=0, input_std=128):
    input_name = "file_reader"
    output_name = "normalized"

    float_caster = tf.cast(image_reader, tf.float32)
    dims_expander = tf.expand_dims(float_caster, 0);
    resized = tf.image.resize_bilinear(dims_expander, [input_height, input_width])
    normalized = tf.divide(tf.subtract(resized, [input_mean]), [input_std])
    sess = tf.Session()
    result = sess.run(normalized)

    return result

def load_labels(label_file):
    label = []
    proto_as_ascii_lines = tf.gfile.GFile(label_file).readlines()
    for l in proto_as_ascii_lines:
        label.append(l.rstrip())
    return label


