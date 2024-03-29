# processing-sketchbook

## [2d Vector Field Visualizer](sketch_2d_vector_field)

The field given by the following gradient function(s) is shown below.

`grad(x) = 0.3*sin(x) + 0.6*sin(0.2*y)`

`grad(y) = -0.4*sin(3*x)`

![Vector Field Screenshot 3](sketch_2d_vector_field/Screenshot_3.png "Vector Field")

The visualizer is animated. At the moment the vectors travel in the direction of the vector and at the speed of the magnitude, or slope, of the field at the current origin of the vector.

A mouse click spawns a number of random vectors around the cursor.

## [fishpond (Simple Physics Engine)](fishpond)

Fish (rectangles) are gravitated towards the cursor by simulating the force of gravity on the Fish. It tracks position, velocity, and acceleration and updates based on time, not framerate.

![fishpond screenshot](fishpond/fishpond.png "fishpond physics")

The velocity (red) and acceleration (green) vectors can also be drawn.

![fishpond vectors screenshot](fishpond/fishpond-vectors.png "fishpond vector screenshot")
