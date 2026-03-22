#!/bin/bash

echo "remap the device serial port(ttyUSBX) to  rplidar"
echo "rplidar usb connection as /dev/rplidar , check it using the command : ls -l /dev|grep ttyUSB"
echo "start copy rplidar.rules to  /etc/udev/rules.d/"
colcon_cd rplidar_ros2
sudo cp scripts/rplidar.rules  /etc/udev/rules.d
sudo mkdir -p /opt/rplidar && cp scripts/hotplug-rplidar.sh /opt/rplidar/
echo " "
echo "Restarting udev"
echo ""
sudo service udev reload
sudo service udev restart
echo "finish "
