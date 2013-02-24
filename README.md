# Subsimple

## Developing

In your development box:
  
    $ cd subs
    $ s.sh
  
## Configuring

### SSL Certificates

To update the default installed self signed certificate with correct one.

    # cp correct-server.key subs/cert/server.key
    # cp correct-server.crt subs/cert/server.crt    

### Shared Secrets

As per `subs/config.json`:

		{
			"port": {
				"unsecure": (function() { return process.env.PORT || 3000; })(),
				"secure": (function() { if (process.env.PORT) return 443; else return 3000+1; })()
			},
			"facebook": {
				"shared_secret": process.env.FACEBOOK_SECRET
			}
		}

Define appropriate env variables.