#!/bin/bash
#
# subs     This shell script takes care of starting and stopping node
#
# chkconfig: - 345 10 90
# description: leadformix integration server
#
### BEGIN INIT INFO
# Provides: leadformix integration server
# Should-Start: 
# Short-Description: This shell script takes care of starting and stopping lfx_intg
# Description: leadformix integration server
### END INIT INFO

## Source function library.
[ -f /etc/rc.d/init.d/functions ] && . /etc/rc.d/init.d/functions
SHUTDOWN_WAIT=20
rc=0
myname=`basename $0`
PORT=443
export PORT

subs_pid() {
  echo `ps aux | grep 'subs' | grep -v grep | grep -v $myname | awk '{ print $2 }'`
}

start() {
  pid=$(subs_pid)
  if [ -n "$pid" ] 
  then
    echo "subs is already running (pid: $pid)"
    rc=1
  else
    # Start node
    echo "Starting subs"
    ulimit -n 100000
    umask 007
    /usr/local/bin/node /Users/sumeet/github/subs/lib/ctrl.js start
  fi

  return 0
}

stop() {
  pid=$(subs_pid)
  if [ -n "$pid" ]
  then
    echo "Stoping lfx_intg with ($pid)"
    /usr/local/bin/node /Users/sumeet/github/subs/lib/ctrl.js stop

    let kwait=$SHUTDOWN_WAIT
    count=0;
    until [ `ps -p $pid | grep -c $pid` -eq 0 ] || [ $count -gt $kwait ]
    do
      echo -n -e "\nwaiting for processes to exit";
      sleep 1;
      let count=$count+1;
    done

    if [ $count -gt $kwait ]; then
      echo -n -e "\nkilling processes which didn't stop after $SHUTDOWN_WAIT seconds"
      kill -9 $pid
    fi
  else
    echo "subs is not running"
    rc=2
  fi
 
  return 0
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
  pid=$(subs_pid)
  if [ -n "$pid" ]
  then
    echo "subs is running with pid: $pid"
  else
    echo "subs is not running"
  fi
;; 
esac    
exit $rc