#!/usr/bin/env bash

# Desc:send some msg to someone logged in linux system
 
 # check logged user{{{
logged=$(who | awk -v IGNORECASE=1 -v usr=$1 '{ if ($1==usr) { print $1 }exit }')
 
if [ -z $logged ]; then
 
    echo "$1 is not logged on."
 
    echo "Exit"
 
    exit
 
fi
#}}}
 
# Checking If The User Accepts Messages{{{
check=$(who -T | grep -i -m 1 $1 | awk '{print $2}')
 
if [ "$check" != "+" ]; then
 
    echo "$1 disable messaging."
 
    echo "Exit"
 
    exit
 
fi
# }}}
 

 # Checking If Message Was Included{{{
if [ -z $2 ]; then
 
    echo "Message not found"
 
    echo "Exit"
 
    exit
 
fi
 #}}}

# Getting the Current Terminal 
terminal=$(who | grep -i -m 1 $1 | awk '{print $2}')
 
 # Send msg{{{
shift
 
while [ -n "$1" ]; do
 
    message=$message' '$1
 
    shift
 
done
 
echo $message | write $logged $terminal
# }}}