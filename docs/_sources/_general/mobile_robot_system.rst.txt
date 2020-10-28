General Information
===================

.. toctree::
   :maxdepth: 1
      
In general, most of the robots have an on-board embedded controller that will manage the low level control of individual motors 
to achieve a desired control input (velocity and steering angle/angular velocity).

The desired control input can be sent to the embedded controller in 3 main ways:

1. Remote controller via radio frequency
2. A physical connection via CAN bus
3. A physical connection via Serial bus

Furthermore, the embedded controller is also able to communicate the state of the platform, such as measured velocities, temperature, currents etc, to an external computer via the CAN or Serial bus. 

The software pacakges provided by Weston Robots aim to achieve the following:

1. Handle the low level communication between the computer and the embedded controller in the robots
2. Provide and interface between ROS messages and communicating with the robots
3. Occasionally, support for simulations (espescailly in webots) is provided

Repository Naming
-----------------

* ugv_sdk: This SDK deals with the low level communication between the computer and the robot platofrm via CAN and Serial bus. Currently, this SDK supports the platforms Hunter,Scout and Tracer.

* <platform_name>_base: This repository provides the interface between ROS and UGV_sdk. 

  * This repository is structure based on the standard ROS package sturcture for a robot. 

  * The <platform name>_base package translates ROS messages into C++ data structure. This C++ data structure is then converted to low levle messages by ugv_sdk.


Sample Project Setup
--------------------

To give a clearer overview on the purpose of the packages, a sample scenario for using these SDKs is described below:

* You are using the scout platform with a LIDAR module attachced to it. 
* You would like to use the ROS navigation stack to control the scout platform in a mapped region using the inputs from the LIDAR module.
* Using the LIDAR's own software package, a LIDAR node in ROS is created the publsihes a /scan data.
* Using the Scout_Base SDK, a node is created that subscribes to /cmd_vel topics and publishes /odom topic. 
* Based on the position which the LIDAR is mounted, a .xacro file for the trasnform between the platform and the LIDAR is created.

With this, ROS navigation stack is able to navigate the robot based on the provided map.

This specific example has been implemented and can be found in TODO: link to scout_nav package
