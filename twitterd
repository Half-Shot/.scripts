#!/bin/env python3
from twython import Twython
from gi.repository import Notify
import webbrowser
import threading
import json
import twython
import os.path
import urllib
import signal
import sys
class twitterd:
    path = "/home/will/.config/twitterd.json"
    settings = {'oauth_token':'',
                'oauth_secret':'',
                'app_key':'',
                'app_secret':'',
                'interval':5,
                'tweets':5,
                'maxLastViewed':50,
                'lastViewed':[]
                };
    def GrabLatestTweet(self,Count):
        twitter = Twython(self.settings["app_key"], self.settings["app_secret"],self.settings["oauth_token"],self.settings["oauth_secret"])
        try:
            timeline = twitter.get_home_timeline(count=self.settings["tweets"])
        except twython.exceptions.TwythonRateLimitError:
            print("Too many requests :(")
            return False
        except:
            print("Couldn't connect to the timeline for some reason.")
            return False
        for tweet in timeline:
            if tweet["id"] in self.settings["lastViewed"]:
                continue
            #Keep the list compact.
            if len(self.settings["lastViewed"]) > self.settings["maxLastViewed"]:
                self.settings["lastViewed"].pop()
            #Add tweet to last viewed so its not repeated.
            self.settings["lastViewed"].insert(0,tweet["id"])
            self.DisplayTweet(tweet)
        return True
    def DisplayTweet(self,tweet):
        Notify.init ("markup")
        #Get Image
        screenname = tweet["user"]["screen_name"]
        filename = "/tmp/avatar"
        filename += screenname
        filename += ".jpg"
        if not os.path.exists(filename):
            os.system("$(which wget) --quiet -O" + filename + " " + tweet["user"]["profile_image_url"])
        tweetBody = tweet["text"] + ' - Link: <b>https://twitter.com/' + tweet["user"]["screen_name"] + '/status/' + str(tweet["id"])+ '</b>';
        TweetNotify=Notify.Notification.new (tweet["user"]["name"],tweetBody,filename)
        TweetNotify.set_category("twitter.tweet")
        TweetNotify.show()

    def RunTwitterd(self):
        if self.GrabLatestTweet(TwitterdObject.settings["tweets"]):
            self.SaveConfig()
        threading.Timer(TwitterdObject.settings["interval"], self.RunTwitterd).start()

    def showTweet(self,notification, action, data):
        print("TURL:",notification.url)
        webbrowser.open(notification.url)
        
    def LoadConfig(self):
        try:
            f = open(self.path, 'r')
        except FileNotFoundError:
            print("Config not found, creating one.")
            self.SaveConfig()
            f = open(self.path, 'r')
        self.settings = json.load(f)
        f.close()
        
    def SaveConfig(self):
        f = open(self.path, 'w+')
        json.dump(self.settings,f)
        f.close()
        
    def SaveAndQuit(self,signal, frame):
       self.SaveConfig()
       sys.exit(0)
       
TwitterdObject = twitterd()
TwitterdObject.LoadConfig()
signal.signal(signal.SIGINT, TwitterdObject.SaveAndQuit)
TwitterdObject.RunTwitterd()
