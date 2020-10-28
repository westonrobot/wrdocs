============================
Overview of software Packages
=============================
This segment is an overview of the packages and aims to aid you when navigating through the different packages.

The software pacakges provided by Weston Robots aim to achieve the following:
1. Handle the low level communication between the computer and the embedded controller in the robots
2. Provide and interface between ROS messages and communicating with the robots
3. Occasionally, support for simulations (espescailly in webots) is provided

Package Naming
--------------
* wrp_sdk: This SDK deals with the low level communication between the computer and the robot platofrm via CAN and Serial bus. Currently, this SDK supports the platforms Hunter,Scout and Tracer.

* <platform_name>_base: These SDKs provide the interface between ROS and wrp_sdk. Essentially, these SDKs simplify the creating of a ROS node for the platform that translates ROS messages, such as cmd_vel, into  platform-unique messages to each platform. These SDKs utilise tools from wrp_sdk to convert these platform-unique messaages into CAN or serial Messages. As a user of our SDKs, you will largely only interact with the libraries created in the <platform_name>_base SDKs. 

Example
-------
To give a clearer overview on the purpose of the package, a sample scenario for using these SDKs is described below:

* You are using the scout platform with a LIDAR module attachced to it. 
* You would like to use the ROS navigation stack to control the scout platform in a mapped region using the inputs from the LIDAR module.
* Using the LIDAR's own software package, a LIDAR node in ROS is created the publsihes a /scan data.
* Using the Scout_Base SDK, a node is created that subscribes to /cmd_vel topics and publishes /odom topic. 
* Based on the position which the LIDAR is mounted, a .xacro file for the trasnform between the platform and the LIDAR is created.

With this, ROS navigation stack is able to navigate the robot based on the provided map.

This specific example has been implemented and can be found in TODO: link to scout_nav package