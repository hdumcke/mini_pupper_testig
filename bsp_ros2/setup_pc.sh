#!/bin/bash
######################################################################################
# ROS2
#
# This will install ROS2 amd mini pupper packages for use on a PC or VM
#
# To install
#    ./setup_pc.sh
######################################################################################

set -e

### Get directory where this script is installed
BASEDIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# check Ubuntu version
source /etc/os-release

if [[ $UBUNTU_CODENAME != 'focal' ]]
then
    echo "Ubuntu 20.04 LTS (Focal Fossa) is required"
    echo "You are using $VERSION"
    exit 1
fi

cd ~
git clone https://github.com/mangdangroboticsclub/mini_pupper_bsp.git
git clone https://github.com/Tiryoh/ros2_setup_scripts_ubuntu.git
sudo apt-get update
sudo apt-get -y install python3 python3-pip python-is-python3 python3-venv python3-virtualenv
sudo pip install -e ~/mini_pupper_bsp/mock_api
~/ros2_setup_scripts_ubuntu/ros2-galactic-desktop-main.sh
source /opt/ros/galactic/setup.bash

cd ~
mkdir -p ros2_ws/src
cd ~/ros2_ws/src
git clone https://github.com/mangdangroboticsclub/mini_pupper_ros.git -b ros2
git clone https://github.com/mangdangroboticsclub/mini_pupper_description.git -b ros2
#TODO remove after PR is merged
rm -rf ~/ros2_ws/src/mini_pupper_ros/mini_pupper_description
git clone --recursive https://github.com/chvmp/champ -b ros2
rosdep install --from-paths src --ignore-src -r -y
cd ..
colcon build
sudo apt-get -y install ros-galactic-teleop-twist-keyboard ros-galactic-cartographer-ros
