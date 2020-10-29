scout_description package
=========================
This package provides the model of scout robot.

The basic model of the Scout robot can be found in *scout_description/urdf/scout_v2.xacro*. If extensions such as LIDARs,
camera or a frame is added, a new *.xacro* file should be created and the *scout_description/urdf/scout_v2.xacro* shoud be imported into this new *.xacro*.
Refer to 

The *.urdf* files are generated from the *.xacro* file and should not be altered manually.

Launch files
------------
description.launch: runs the tf node to publish transform of the different links


Published Topics
^^^^^^^^^^^^^^^^
* /tf