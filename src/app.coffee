express = require("express")
routes = require("./routes")
http = require("http")
https = require("https")
fs = require("fs")
path = require("path")
{log,config} = require("./appconfig")

app = express()

app.use (req, res, next) ->
  # add CORS support for any site
  res.header "Access-Control-Allow-Origin", "*"
  res.header "Access-Control-Allow-Methods", "GET,PUT,POST,DELETE"
  res.header "Access-Control-Allow-Headers", "Content-Type, Authorization"
  if "OPTIONS" is req.method
    res.send 200
  else
    next()

app.configure ->
  app.set "views", path.join(__dirname, "..", "views")
  app.set "view engine", "jade"
  app.set "view options",
    layout: false

  app.use express.favicon(path.join(__dirname, "..", "public", "images", "favicon.ico"))
  app.use express.logger log.accesslog
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(path.join(__dirname, "..", "public"))

app.configure "development", ->
  app.use express.errorHandler()

app.get "/", routes.index
app.get "/flower", routes.flower

# facebook stuff
passport = require('passport')
FacebookStrategy = require('passport-facebook').Strategy;

passport.serializeUser (user, done)-> done(null, user)

passport.deserializeUser (obj, done)-> done(null, obj)

passport.use new FacebookStrategy(
  clientID: config.facebook.id,
  clientSecret: config.facebook.shared_secret,
  callbackURL: "https://localhost:#{config.port.secure}/auth/facebook/callback"
, (accessToken, refreshToken, profile, done)->
  #User.findOrCreate(..., function(err, user) {
  #  if (err) { return done(err); }
  #  done(null, user);
  #});
  log.info "accessToken: #{accessToken} profile: #{JSON.stringify profile, null, 2}"
  done null, profile
)

app.get '/auth/facebook', passport.authenticate('facebook')

app.get '/auth/facebook/callback', passport.authenticate('facebook', 
  successRedirect: '/' 
  failureRedirect: '/'
)

# done facebook stuff

https.createServer(
  key: fs.readFileSync "#{__dirname}/../cert/server.key", 'utf-8'
  cert: fs.readFileSync "#{__dirname}/../cert/server.crt", 'utf-8'
, app)
.listen config.port.secure

# redirect all unsecure requests to https
http.createServer (req,res)->
  res.writeHead 301, {'Location': "https://#{req.headers.host.split(':')[0]}:#{sport}#{req.url}"}
  res.end()
.listen config.port.unsecure

log.info "subsimple http server listening on ports #{config.port.unsecure}, #{config.port.secure}"