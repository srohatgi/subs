winston = require 'winston'
fs = require 'fs'

rundir = process.argv[2] if process.argv.length > 2
watchmode = !rundir

config = eval '('+fs.readFileSync("#{__dirname}/config.json",'utf-8')+')'

transports = []
accesslog = "dev"

if watchmode
  transports.push new (winston.transports.Console)(
    level: 'info'
    colorize: true  
    timestamp: true
  )
else
  applog = "#{rundir}/subs.log"
  flags = flags: 'a', encoding: 'utf-8', mode: 0o644
  transports.push new (winston.transports.File)(
    stream: fs.createWriteStream(applog, flags)
    handleExceptions: true
    json: false
    level: 'info'
    timestamp: true
  )
  accesslog = format: 'default', stream: fs.createWriteStream("#{rundir}/access.log", flags)

applogger = new (winston.Logger)(
  exitOnError: false
  transports: transports
)

log = 
  ip: (req)-> req.headers?["x-forwarded-for"] || req.connection?.remoteAddress
  accesslog: accesslog
  format_msg: (req,msg)-> "[url:#{req.url}] [pid:#{process.pid}] [ip:#{@ip req}] [msg:#{msg}]"
  reqInfo: (req,msg)->
    @info @format_msg(req,msg)
  reqWarn: (req,msg)->
    @warn @format_msg(req,msg)
  reqError: (req,msg)->
    @error @format_msg(req,msg)
    
applogger.extend log

exports.log = log
exports.watchmode = watchmode
exports.config = config
