Overview of Robots
In general, most of the robots have an on-board embedded controller that will manage the low level control of individual motors 
to achieve a desired control input (velocity and steering angle/angular velocity).

The desired control input can be sent to the embedded controller in 3 main ways:

1. Remote controller via radio frequency
2. A physical connection via CAN bus
3. A physical connection via Serial bus

Furthermore, the embedded controller is also able to communicate the state of the platform, such as measured velocities, temperature, currents etc, to an external computer via the CAN or Serial bus. 

Overview of software Packages
-----------------------------
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





Further debugging of CAN
*************************
If the CAN communication between the computer andn the platform is still unable to occur, there might be a hardware fault on the robot platform
affecting the CAN communication. The followign websites provide a simple overview on how you could go about debugging the hardware on the robot platform.

https://www.ti.com/lit/an/slyt529/slyt529.pdf?ts=1600396027624&ref_url=https%253A%252F%252Fwww.google.com%252F

https://www.ti.com/lit/an/slyt529/slyt529.pdf?ts=1600396027624&ref_url=https%253A%252F%252Fwww.google.com%252F

https://support.enovationcontrols.com/hc/en-us/articles/360038856494-CAN-BUS-Troubleshooting-Guide-with-Video-

A simple set of instructionss is given below. These instructions assume basic knnowledge on electrical engineering ad circuits. Furthermore, it is assumed that you have read through the links given Above


1. The robot platforms Scout and Hunter do not have termination resistors between the CAN HI and LO terminals. As such:
a. If would discnnect all peripherals from the robot, and measure the resistance betwweenn CAN HI and LO terminals, a reading of about 50 M ohms or even nopenn circuit is expected.
b. The computer connected to the platform should contain a terminationn resistor of 120 ohms. (If the board provided by weston robots is used, a jumper can be used to attach/dettacch the 120 ohm resistor.

2. With the platform switched off, test the connectivity between corresponding pins of the CAN interface. i.e. Test that CAN HI on all CAN interfaces are connected to each other.
If the different ports are not connected, there is likely ann internal wiring issue with the platform

3. With all peripherals plugged in, and
ROS Interface
-------------

The libraries / packages is designed to bridge the communication between the a embedded controller on the mobile platforms 
and a higher level ROS environnement on a computer. 

In summary, the packages written here converts ROS messages to CAN frames / Serial outputs and back.


The conversion from ROS message to CAN frame occurs in two main steps as shown in the flow chart.

.. image:: figures/communication_overview.png
    :width: 400
    :align: center

Moving down the flow chart:

1. The ROS interface will create a node that listens for ROS messages of a specified ROS topic. 

2. The information in the ROS message will be translated into a platform-unique C++ data structure known as a Platform Command. 

3. The Basic Operation package contains the subroutines required to translate these platform into CAN frames. 

4. Furthermore, the package handles the communication of the CAN frame through the CAN bus.

Moving up the flow chart:
1. The Basic Operations Interface will also contain the subroutines required to read the CAN frames and translate them 
into platform-unique Platform Messages. 

2. These messages can then be translated into ROS messages by the ROS interface. 

3. The ROS interface will also handle publishing of these messages to the appropriate ROS topic. 

