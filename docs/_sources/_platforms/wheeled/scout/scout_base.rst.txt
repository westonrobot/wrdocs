*********************
Scout Base Respositry
*********************
This repositry provides 4 interlinked packages:

#. scout_base: Creates the main node that communicates with the physical scout_platforms.

#. scout_msgs: defines the types of ROS messages used by the ROS node for scout.

#. scout_description: Provides the URDF file that describes the basic robot model of Scout. Launches node that publishes TF .

#. scout_bringup: Provides launch files that encapsulate multi nodes for ease of usage.

   

.. include:: ./scout_base/scout_base_pkg.txt

.. include:: ./scout_base/scout_msgs_pkg.txt

.. include:: ./scout_base/scout_description_pkg.txt

.. include:: ./scout_base/scout_bringup_pkg.txt
