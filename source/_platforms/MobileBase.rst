CAN Interface
=============
Information on CAN bus can be found in https://www.youtube.com/watch?v=FqLDpHsxvf8 and https://en.wikipedia.org/wiki/CAN_bus.

Many protocols for communication through the CAN bus is similar for different platforms. 
As such, a abstract class `MobileBase` was designed as the super class of the CAN interface class for each robot model.

On the level of `MobileBase` the following is settled:

1. Setting up CAN connection
2. Disconnecting CAN connection 
3. Maintaining stream of CAN Frames

Setting up CAN connection
-------------------------

During the setting up of CAN connection, the protocol used to read the CAN Frame will be set. 
Since each platform will process CAN Frames differently, each platform will write its own ParseCANFrame(can_frame *rx_frame) function. 
The calling 

To ensure the safe operation of the robot, a steady stream of commands from the computer and the onboard embedded controller is required. 
This is to ensure that if communication is lost, the robot would not be stuck executing the previously sent command, 
and instead the robot will stop moving.

Disconnecting CAN connection 
----------------------------


Maintaining stream of CAN Frames
--------------------------------
The control of this continuous stream of CAN Frames being sent to the embedded controller is controlled by the MobileBase in the 
`void MobileBase::ControlLoop(int32_t period_ms)` function. However, the types CAN Frames to be sent varies between robots. 
Therefore, the actual function designed to send each message is determined by each platform in the `SendRobotCmd()` function
i.e. Each platform designs is CAN Frame sending protocol while the maintaining of the loop is on the MobileRobot abstract class. 
