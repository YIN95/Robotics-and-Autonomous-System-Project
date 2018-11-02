##

python -m scripts.retrain --bottleneck_dir=tf_files/bottlenecks --how_many_training_steps=500 --model_dir=tf_files/models/ --summaries_dir=tf_files/training_summaries/"mobilenet_0.50_128" --output_graph=tf_files/retrained_graph.pb --output_labels=tf_files/retrained_labels.txt --architecture="mobilenet_0.50_128" --image_dir=tf_files/data_color 

##

python -m scripts.retrain --bottleneck_dir=tf_files/bottlenecks --how_many_training_steps=500 --model_dir=tf_files/models/ --summaries_dir=tf_files/training_summaries/"mobilenet_0.50_128" --output_graph=tf_files/graph_shape.pb --output_labels=tf_files/labels_shape.txt --architecture="mobilenet_0.50_128" --image_dir=tf_files/data_shape

##

python -m scripts.label_image --graph=tf_files/retrained_graph_color.pb --labels=tf_files/retrained_labels_color.txt --image=tf_files/testdata/4.jpg 

python -m scripts.label_image --graph=tf_files/retrained_graph_shape.pb --labels=tf_files/retrained_labels_shape.txt --image=tf_files/testdata/5.jpg 

## new

python -m scripts.label_image --graph=tf_files/graph_color.pb --labels=tf_files/labels_color.txt --image=tf_files/testdata/4.jpg 

python -m scripts.label_image --graph=tf_files/graph_shape.pb --labels=tf_files/labels_shape.txt --image=tf_files/testdata/4.jpg 