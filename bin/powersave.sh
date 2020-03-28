#!/bin/sh
/usr/bin/systemctl --user stop battery-monitor.timer
/usr/bin/systemctl --user stop mpd.socket mpd.service
/usr/bin/systemctl stop bluetooth.service
/usr/bin/systemctl stop NetworkManager.service
/usr/bin/systemctl stop ModemManager.service
/usr/bin/systemctl stop geoclue.service

/usr/bin/pkill kdeconnectd
/usr/bin/pkill kdeconnect-indi
/usr/bin/pkill redshift
/usr/bin/pkill nm-applet
