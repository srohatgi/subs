# Subsimple Server Guide

## Building

In your development box:
  
    $ git checkout http://github/~srohatgi/subs subs
    $ cd subs
    $ make clean all
    $ ls -l server.tar.gz
    -rw-r--r--  1 sumeet  staff  874128 Nov  4 09:08 server.tar.gz
  
## Deploying

In your deployment box (as root):

    # tar xvzf server.tar.gz
    # mkdir -p run
    # cd run
    # cp ../server/scripts/subs_init.sh .
    # chmod 755 subs_init.sh

## Configuring

### SSL Certificates

To update the default installed self signed certificate with correct one.

    # cp correct-server.key server/cert/server.key
    # cp correct-server.crt server/cert/server.crt

## Starting

    # ./subs_init.sh start
    Starting subs
    Starting subs daemon...
    subs daemon started. PID: 5436
    
## Stopping

    # ./subs_init.sh stop
    Stoping subs with (5436)
    Stopping subs daemon...

## Monitoring and Troubleshooting

    # head run/subs.log
    2012-11-04T17:06:32.697Z - info: subs integration https server listening on port 443
    2012-11-04T17:06:50.240Z - info: process request for ns portal
    