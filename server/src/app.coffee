express = require("express")
routes = require("./routes")
api = require("./api")
http = require("http")
https = require("https")
fs = require("fs")
path = require("path")
{log,config} = require("./appconfig")
passport = require('passport')

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
  
  app.set "views", "#{__dirname}/../views"
  app.set "view engine", "jade"
  app.set "view options",
    layout: false

  app.use express.favicon "#{__dirname}/../public/favicon.ico"
  app.use express.logger log.accesslog
  app.use express.cookieParser()
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.session secret: 'keyboard cat'   
  app.use passport.initialize()
  app.use passport.session()
  app.all "/api/*", (req,res,next)->
    res.header 'Content-Type', 'application/json'
    next()
  app.use app.router
  app.use express.static "#{__dirname}/../public"

app.configure "development", -> app.use express.errorHandler()

app.get "/", (req,res)-> 
  fs.createReadStream("#{__dirname}/../public/main-index.html").pipe(res)

app.get "/api/subscriptions/:id(*)", api.subscriptions.get
app.post "/api/subscriptions/:id(*)", api.subscriptions.post
app.put "/api/subscriptions/:id(*)", api.subscriptions.put

app.get "/api/accounts/:id(*)", api.accounts.get
app.put "/api/accounts/:id(*)", api.accounts.put
app.delete "/api/accounts/:id(*)", api.accounts.delete 

# define login routes for facebook
routes.facebook_login('/auth',app)

https.createServer(
  key: fs.readFileSync "#{__dirname}/../cert/server.key", 'utf-8'
  cert: fs.readFileSync "#{__dirname}/../cert/server.crt", 'utf-8'
, app)
.listen config.port.secure

# redirect all unsecure requests to https
http.createServer (req,res)->
  res.writeHead 301, Location: "https://#{req.headers.host.split(':')[0]}:#{config.port.secure}#{req.url}"
  res.end()
.listen config.port.unsecure

log.info "subsimple http server listening on ports #{config.port.unsecure}, #{config.port.secure}"