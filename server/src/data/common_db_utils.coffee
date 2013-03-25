mongoose = require 'mongoose'
{config,log} = require '../appconfig'

mongoose.connect(config.mongodb.connection)
db = mongoose.connection
db.on 'error', log.error.bind console, 'connection error'
db.once 'open', -> log.info "connected to #{config.mongodb.connection}!!"

exports.mongoose = mongoose
exports.db = db