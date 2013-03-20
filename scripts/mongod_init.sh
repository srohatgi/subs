#!/bin/bash

rc=0
myname=`basename $0`
mongod_pid()
{
  pid=`ps aux | grep mongod | grep -v grep | grep -v $myname | awk '{ print $2 }'`
  echo $pid
}

status()
{
  pid=$(mongod_pid)
  if [[ "$pid" == "" ]]
  then
    echo "mongod is not running!"
  else
    echo "mongod is running with $pid"
  fi
}

stop()
{
  pid=$(mongod_pid)
  if [[ "$pid" == "" ]]
  then
    echo "unable to locate mongod pid"
    rc=1
  else
    echo "stopping mongod with $pid"
    kill $pid
  fi
}

start()
{
  mongod --dbpath data --logpath data/mongod.log --fork
  rc=$?
}

case $1 in
start)
  start
;; 
stop)   
  stop
;; 
restart)
  stop
  start
;;
status)
  status
;; 
esac    
exit $rc
