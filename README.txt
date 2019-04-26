The main script to be run is "project." For this script to work the scripts "drag_coeff" "mass" "missile" 
"read_input" "thrust" and the data file "terrain" must be in the same folder. Project uses these supporter
scripts to calculate thrust values, mass decriments, drag coefficients, and orientation of the missiles. 
The "terrain" data file contains 3D coordinate data that can be used with the function surf() to create
a surface of the terrain the missiles are launched over. Various flight properties about the missiles are
read from a file called "missile_data" and saved to a text file named "report"