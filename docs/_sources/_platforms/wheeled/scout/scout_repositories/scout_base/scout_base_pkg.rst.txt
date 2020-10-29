scout_base package
==================

Package Summary
---------------

The scout_base package provides the implementation of the *scout_base_node*. This nodes acts as the interface between common ROS topics and converts them into CAN messages, using ugv_sdk.

Launch files
^^^^^^^^^^^^
scout_base.launch: runs the scout_base_nodes as described below.


Subscribed Topics
^^^^^^^^^^^^^^^^^
* /cmd_vel
* /scout_light_control

Published Topics
^^^^^^^^^^^^^^^^
* /scout_status
* /odom
* /tf

Parameters
^^^^^^^^^^
* /scout_base_node/base_frame: base_link
* /scout_base_node/odom_frame: odom
* /scout_base_node/odom_topic_name: odom
* /scout_base_node/port_name: can0
* /scout_base_node/simulated_robot: False