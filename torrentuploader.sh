#!/bin/bash
UNAME="william"
PWORD="william2009"
SHARE="//GOFLEX_HOME/goflex home personal"
BIN=$(which smbclient)
Answer=$(zenity --list --title="Upload to where?" --column="Location" "Films" "Telly" "Anime" "Do Nothing")
if [[ $Answer == "Films" ]]; then
    OUTPATH="Films/"$(basename $1);
elif [[ $Answer == "Telly" ]]; then
    OUTPATH="Telly/"$(basename $1);
elif [[ $Answer == "Anime" ]]; then
    OUTPATH="Anime/"$(basename $1);
else
    exit 0;
fi
COMMAND="$BIN -U $UNAME -c 'put $1 $OUTPATH' '$SHARE' $PWORD"
xterm -e "$COMMAND"

