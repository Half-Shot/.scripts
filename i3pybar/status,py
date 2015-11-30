#!/bin/env python3
import subprocess
import pacman
from twitch import TwitchWatch
from i3pystatus import Status

status = Status(standalone=True)

status.register("shell",command = 'date +"📅  %a %-d %B"')

status.register("shell",command = 'date +"UK: 🕐  %X"')

status.register("shell",command = 'TZ=America/Virgin date +"EDT: 🕐  %X"')

#status.register("shell",command = "echo 'ありがとう (^_-)'")

status.register("shell",command = "echo ⏲  $(uptime --pretty)")

status.register("cpu_usage",format="{usage:02}%")

status.register("mem")

status.register("disk",
    path="/",
    format="⛁  {percentage_used}%",
    critical_limit=95)

status.register("disk",
    path="/home",
    format="⌂ {percentage_used}%",critical_limit=95)

status.register("mpd",
    host="CENSOR",
    format="♪ {song_elapsed}/{song_length} {title} {filename}")

status.register("pulseaudio",
    format="🔊 {volume}")

#status.register("reddit",
#    format="✉ {message_unread} ",
#    username="CENSOR",
#    password="CENSOR",
#    mail_brackets=True,
#    color_orangered="#FFB100")

#status.register("shell",command = "twitter replies -l 1");
streamers=[("Limes","limealicious"),("Vinny","vinesauce"),("Joel","vargskelethor")]
for streamer in streamers:
    status.register(TwitchWatch,name=streamer[0],url=streamer[1])

#pm = pacman.PacmanCount()
#status.register(pm)
status.run()
