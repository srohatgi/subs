#!/bin/bash


function control_c
{
  scripts/mongod_init.sh stop
}

trap control_c SIGINT
make
rm -f data/mongod.log.*
scripts/mongod_init.sh start
nodemon -e '.coffee|.jade|.json|.html|.css|.hbs' server/lib/dev.js
