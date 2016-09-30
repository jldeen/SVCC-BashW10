#!/bin/bash
#install and configure x-11 on Windows

sudo apt-get install x11-apps
echo 'export DISPLAY=:0' >> ~/.bashrc && . ~/.bashrc
sudo sed -i 's$<listen>.*</listen>$<listen>tcp:host=localhost,port=0</listen>$' /etc/dbus-1/session.conf