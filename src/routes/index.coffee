log = require("../log")
exports.index = (req, res) ->
  log.info "process doc root request"
  res.render "ns",
    title: "Sub Simple Server"


exports.flower = (req, res) ->
  res.render "flower",
    title: "flower shop"
