{log,config} = require('../appconfig')
passport = require('passport')
FacebookStrategy = require('passport-facebook').Strategy;

passport.serializeUser (user, done)-> 
  log.info "user = #{user}"
  done(null, user)

passport.deserializeUser (obj, done)-> 
  log.info "obj = #{JSON.stringify(obj,null,2)}"
  done(null, obj)

passport.use new FacebookStrategy(
  clientID: config.facebook.id,
  clientSecret: config.facebook.shared_secret,
  callbackURL: "https://localhost:#{config.port.secure}/auth/facebook/callback"
, (accessToken, refreshToken, profile, done)->
  #User.findOrCreate(..., function(err, user) {
  #  if (err) { return done(err); }
  #  done(null, user);
  #});
  log.info "accessToken: #{accessToken} profile: #{JSON.stringify profile._json, null, 2}"
  done null, profile._json
)

module.exports = (app)->
  app.get '/auth/facebook', passport.authenticate('facebook')

  app.get '/auth/facebook/callback', passport.authenticate('facebook', 
    successRedirect: '/#logged_in' 
    failureRedirect: '/#login'
  )