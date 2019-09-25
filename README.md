# processing-sketchbook

## [2d Vector Field Visualizer](sketch_2d_vector_field/sketch_2d_vector_field.pde)

The field given by the following gradient function(s) is shown below.

`grad(x) = 0.3*sin(x) + 0.6*sin(0.2*y)`

`grad(y) = -0.4*sin(3*x)`

![Vector Field Screenshot 3](sketch_2d_vector_field/Screenshot_3.png "Vector Field")

The visualizer is animated. At the moment the vectors travel in the direction of the vector and at the speed of the magnitude, or slope, of the field at the current origin of the vector.

A mouse click spawns a number of random vectors around the cursor.