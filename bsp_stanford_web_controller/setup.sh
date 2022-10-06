#!/bin/bash

# check Ubuntu version
source /etc/os-release

if [[ $UBUNTU_CODENAME != 'jammy' ]]
then
    echo "Ubuntu 22.04 LTS (Jammy Jellyfish) is required"
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
git clone https://github.com/mangdangroboticsclub/StanfordQuadruped.git
git clone https://github.com/mangdangroboticsclub/mini_pupper_web_controller.git
./mini_pupper_bsp/install.sh

cd StanfordQuadruped
./install.sh
./configure_network.sh $1 $2

cd ~
./mini_pupper_web_controller/webserver/install.sh
sudo reboot
