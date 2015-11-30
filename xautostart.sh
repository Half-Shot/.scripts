#!/bin/zsh
#Startup Script to be used by X sessions.
#i3 Specific
#/home/will/.screenlayout/standard.sh &
/home/will/Scripts/wallp

steam &

hipchat &

steamfix &

#/usr/bin/radeontray client &

#hexchat &

compton --config /home/will/.i3/compton &

#megasync &

qtox &

#clementine &

#qbittorrent &

#CopyAgent &

#i3-sensible-terminal -x rainbowstream &

#Music Player
pidof -x musicstream
if [[ $? == "1" ]]
then
	/home/will/Scripts/musicstream &
fi

if [[ $1 == "i3" ]]
    then
	sleep 10 #Wait a bit
        
	TIME=$(expr $(date +"%H"))
        if [[ $TIME == "8" ]]
        then
                get_iplayer 80006 --livetvmode best –stdout –nowrite --stream | mpv - & #Start BBC news
        fi
	termite -e "zsh -i -c 'irc;'" &

        #ic [class="Firefox"] move workspace Middle
        #i3-msg [class="Hexchat"]  move workspace Left
        #i3-msg [class="HipChat"] move workspace Left
        #i3-msg [class="qTox"] move workspace Left
        #i3-msg [class="Clementine"] move workspace Right
        i3-msg "[class="Steam"] move workspace 3"
        i3-msg "[class="termite"] move workspace 2"
	sleep 10
fi

