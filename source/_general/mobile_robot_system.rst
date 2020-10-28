##################
Overview of Robots
##################
In general, most of the robots have an on-board embedded controller that will manage the low level control of individual motors 
to achieve a desired control input (velocity and steering angle/angular velocity).

The desired control input can be sent to the embedded controller in 3 main ways:

1. Remote controller via radio frequency
2. A physical connection via CAN bus
3. A physical connection via Serial bus

Furthermore, the embedded controller is also able to communicate the state of the platform, such as measured velocities, temperature, currents etc, to an external computer via the CAN or Serial bus. 


