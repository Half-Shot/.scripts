#!/bin/bash
export XAUTHORITY=/home/will/.Xauthority
export DISPLAY=:0
pidof kodi.bin > /dev/null
if [ $? -eq 1 ]; then
	kodi &
fi
