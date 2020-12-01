#!/bin/sh
/usr/bin/systemctl stop NetworkManager.service
sudo /usr/bin/cpupower frequency-set --max 600MHz -g powersave
