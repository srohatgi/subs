{log} = require '../appconfig'
{wrapper,error_codes} = require './common_utils'

data = 
  [ 
    { id: "s1", name: "Netflix",  type: "Movie Streaming" },
    { id: "s2", name: "LinkedIn", type: "Career Network" }
  ]

module.exports = 
  get: (req,res)->
    log.info "data = {subscriptions: #{JSON.stringify data,null,2}}"
    res.send.apply res, wrapper subscriptions: data

  post: (req,res)->
    data.push req.body
    res.send.apply res, wrapper 

  put: (req,res)->
    for d in data 
      if d.id == req.params.id 
        d[prop] = req.body[prop] for prop of req.body
        return res.end wrapper 

    res.send.apply res, wrapper null, error_codes.NOT_FOUND, 'no such subscription exists'

  delete: (req,res)-> res.send 200, {}