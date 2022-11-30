#!/usr/bin/env python3
import argparse
import sys
import os

##############################################################
#
# Ask questions to prepare cloud-init file for mini pupper
#
# if ~/.mini_pupper_sd.txt exists no questions will be asked
#
##############################################################

target_environment = {}
target_environment['ros_master'] = ''
hardware_version = ['v1', 'v2', 'v2_pro']
stack_names = ['Stanford', 'ROS1']
stack_scripts = ['bsp_stanford_web_controller/setup.sh', 'bsp_ros1/setup.sh']


def write_cache(cache_file):
    with open(cache_file, 'w') as fh:
        for key in target_environment.keys():
            fh.write("%s: %s\n" % (key, target_environment[key]))


def ask_user(prompt, var_name):
    input_text = input("%s: " % prompt)
    target_environment[var_name] = input_text


def ask_questions():
    ask_user("Your WiFi SSID", 'wifi_ssid')
    ask_user("Your WiFi password", 'wifi_password')
    ask_user("Mini Pupper user password", 'ubuntu_password')
    print("Which Mini Pupper Hardware do you want to install:\n")
    for i in range(len(hardware_version)):
        print("%s: %s" % (i + 1, hardware_version[i]))
    ask_user("Please enter number", 'hardware_version')
    print("Which stack do you want to install:\n")
    for i in range(len(stack_names)):
        print("%s: %s" % (i + 1, stack_names[i]))
    ask_user("Please enter number", 'stack')
    if target_environment['stack'] == 'ROS1':
        ask_user("ROS master IP address", 'ros_master')
    ask_user("Full path to SD card", 'sd_path')


# Detect OS
target_environment['this_os'] = sys.platform

parser = argparse.ArgumentParser(description='Prepare SD card for Mini Pupper')
parser.add_argument('-c', '--cache',
                    action='store_true',
                    help='Cache my responses')
args = parser.parse_args()

conf_file = os.path.join(os.path.expanduser("~"), '.mini_pupper_sd.txt')
if os.path.exists(conf_file):
    with open(conf_file, 'r') as fh:
        lines = fh.readlines()
        for line in lines:
            if ':' in line:
                arr = line.strip().split(':')
                key = arr[0]
                if len(arr) == 2:
                    value = arr[1].strip()
                else:
                    value = ''.join(s for s in arr[1:]).strip()
                if value.startswith('"') and value.endswith('"'):
                    value = value[1:-1]
                target_environment[key] = value
else:
    ask_questions()
    target_environment['script'] = "%s_%s" % (hardware_version[int(target_environment['hardware_version']) - 1],
                                              stack_scripts[int(target_environment['stack']) - 1])
    if args.cache:
        write_cache(conf_file)

network_conf_file = os.path.join(target_environment['sd_path'], 'network-config')
if not os.path.exists(network_conf_file):
    sys.exit("Invalid path to SD card or SD card not mounted\n")

network_conf = """version: 2
ethernets:
  eth0:
    dhcp4: true
    optional: true
wifis:
  wlan0:
    dhcp4: true
    optional: true
    access-points:
      %s:
        password: "%s"
"""
with open(network_conf_file, 'w') as fh:
    fh.write(network_conf % (target_environment['wifi_ssid'], target_environment['wifi_password']))

user_data_file = os.path.join(target_environment['sd_path'], 'user-data')
user_data = """#cloud-config
ssh_pwauth: True
chpasswd:
  expire: false
  list:
  - ubuntu:%s
packages:
- git
runcmd:
- [ su, ubuntu, -c, "git clone https://github.com/hdumcke/mini_pupper_testig.git /home/ubuntu/mini_pupper" ]
- [ su, ubuntu, -c, "/home/ubuntu/mini_pupper/%s %s '%s' %s" ]
- [ reboot ]
"""
with open(user_data_file, 'w') as fh:
    fh.write(user_data % (target_environment['ubuntu_password'],
                          target_environment['script'],
                          target_environment['wifi_ssid'],
                          target_environment['wifi_password'],
                          target_environment['ros_master']))
