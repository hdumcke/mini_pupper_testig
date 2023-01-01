#!/bin/bash
######################################################################################
# ROS2
#
# This stack will consist of board support package (mini_pupper_bsp) and ROS2
#
# To install
#    ./setup.sh <SSID> "<your Wifi password>"
######################################################################################

set -e
echo "setup.sh started at $(date)"

###### work in progress #######
cd ~
git clone https://github.com/hdumcke/esp32-tests.git mini_pupper_bsp
./mini_pupper_bsp/install.sh

echo "setup.sh finished at $(date)"
sudo reboot
