from i3pystatus import IntervalModule
import urllib.request
import json

class TwitchWatch(IntervalModule):

    name = None
    url = None
    online_color = "#20ab52"
    offline_color = "#FFFFFF"
    settings = (
        ("url", "Streamer Username"),
        ("name", "Streamer Friendly Name"),
        ("online_color","Text color when the streamer is online"),
        ("offline_color","Text color when the streamer is offline")
    )
    interval = 120

    def run(self):
        streaming, text = self.statusLine()

        if self.name == None:
            self.name = self.url

        if streaming:
            color = self.online_color
        else:
            color = self.offline_color

        self.output = {
            "full_text": text,
            "color": color
        }

    def statusLine(self):
        streaming = False
        status = self.getStream(self.url)
        line = self.name + ": "

        if status == 0:
            line = "Twitch not responding"
        elif status == 1:
            line += "×"
        else:
            line += "Streaming"

        return (status == 2), line

    def getStream(self,url):
        req = urllib.request.Request('https://api.twitch.tv/kraken/streams/{0}'.format(url))
        streamStatus = 0
        with urllib.request.urlopen(req) as response:
            streamStatus = 1
            data = response.read().decode()
            jData = json.loads(data)
            if jData['stream'] != None:
                streamStatus = 2
        return streamStatus
