winston = require 'winston'
fs = require 'fs'

rundir = process.argv[2] if process.argv.length > 2
watchmode = !rundir

transports = []
accesslog_stream = process.stdout

if watchmode
  transports.push new (winston.transports.Console)(
    level: 'info'
    colorize: true
    timestamp: true
  )
else
  applog = "#{rundir}/subs.log"
  transports.push new (winston.transports.File)(
    stream: fs.createWriteStream(applog, { flags: 'a', encoding: 'utf-8', mode: 0o644 })
    handleExceptions: true
    json: false
    level: 'info'
    timestamp: true
  )
  accesslog_stream = fs.createWriteStream("#{rundir}/access.log", {flags: 'a', encoding: 'utf-8', mode: 0o644})

applogger = new (winston.Logger)(
  exitOnError: false
  transports: transports
)

log = 
  ip: (req)-> req.headers?["x-forwarded-for"] || req.connection?.remoteAddress
  accesslog_stream: accesslog_stream
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
