winston = require("winston")
conf =
  filename: __dirname + "/../subs.log"
  handleExceptions: true
  json: false
  level: "info"
  timestamp: true

transports = []
transports.push new winston.transports.File(conf)
module.exports = new winston.Logger(
  exitOnError: false
  transports: transports
)