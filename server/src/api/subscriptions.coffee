{log} = require '../appconfig'
{wrapper,error_codes} = require './common_utils'

data = 
  [ 
    { id: "s1", name: "Netflix",  type: "Movie Streaming" },
    { id: "s2", name: "LinkedIn", type: "Career Network" }
  ]

module.exports = 
  get: (req,res)->
    res.end wrapper data

  post: (req,res)->
    data.push req.body
    res.end wrapper 

  put: (req,res)->
    for d in data 
      if d.id == req.params.id 
        d[prop] = req.body[prop] for prop of req.body
        return res.end wrapper 

    res.end wrapper null, error_codes.NOT_FOUND, 'no such subscription exists'