.. Weston Robot Documentation documentation master file, created by
   sphinx-quickstart on Wed Aug 12 21:06:30 2020.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.


#####################################
Welcome to Weston Robot Documentation
#####################################

This website provides intrsutctions and tutorials on the setup and software development of the robot platforms from Weston Robot.

###################
General Information
###################

This section generally summarises key aspects of operating our robot platforms.

.. toctree::
   :maxdepth: 1
      
   /_general/operational_safety
   /_general/robot_maintenance

#####################
Mobile Robot Platform
#####################

This part of the document is written from the perspective of a user. 
As such, the *<platform>_base* packages are viewed as an interface between ROS and CAN. 
Although, as mentioned in the previous part of the document, 
the *<platform>_base* packages largely interface between ROS and C++, while *ugv_sdk* deal with C++ to CAN.

.. toctree::
    :maxdepth: 2

UGV Platforms
*************

.. toctree::
   :maxdepth: 1

   /_platforms/ugv/common/ugv_system_overview
   /_platforms/ugv/scout/scout
   /_platforms/ugv/hunter/hunter
   
   
Legged Platforms
****************

.. toctree::
   :maxdepth: 1

   /_platforms/legged/a1
   /_platforms/legged/aliengo
   
