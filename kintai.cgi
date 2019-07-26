#!/bin/bash
# chikoku.cgi

echo "Content-Type: application/json"
echo
read args

USERNAME=`echo $args | sed 's/&/\n/g' | grep user_name | awk -F '=' '{print $2}'`
DATE=`date +%s`

USERID=`echo $args | sed 's/&/\n/g' | grep user_id | awk -F '=' '{print $2}'`

echo $args | sed 's/&/\n/g'  > ./queue/queue/${USERNAME}_${DATE}_queue

echo "{ \"response_type\":\"in_channel\" , \"text\":\"<@${USERID}> 申請を受け付けました\" }"

