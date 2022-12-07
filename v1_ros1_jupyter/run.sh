#!/bin/bash

/usr/bin/python3 /var/lib/minipupper/show_ip.py
/bin/bash /var/lib/minipupper/show_jupyter_url.sh
/bin/bash /var/lib/minipupper/edit_bashrc.sh
cd ~/dev/mini-pupper-jupyter-notebooks
#TODO this needs to be changed in the mini-pupper-jupyter-notebooks repo
sed -i "s/-it/-i/" run.sh
./run.sh
