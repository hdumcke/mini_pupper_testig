#!/bin/bash

# check Ubuntu version
source /etc/os-release

if [[ $UBUNTU_CODENAME != 'focal' ]]
then
    echo "Ubuntu 20.04 LTS (Focal Fossa) is required"
    echo "You are using $VERSION"
    exit 1
fi

# check parameters
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <ssid> <wifi password>"
    exit 1
fi

cd ~
#TODO change after PR is merged
#git clone https://github.com/mangdangroboticsclub/mini_pupper_bsp.git
git clone https://github.com/hdumcke/mini_pupper_bsp.git -b PR5
git clone https://github.com/Tiryoh/ros_setup_scripts_ubuntu.git
./mini_pupper_bsp/install.sh
~/ros_setup_scripts_ubuntu/ros-noetic-ros-base-main.sh
source /opt/ros/noetic/setup.bash
source /usr/lib/python3/dist-packages/catkin_tools/verbs/catkin_shell_verbs.bash
rosdep update

mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/src
git clone -b ros1 https://github.com/mangdangroboticsclub/minipupper_ros.git
vcs import < minipupper_ros/.minipupper.repos --recursive

# it's not recommend to compile gazebo and cartographer on raspberry pi
touch champ/champ/champ_description/CATKIN_IGNORE
touch champ/champ/champ_gazebo/CATKIN_IGNORE
touch champ/champ/champ_navigation/CATKIN_IGNORE
touch minipupper_ros/mini_pupper_gazebo/CATKIN_IGNORE
touch minipupper_ros/mini_pupper_navigation/CATKIN_IGNORE

# install dependencies without unused heavy packages
rosdep install --from-paths . --ignore-src -r -y --skip-keys=joint_state_publisher_gui --skip-keys=octomap_server
cd ~/catkin_ws
catkin_make

#TODO move this to minipupper_ros repo
exit 0
# install service
cd ~
sudo ln -s $(realpath .)/robot.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable robot
sudo systemctl start robot
