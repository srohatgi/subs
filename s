#!/bin/bash


function control_c
{
  pid=`ps aux | grep mongod | grep -v grep | awk '{ print $2 }'`
  if [[ "$pid" == "" ]] 
  then 
    echo "unable to locate mongod pid" 
  else
    echo "stopping mongod with $pid"
    kill $pid
  fi
}

trap control_c SIGINT
make
rm -f data/mongod.log.*
scripts/mongod_init.sh
nodemon -e '.coffee|.jade|.json|.html|.css|.hbs' server/lib/dev.js
