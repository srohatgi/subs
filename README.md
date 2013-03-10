# Subsimple

## Developing
  
    $ cd subs
    $ s
  
## Configuring

### SSL certificates

To update the default installed self signed certificate with correct one.

    # cp correct-server.key subs/server/cert/server.key
    # cp correct-server.crt subs/server/cert/server.crt    

### Other application settings

As per `subs/server/src/config.json`:

		{
			"port": {
				"unsecure": (function() { return process.env.PORT || 3000; })(),
				"secure": (function() { if (process.env.PORT) return 443; else return 3000+1; })()
			},
			"facebook": {
				"shared_secret": process.env.FACEBOOK_APP_KEY
				"id": (function() { return process.env.FACEBOOK_APP_ID || 371900149592754; })()
			}
		}

Define appropriate env variables.