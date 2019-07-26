#!/bin/bash

ls ./queue/*_queue &>/dev/null || exit
FILEPATH=`ls ./queue/*_queue | head -n1` || exit
FILEMAME=`basename $FILEPATH`
DATA=`cat $FILEPATH` || exit

TOKEN=`grep token $EXECFILEPATH | awk -F'=' '{print $2}'`

if [ $TOKEN != $1 ] ; then
	mv $FILEPATH ./error/
	exit
fi

mv $FILEPATH ./execute/

EXECFILEPATH="./execute/$FILEMAME"

TEXT=`grep text $EXECFILEPATH | awk -F'=' '{print $2}'`
USERID=`grep user_id $EXECFILEPATH | awk -F'=' '{print $2}'`
USERNAME=`grep user_name $EXECFILEPATH | awk -F'=' '{print $2}'`


HOUR=`echo $TEXT | fold -s1 | grep -B2 h | grep '[0-9]' | awk '{if(NR%10){ORS=""}else{ORS="\n"};print;}'`
MINUTES=`echo $TEXT | fold -s1 | grep -B2 m | grep '[0-9]' | awk '{if(NR%10){ORS=""}else{ORS="\n"};print;}'`

if [ -z "$HOUR" ]; then
  HOUR=0
fi

if [ -z "$MINUTES" ]; then
  MINUTES=0
fi

DEC_MINUTES=$((${HOUR}*60+${MINUTES}))

FLAG=`grep command= $EXECFILEPATH | sed 's/%2F//g' |awk -F'=' '{print $2}'`

TOTIME=`date +"%Y/%m/%d %H:%M:%S"`

SQL="INSERT INTO abot(id,user_name,time,flag,date) VALUES (\"$USERID\",\"$USERNAME\",$DEC_MINUTES,\"$FLAG\",\"$TOTIME\");"

echo $SQL | mysql -u app -h appdb001.abot.work -pjP6azn7V abot

mv $EXECFILEPATH ./executed/
