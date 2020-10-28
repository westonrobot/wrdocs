#####################
Scout Base Respositry
#####################
This repositry provides 4 interlinked packages:

#. scout_base: Creates the main node that communicates with the physical scout_platforms.

#. scout_msgs: defines the types of ROS messages used by the ROS node for scout.

#. scout_description: Provides the URDF file that describes the basic robot model of Scout. Launches node that publishes TF .

#. scout_bringup: Provides launch files that encapsulate multi nodes for ease of usage.

******************
scout_base package
******************

Package Summary
===============

The scout_base package provides the implementation of the *scout_base_node*. This nodes acts as the interface between common ROS topics and converts them into CAN messages, using ugv_sdk.

Launch files
============
scout_base.launch: runs the scout_base_nodes as described below.


Subscribed Topics
-----------------
* /cmd_vel
* /scout_light_control

Published Topics
----------------
* /scout_status
* /odom
* /tf

Parameters
----------
* /scout_base_node/base_frame: base_link
* /scout_base_node/odom_frame: odom
* /scout_base_node/odom_topic_name: odom
* /scout_base_node/port_name: can0
* /scout_base_node/simulated_robot: False

*************************
scout_description package
*************************
This package provides the model of scout robot.

The basic model of the Scout robot can be found in *scout_description/urdf/scout_v2.xacro*. If extensions such as LIDARs,
camera or a frame is added, a new *.xacro* file should be created and the *scout_description/urdf/scout_v2.xacro* shoud be imported into this new *.xacro*.
Refer to :ref:`Link title <Custom Development>`.

The *.urdf* files are generated from the *.xacro* file and should not be altered manually.

Launch files
============
description.launch: runs the tf node to publish transform of the different links


Published Topics
----------------
* /tf


******************
scout_msgs package
******************
This package defines the message types for scout_base_node

*********************
scout_bringup package
*********************
This package collates launch files from the *scout_description* package and the *scout_base* package, with specific parameter for ease of use.

Launch files
============
#. scout_minimal_uart.launch: Launches *scout_description*, *scout_base.launch* setting the messages to be communicated to Scout using UART protocol

#. scout_minimal.launch: Launches *scout_description*, *scout_base.launch* setting the messages to be communicated to Scout using CAN protocol

#. scout_teleop_keyboard.launch: Launch teleop a teleop keyboard that publishes cmd_vel topic to control the robot

.. toctree::
   :maxdepth: 1

   /_platforms/wheeled/scout/scout_software_packages/scout_navigation
