express = require("express")
routes = require("./routes")
http = require("http")
https = require("https")
fs = require("fs")
path = require("path")
passport = require('passport')
FacebookStrategy = require('passport-facebook').Strategy;
{log} = require("./log")
{config} = require("./log")

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

https.createServer(
  key: fs.readFileSync "#{__dirname}/../cert/server.key", 'utf-8'
  cert: fs.readFileSync "#{__dirname}/../cert/server.crt", 'utf-8'
, app)
.listen config.port.secure

#server.listen config.port.secure

# redirect all unsecure requests to https
http.createServer (req,res)->
  res.writeHead 301, {'Location': "https://#{req.headers.host.split(':')[0]}:#{sport}#{req.url}"}
  res.end()
.listen config.port.unsecure

log.info "subsimple https server listening on ports #{config.port.unsecure}, #{config.port.secure}"
