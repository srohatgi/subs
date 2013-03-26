{log,config} = require '../appconfig'
passport = require 'passport'
{Strategy} = require 'passport-facebook'
accounts_db = require '../data/accounts_db'

passport.serializeUser (user, done)-> 
  log.info "serialize user = #{user.facebook_id}"
  done(null, user.facebook_id)

passport.deserializeUser (facebook_id, done)-> 
  log.info "deserialize facebook_id = #{facebook_id}"
  accounts_db.get facebook_id: facebook_id, (err, user)-> done err, user

passport.use new Strategy
  clientID: config.facebook.id
  clientSecret: config.facebook.shared_secret
  callbackURL: "https://#{config.facebook.server}:#{config.port.secure}/auth/facebook/callback"
  passReqToCallback: true
, (req, accessToken, refreshToken, profile, done)->
  if not req.user 
    profile._json.facebook_id = profile._json.id
    delete profile._json.id
    accounts_db.save profile._json, (err,obj)-> done err, profile._json
  else
    done null, req.user


module.exports = 
  facebook: passport.authenticate 'facebook'

  facebook_cb: passport.authenticate 'facebook', 
    successRedirect: '/#logged_in' 
    failureRedirect: '/#login'