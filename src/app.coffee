express = require("express")
routes = require("./routes")
http = require("http")
https = require("https")
fs = require("fs")
path = require("path")
log = require("./log")

app = express.createServer(
  key: fs.readFileSync("#{__dirname}/../cert/server.key", "utf-8")
  cert: fs.readFileSync("#{__dirname}/../cert/server.crt", "utf-8")
)

port = process.env.PORT or 3000

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
  app.set "views", path.join(__dirname, "views")
  app.set "view engine", "jade"
  app.set "view options",
    layout: false

  app.use express.favicon(path.join(__dirname, "public", "images", "favicon.ico"))
  app.use express.logger("dev")
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(path.join(__dirname, "public"))

app.configure "development", ->
  app.use express.errorHandler()

app.get "/", routes.index
app.get "/flower", routes.flower
app.get "/js/tnt.js", require("./routes/tnt")

app.listen port

log.info "subsimple https server listening on port " + port