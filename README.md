# Mini Pupper

High level overview, web site, Discord channel, ...

## Hardware

Versions, link to assembly manual(s)

## Software

Below is a list of repositories where you can find code for your mini pupper. Some of these repositories is hosted by MangDang and we make any effort to maintain these repositories. Please open issues on Github when you see fit and submit pull requests if you can improve the code.

We are an open community and welcome contributions. If you have written code for mini pupper that you want to share please submit a PR to this repo with the details.

We also provide full stacks that come with a setup script that you can run starting with a SD card with Ubuntu installed. Clone this repository, run the setup script for the stack you want to install and wait until the Raspberry Pi reboots. See below for details.

We highlight the Status of the code as follows:

- experimantal: this is code in an early stage. Be prepared to debug and discuss if you want to get involved
- testing: this code should work but expect to hit some bugs. 
- working: the code has tested and suppoed to work as intented. You might still find bugs, please consider to raise a Guthub issue
- production: this code is used by many of our users and we encourage you to raise a Guthub issue should you encounter any bug

### Hosted by MangDang

#### Repositories

You will find these repos under https://github.com/mangdangroboticsclub

| Repository                       | Description                                                                           | Status       |
| ---                              | ---                                                                                   | ---          |
| mini_pupper_bsp                  | BSP(board support package) for Mini Pupper.                                           | working      |
| StanfordQuadruped -b mini_pupper | This is a fork of the Stanford Pupper with modification to make it run on Mini Pupper | working      |
| mini_pupper_web_controller       | This code provides a web GUI for Mini Pupper running StanfordQuadruped                | testing      |
| mini_pupper_ros -b ros1          | This code used Champ and ROS1 to control Mini Pupper.                                 | testing      |
| mini_pupper_ros -b ros2          | This code used Champ and ROS2 to control Mini Pupper.                                 | experimantal |

#### Full Stacks

| Name     | Description                                                                                                        | setup                                            |
| ---      | ---                                                                                                                | ---                                              |
| Stanford | Allows to control your Mini Pupper with either a supported PS4 joystick or a Web GUI using the Stanford controller | [setup.sh](bsp_stanford_web_controller/setup.sh) |
| ROS1     | Run ROS1 on your Mini Pupper. Support for Lidar and OAK-D-Lite is provided                                         | [setup.sh](bsp_ros1/setup.sh)                    |
| ROS2     | Run ROS2 on your Mini Pupper. Support for Lidar and OAK-D-Lite is provided                                         | [setup.sh](bsp_ros2/setup.sh)                    |

### Contributions

#### Repositories

| Repository                                                                | Description                                                                                                                                                                      | Status       |
| ---                                                                       | ---                                                                                                                                                                              | ---          |
| [minipupper_kinematics](https://github.com/hdumcke/minipupper_kinematics) | This repositories contains Jupyter notebook that I used to gain a better understanding of the kinematics of a quadruped robot in general and MangDang Mini Pupper in particular. | experimantal |

#### Full Stacks

| Name | Description | setup |
| ---  | ---         | ---   |
|      |             |       |
