# Subsimple

## Building

In your development box:
  
    $ cd subs
    $ make
    $ nodemon -e '.coffee|.jade' lib/
  
## Configuring

### SSL Certificates

To update the default installed self signed certificate with correct one.

    # cp correct-server.key server/cert/server.key
    # cp correct-server.crt server/cert/server.crt    