###########################
Scout Navigation Respositry
###########################

This repository contains navigation and simulation packages for scout robot. 

* scout_nav_platform: a demostrational navigation platform with lidar and IMU
* scout_ros_nav: a demonstrational ROS navigation setup for scout
* scout_webots_sim: webots-based simulation support for scout

*****************
Repository Set up
*****************

Please setup "[scout_base](https://github.com/westonrobot/scout_base.git)" repository properly before proceeding to the following steps.

1. Install Depednent libraries
==============================
.. code-block:: none

  $ sudo apt-get install -y ros-$ROS_DISTRO-ros-controllers \
                        ros-$ROS_DISTRO-joint-state-publisher-gui \
                        ros-$ROS_DISTRO-navigation \
                        ros-$ROS_DISTRO-teb-local-planner \
                        ros-$ROS_DISTRO-gmapping \
                        ros-$ROS_DISTRO-pointcloud-to-laserscan \
                        ros-$ROS_DISTRO-pcl-ros \
                        ros-$ROS_DISTRO-webots-ros
                        ros-$ROS_DISTRO-teleop-twist-keyboard

2. Clone the packages into your catkin workspace and compile
=============================================================

(the following instructions assume your catkin workspace with scout_base and ugv_sdk is at: ~/catkin_ws/src)
.. code-block:: none

  $ cd ~/catkin_ws/src
  $ git clone https://github.com/westonrobot/scout_navigation.git
  $ cd ..
  $ catkin_make

***************************
*scout_webots_sim* packages
***************************
This package provides the tools for a high level interface with the Scout platform in the Webots simulated environment. The tools provided are mainly:

#. A simulated world with the Scout model loaded inside

#. A ROS node that interfaces between ROS and the Scout model in Webots 

#. SDK for adding peripheral to the Scout model in Webots.



* Start the Webots-based simulation of the Scout platform:
    .. code-block:: none

        $ roslaunch scout_webots_sim scout_v2_sim_basic.launch


    This will:
    1. Launch Webots
    2. Load a simple world with the scout robot in it

   
* Next, the ROS node interfaces ROS with the Scout model in Webots can be launched:
    .. code-block:: none

        $ roslaunch scout_webots_sim scout_v2_sim_node_basic


    In the Webots console, the message *The controller is now connected to the ROS master* should be displayed.
    
    This will start the */scout_webots_node* that

    * Subscribes:

      * /cmd_vel

      * /scout_light _control

      * /model_name

    * Publishes:

      * /odom

      * /tf        
    
    Through this node, the Scout model can be controller using the /cmd_vel topic.

* Start the keyboard tele-op node

    .. code-block:: none

        $ roslaunch scout_bringup scout_teleop_keyboard.launch


In the *scout_nav_bringup* the launch file: *scout_sim_basic_full.launch* will launch all 3 launch files above as well as the */tf* node.


******************
Sample Development
******************
A sample development of the Scout platform, for navigation and mapping is provided in
 *scout_nav_platform*. This package will be elaborated on in this segment.


1. Hardware Specifications
==========================

The hardware attached to the Scout robot are:

#. Metal Frame

#. Power Distribution Board (PDB)

#. Onboard Computer: Jetson Xavier NX

#. Onboard Router: Asus RT - N56U

#. 3D Lidar: (LS 16-Channel LiDAR (Compact)](http://www.lslidar.com/product/leida/MX/33802ac6-f05e-4818-ac95-f73b84e99131.html)

A seperate PC will be connected wirelessly to the onbaord system.This PC will be refered to as the *workstation*.

Through the CAN interface on the Scout robot, the power is routed to the PDB and distributed to the onboard computer, router and LiDAR.

The onboard computer is also connected to the CAN bus via the CAN interface on the Scout. The onboard computer thus sends the steering commands to the in-build micro-controller in the Scout.

The LiDAR used can only transmit data through ethernet protocol. The router is used to connect the LiDAR, the onboard computer and the workstation.


2. Software Specifications
==========================

The onboard computer is running Ubuntu 18.04 with ROS Melodic.

* IP Adresses:

    * work station: 10.10.0.150
    * onboard computer: 10.10.0.10
    * lsLiDAR: 10.10.0.30
    
    The IP address of the work station and onboard computer were set using DHCP on the router, while the lsLiDAR IP address wast set statically using a customised software for lsLiDAR

* ROS packages

  * [lslidar](https://github.com/pd-tan/lslidar_C16.git) package was used to publish the LiDAR data as a ROS topic.
  * [scout_base](https://github.com/westonrobot/scout_base.git) package was used to interface between ROS topics and CAN messages sent through the CAN bus.
  * [scout_webots_sim](./scout_webots_sim) package was used to implements a Webots simulation of the navigation platform.
  * `ROS navigation stack` was used for mapping and navigation. gmapping was used for mapping while amcl was used for localization.


3. Running Actual Robot
==========================

Unless stated otherwise, all commands are to be run from the onbaord computer
Ensure that the workstation is connected to the router on the Scout robot.

#. Setup ROS network

    .. code-block:: none
        
        $ source ~/catkin_ws/scout_navigation/scout_platform/scripts/ros_network_onboard_setup.bash

    On the workstation:
    
    .. code-block:: none
        
        $ source ~/catkin_ws/scout_navigation/scout_platform/scripts/ros_network_workstation_setup.bash

    This setup must be run in every terminal instance used for ROS on both the workstation and the onboard computer. Consider adding these commands to ~/.bashrc to simplify setup.

    To test that the ROS network is setup appropriately:
    
    .. code-block:: none

        $ roscore
    

    On the workstation:
    
    .. code-block:: none
        
        $ rostopic list
    

    If the terminal on the workstation is able to find the instance of ROS started on the onboard computer, the following should be returned on the workstation: 
    
    .. code-block:: none
        
        /rosout
        /rosout_agg
    

    Ensure that no instance of ROS in running on the workstation prior to these tests.

    More information about ROS network can be found online.

#. Start Communication between Scout and Onboard PC

    .. code-block:: none

        $ roslaunch scout_base scout_base.launch
      
    To test this communication, on the workstation

    .. code-block:: none

        $ roslaunch scout_bringup scout_teleop_keyboard.launch
    

    from the workstation, the scout platform should be able to be controlled using the keyboard. 

    Take note to suspend the Scout robot, ensuring that the wheels are not in contact with ground to prevent the robot from actually moving.

    More information about the communication between the onboard pc and scout can be found in [scout_base](https://github.com/westonrobot/scout_base.git)


#. Start Communication with LiDAR

    Since a lsLiDAR is used for this platform, the ROS package developed for lsLiDAR is used. 

    .. code-block:: none

        $ roslaunch lslidar_c16_decoder lslidar_c16.launch
    
    To test that the node was launched successfully:
    
    .. code-block:: none

        rostopic list
    

    The topics */lslidar_packet*, */lslidar_point_cloud* and */lslidar_sweep* should be listed out.


****************************
4. Simulation Specifications
****************************

The simulation should be run on the workstation and NOT the onboard computer

Webots Extensions
=================
The ROS [scout_nav_sim_node](./scout_nav_platfom/src/scout_nav_sim_node.cpp) written for this navigation platform implements the [WebotsRunner](./scout_webots_sim/src/scout_webots_runner.cpp) class from the scout_webots_sim package. 

Two extensions were implemented in C++ [imu_extension](./scout_nav_platform/src/imu_extension.cpp) and [lidar_extension](./scout_nav_platform/src/lidar_extension.cpp). These two extensions were added to the instance of WebotsRunner to interface ROS with the LiDAR and IMU in Webots. The two extensions act as an interface between ROS and the extension in webots,

**********************
5. Running Simulation
**********************

To run the base instance of the simulation (with the platform and LiDAR, but no mapping or navigation running):

.. code-block:: none

    $ roslaunch scout_nav_platoform scout_v2_sim_nav_platform

The robot model loaded from this launch file will have the LiDAR attached to the model (floating above the scout model). Furthermore, the robot model will be loaded into an indoor house environment. 

Compared to the scout_v2_sim_node_basic.launch, the ROS node created from this scout_v2_sim_nav_platform.launch file publishes the additional topics of:
1. /imu
2. /rslidar_points

These additional topics are published as a result of [imu_extension](./scout_nav_platform/src/imu_extension.cpp) and [lidar_extension](./scout_nav_platform/src/lidar_extension.cpp).




******************
6. Running Mapping
******************

Regardless of wether the simulation or the actual robot is used, the following steps for running mapping are the same. 

For the simulation, the command are all run on the workstation. 

For the actual robot, commands are run on the onboard computer, unless otherwise stated

#. Launch Description

    .. code-block:: none 
        
        $ roslaunch scout_nav_platform scout_v2_nav_platform_description.launch
  
    This will publish the transforms between the different links of the robot as well as the odom and map link

#. Visualize on Workstation
   
    The data obtained from the LiDAR, as well as the transforms, can be visualised in RVIZ. 

    On the workstation:

    .. code-block:: none
    
        $ rosrun rviz rviz
 
    Add the folllowing:
   
    #. pointcloud
    
    #. tf

    If all the above steps were executed without issue, the pointcloud obtained from the LiDAR will be seen on RVIZ.

#.  Run mapping

    .. code-block:: none

        $ roslaunch scout_ros_nav scout_v2_mapping.launch
  
    The map can be visualized on RVIZ by adding the `map` and selecting the map topic.

    To obtain an appropriate map of the surrounding, the Scout has to be moved around. The Scout robot can be controlled from the workstation using:

    .. code-block:: none
    
        $ roslaunch scout_bringup scout_teleop_keyboard.launch


    As the Scout is moving around, a map of its surrounding will be obtained and displayed on RVIZ

*****************************
7. Saving and Loading of maps
*****************************

* To save the map generated from mapping:
    
    .. code-block:: none
    
        $ rosrun map_server map_saver -f {YOUR_CATKIN_WORKSPACE}/src/scout_navigation/scout_ros_nav/maps/{YOUR_MAP_NAME}
 
    The map_server should be run after the map obtained is satisfactory and can be be used for navigation. The map will be saved as YOUR_MAP_NAME.yaml and YOUR_MAP_NAME.pgm


* To select the .yaml map file, edit the map_file value in the launch file (scout_v2_sim_navigation.launch or scout_v2_robot_navigation.launch)

    .. code-block:: none
    
        <arg name="map_file" default="$(find scout_ros_nav)/maps/webots_indoor.yaml"/>  


    should be changed to

    .. code-block:: none
    
        <arg name="map_file" default="${YOUR_CATKIN_WORKSPACE}/src/scout_navigation/scout_ros_nav/maps/{YOUR_MAP_NAME}.yaml"/>
    
********************    
8. scout_nav_bringup
********************

Form the previous instruction, multiple instances of the terminal would be required to launch all the individual launch files. The scout_nav_bringup package provides launch files that consolidate different launch files:

#. scout_v2_sim_nav_platform_full.launch:

   #. Launches `scout_v2_sim_nav_platform.launch`: Runs Webots and start ROS node to interface LiDAR, IMU and Scout in webots with ROS
   
   #. Launches `scout_v2_nav_platform_description.launch`: Publishes transformed between links in the robot
   
   #. Launches `scout_teleop_keyboard.launch`: Control Scout in Webots using keyboard.
   
   #. Runs `pointcloud_to_laserscan` node that condenses 3D pointcloud into 2D scan for gmapping

#. scout_v2_sim_mapping.launch:
   
   #. Launches `scout_v2_sim_nav_platform_full.launch`
   
   #. Launches `scout_v2_mapping.launch`

#. scout_v2_sim_navigation.launch:
   
   #. Launches `scout_v2_sim_nav_platform_full.launch`
   
   #. Launches `scout_v2_navigation.launch`
#. scout_v2_robot_mapping.launch:
   #. Launches `scout_base.launch`: Setup communication between onboard PC and Scout
   
   #. Launches `scout_v2_nav_platform_description.launch`: Publishes transformed between links in the robot
   
   #. Launches `scout_v2_mapping.launch`

#. scout_v2_robot_navigation.launch:
   
   #. Launches `scout_base.launch`: Setup communication between onboard PC and Scout
   
   #. Launches `scout_v2_nav_platform_description.launch`: Publishes transformed between links in the robot
   
   #. Launches `scout_v2_navigation.launch`

#. scout_v2_workstation_mapping.launch
   
   #. Runs RVIZ using a preset configuration to display pointcloud, laserscan, mapping and transforms

#. scout_v2_workstation_navigation.launch
   
   #. Runs RVIZ using a preset configuration to display pointcloud, laserscan, mapping and transforms

An example usage of these launch files is as described below:

#. launch scout_v2_robot_mapping.launch & launch lslidar_c16.launch on the onboard pc

#. launch scout_v2_workstation_mapping.launch on the workstation.

#. launch scout_teleop_keyboard.launch to control the robot

#. Move the robot around and map the area it is in

.. custom_development_reference:

******************
Custom Development
******************

This sections outlines how you would get started on creating your own package for the scout platform with custom hardware extensions, such as a lidar and imu. This respository consist of the files required for both the simulation and the interface with the physical platform and sensors.



1. Package and Directory Setup
==============================

.. code-block:: none

    $ catkin_create_package ${YOUR_PACKAGE_NAME} scout_webots_sim geometry_msgs message_generation pcl_ros roscpp roslaunch rospy scout_base sensor_msgs std_msgs tf webots_ros pointcloud_to_laserscan
    
    $ cd ${YOUR_PACKAGE_DIRECTORY}
    
    $ mkdir urdf rviz webots_setup



2. Simulation Setup
===================

#. New Webots Project

    * Launch webots

    * Create a new project directory in ${YOUR_PACKAGE_DIRECTORY}/webots_setup : Wizards -- New Project Directory -- Add a rectangle arena

    * Copy the scout_v2.proto into the ${YOUR_PACKAGE_DIRECTORY}/webots_setup/protos directory

    * Copy the scout_base_controller folder into the ${YOUR_PACKAGE_DIRECTORY}/webots_setup/

    * Import the scout robot by adding a proto node: add -- PROTO nodes (Current Projects) -- ScoutV2(robot) -- add

#. Setting up custom extensions

    Adding your own extension consists of 3 main steps:

    * Adding extension in webots model

    * Adding the transforms for the extension in the .xacro file

    * Writing the C++ code to interface between the webots extension and ROS

    The example of adding a RPLIDAR module is explained in this example.
 
#. webots model

    * Under ScoutV2, select extensionSlot and click <add> to add your desired extension
    
    * Create folder "${YOUR_PACKAGE_DIRECTORY}/webots_setup/models"
    
    * Export model with extensions into the exported models folder
    
    * The exported model can now be imported into any world within the project.

#. urdf/xacro model

    * Create a new .xacro file

    * Import the base .xacro file of the scout model using: ``<xacro:include filename="$(find scout_description)/urdf/scout_v2.xacro" />``
    
    * Add the links and joints of the new extension

#. ROS/webots interface

    * Create a class "ExtensionExample" that inherits the WebotsExtension class

    * Define the setup protocol as shown in [lidar_extension.cpp](scout_ros_nav/src/lidar_extension.cpp)

    * The purpose of this interface is to generate a node that calls the ROS services to interface with Webots. For example, the [lidar_extension.cpp](scout_ros_nav/src/lidar_extension.cpp) is used to generate a node that publishes the laser scan data from the lidar in the Webots simulation.

#. Exporting your new model to a different world

    Note: this is to export the model to a new world but within the same project.

    After the robot and its additional sensors has been modeled in the webots world, it is like that you would like to place this robots in different simulated environments, such as a workshop space or an indoor apartment. This sections brief outlines the main steps involved

    * Export the new robot model (with extensions) using the webots GUI:
    
        * Right-click the model node
    
        * Click Export
    
        * Save the model in a the folder ${YOUR_PACKAGE_DIRECTORY}/simulation/exported models
    
    * Load the world in webots you want to import the model into.
    
    * Add the export robot model
        * Add node
        
        * Import...
        
        * Select the model file that you exported in step 1

Having finished the above steps, you should be able to see the scout platform with its extensions inside your chosen environment. 

**************
3. Robot Setup
**************

If the hardware extensions, such as the type of LIDAR or camera, is already known/determined, the simulation should then be altered to closely follow the actual setup. For example:

* The location of sensors in the simulation should match the physical robot, so that the URDF files for both real and simulated robot are the same.

* The nodes created for the different webots extensions should behave similarly to the actual hardware set-up so that the accompanying programs, such a mapping and navigation, can be used for both the simulation and the physical robot
