Mobile Robot System
===================
This page is meant to give a brief overview of the platforms used in Weston Robot and the packages developed by Weston Robots

.. contents::
   :depth: 2
   :local:



System Structure
----------------

In general, most of the robots have an on-board embedded controller that will manage the low level control of individual motors 
to achieve a desired control input (velocity and steering angle/angular velocity).

The desired control input can be sent to the embedded controller in 3 main ways:

1. Remote controller via radio frequency
2. A physical connection via CAN bus
3. A physical connection via Serial bus

Furthermore, the embedded controller is also able to communicate the state of the platform to an external computer via the CAN or Serial bus. 
For most platforms, the On-board embedded controller send back messages on state of the platform, 
such as measured velocities, temperature, currents etc. 


Hardware Interface
------------------

CAN/Serial interface
^^^^^^^^^^^^^^^^^^^^

Information on CAN bus can be found in https://www.youtube.com/watch?v=FqLDpHsxvf8 and https://en.wikipedia.org/wiki/CAN_bus.

Many protocols for communication through the CAN bus is similar for different platforms. 
As such, a abstract class `MobileBase` was designed as the super class of the CAN interface class for each robot model.

On the level of `MobileBase` the following is settled:

1. Setting up CAN connection
2. Disconnecting CAN connection 
3. Maintaining stream of CAN Frames

Setting up CAN connection
*************************

During the setting up of CAN connection, the protocol used to read the CAN Frame will be set. 
Since each platform will process CAN Frames differently, each platform will write its own ParseCANFrame(can_frame *rx_frame) function. 
The calling 

To ensure the safe operation of the robot, a steady stream of commands from the computer and the onboard embedded controller is required. 
This is to ensure that if communication is lost, the robot would not be stuck executing the previously sent command, 
and instead the robot will stop moving.

Disconnecting CAN connection 
****************************


Maintaining stream of CAN Frames
********************************
The control of this continuous stream of CAN Frames being sent to the embedded controller is controlled by the MobileBase in the 
`void MobileBase::ControlLoop(int32_t period_ms)` function. However, the types CAN Frames to be sent varies between robots. 
Therefore, the actual function designed to send each message is determined by each platform in the `SendRobotCmd()` function
i.e. Each platform designs is CAN Frame sending protocol while the maintaining of the loop is on the MobileRobot abstract class. 


Testing CAN connection
***********************

After connecting the robot and the computer via the CAN bus, an additional device should show up from the commands::

   $ ifconfig -a

The new device should be identified as:: 

   can#: flags=.....

whereby # is a number, usually # = 0. For the segments below, it is assumed that the connection occurs at can0.
If this occurs, it indicates that the computer is actually connected to the robot via the CAN bus. 
You can attempt to read the data being sent via the CAN bus using:: 

   $ candump can0

If the comuunication is working properly, a stream of hexamdeximal should be flooding the command line. If instead the message:: 

   read: Network is down 

is shown, it indicates that TODO: not sure exactly what is indicates::

   $ sudo ip link set can0 up type can bitrate 500000

could fix this issue

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

