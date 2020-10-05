.. Weston Robot Documentation documentation master file, created by
   sphinx-quickstart on Wed Aug 12 21:06:30 2020.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

=====================================
Welcome to Weston Robot Documentation
=====================================

This website provides intrsutctions and explanations to add in debugging of projects that utilise the hardware and software packages provided by Weston Robots.


Overview
--------


.. toctree::
   :maxdepth: 2
      
   /_overview/overview 

This section provides an overview on how the software packages are designed as well as the flow of data from the computer to the robots and vice versa.

Basic Communication
-------------------
Most of the robots communicate with external computer using either the CAN bus and Serial bus. This segments outlines some basics of CAN and Serial communication as well as debugging tips.

.. toctree::
   :maxdepth: 2
      
   /_communication/communication 




Wheeled Robot Platform
----------------------

.. toctree::
   :maxdepth: 2

   /_platforms/wheeled/scout/scout
   /_platforms/wheeled/hunter/hunter
   
Tracked Robot Platform
----------------------

.. toctree::
   :maxdepth: 2

   /_platforms/tracked/bunker
   

Legged Robot Platform
----------------------

.. toctree::
   :maxdepth: 2

   /_platforms/legged/a1
   /_platforms/legged/aliengo
   
