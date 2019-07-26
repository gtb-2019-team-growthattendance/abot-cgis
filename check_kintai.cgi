#!/bin/bash
# chikoku.cgi

echo "Content-type:text/plain"
echo
read args
USERNAME=`echo $args | sed 's/&/\n/g' | grep user_name | awk -F '=' '{print $2}'`

SQL="select SUM(time) from abot where user_name=\"$USERNAME\";"
RESP=`echo $SQL | mysql -u app -h appdb001.abot.work -pjP6azn7V abot -N`

echo $RESP
