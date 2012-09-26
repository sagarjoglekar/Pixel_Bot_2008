The main function of the code is testseg.m

The automated task is to put balls which are segregated on the basis of colors into corresponding holes by a navigator
using only image streamed from an overhead camera.

1>getplanes : Seperates The color planes and finds holes and balls out of the planes.
2>Botprop : Extracts properties of the navigator like centroid (position) and Orientation angle.
3>orient : Orients the navigator to the ball/pit based on repetetive correction.
4>Evalhead : Makes a check for head first approach.. if not then guides the navigator for 180 degree turn.
5>getball: Performs tasks for approaching the ball and acquiring it.
6>capproc: Makes procedural calls for all the activities.
7>Mindist : Finds optimum target to approach.
8>Finddist :calculates distances between two objects.
9>Angeva :Calculates angle of rotation for exact orientation using a self deviced logic.
10>Macro : Resolution  down conversion.

All these functions are recursively called in a infinite loop.