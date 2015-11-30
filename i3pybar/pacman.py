from i3pystatus import IntervalModule
import subprocess
class PacmanCount(IntervalModule):
    """
    Counts amount of packages ready for upgrades
    """

    settings = (
        ("format",
         "format string used for output. {packages} is the packages ready for updates."),
        "color",
        "file",
        "alert_count",
        "alert_color"
    )
    
    format = "[{count}]"
    color = "#FFFFFF"
    cmd = "pacman -Sup|wc -l"
    alert_count = 30
    alert_color = "#FF0000"
    
    def run(self):
        count = subprocess.call(self.cmd,shell=True)
        color = self.color
        if int(count) >= self.alert_count:
            color = self.alert_color
            
        self.output = {
            "full_text": self.format.format(count=count),
            "color": color
        }
