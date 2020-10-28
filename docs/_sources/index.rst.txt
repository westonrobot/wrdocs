.. Weston Robot Documentation documentation master file, created by
   sphinx-quickstart on Wed Aug 12 21:06:30 2020.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

#####################################
Welcome to Weston Robot Documentation
#####################################

This website provides intrsutctions and explanations to aid in development and debugging of projects that use the hardware and software packages provided by Weston Robots.

*******************
General Development
*******************
This segment generally summarises key aspects of operating our robot platforms.

.. toctree::
   :maxdepth: 1
      
   /_general/mobile_robot_system
   /_general/operational_safety
   /_general/robot_maintenance
   /_general/software_packages

*******************
Basic Communication
*******************
Most of the robots communicate with external computer using either the CAN bus and Serial bus. This segments outlines some basics of CAN and Serial communication as well as debugging tips.

.. toctree::
   :maxdepth: 1
      
   /_communication/communication 

**********************
Wheeled Robot Platform
**********************

.. toctree::
   :maxdepth: 1

   /_platforms/wheeled/scout/scout
   /_platforms/wheeled/hunter/hunter
   
**********************
Tracked Robot Platform
**********************

.. toctree::
   :maxdepth: 1

   /_platforms/tracked/bunker
   
*********************
Legged Robot Platform
*********************

.. toctree::
   :maxdepth: 1

   /_platforms/legged/a1
   /_platforms/legged/aliengo
   
