mongoose = require 'mongoose'

mongoose.connect('mongodb://localhost/mydb')
db = mongoose.connection
db.on 'error', log.error.bind console, 'connection error'
db.once 'open', -> log.info "connected to mongodb!!"

exports.mongoose = mongoose
