#!/bin/bash
# chikoku.cgi

echo "Content-type:text/plain"
echo
read args
USERNAME=`echo $args | sed 's/&/\n/g' | grep user_name | awk -F '=' '{print $2}'`

SQL="select user_name,time,flag,date from abot where user_name=\"$USERNAME\";"

echo $SQL | mysql -u app -h appdb001.abot.work -pjP6azn7V abot -N | while read line
do
echo $line
done
