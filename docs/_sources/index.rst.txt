.. Weston Robot Documentation documentation master file, created by
   sphinx-quickstart on Wed Aug 12 21:06:30 2020.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.


#####################################
Welcome to Weston Robot Documentation
#####################################

This website provides intrsutctions and explanations to aid in debugging of projects that utilise the hardware and software packages provided by Weston Robots.

###################
General Development
###################
This segment generally summarises key aspects of operating our robot platforms.

.. toctree::
   :maxdepth: 5
      
   /_general/mobile_robot_system
   /_general/operational_safety
   /_general/robot_maintenance
   /_general/software_packages
   /_general/communication



######################
Wheeled Robot Platform
######################

This part of the document is written from the perspective of a user. 
As such, the *<platform>_base* packages are viewed as an interface between ROS and CAN. 
Although, as mentioned in the previous part of the document, 
the *<platform>_base* packages largely interface between ROS and C++, while *ugv_sdk* deal with C++ to CAN.


.. toctree::
   :maxdepth: 5

   /_platforms/wheeled/scout/scout
   /_platforms/wheeled/hunter/hunter
   

######################
Tracked Robot Platform
######################

.. toctree::
   :maxdepth: 1

   /_platforms/tracked/bunker
   
#####################
Legged Robot Platform
#####################

.. toctree::
   :maxdepth: 1

   /_platforms/legged/a1
   /_platforms/legged/aliengo
   
