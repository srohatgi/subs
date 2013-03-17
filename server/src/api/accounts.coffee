{log} = require '../appconfig'
{wrapper,error_codes,set_header} = require './common_utils'

data = [
 { 
 id: "1" 
 name: 'sumeet rohatgi'
 },
 {
 	id: "2"
 	name: 'nidhi rohatgi'
 }
]

find_data = (id)->	
  for d in data
    return d if d.id == id 
  return null

module.exports = 
  get: (req,res)->
    log.info "user = #{JSON.stringify req.user, null, 2}"
    return res.end wrapper null, error_codes.NOT_FOUND, 'unknown account' if not req.user 
    res.end wrapper req.user 

  put: (req,res)->
    log.info "id = #{req.params.id} body = #{JSON.stringify req.body}"
    return res.end wrapper null, error_codes.NOT_FOUND, "need to login first" if not req.user

    d[prop] = req.body[prop] for prop of req.body
    res.end wrapper()

  delete: (req,res)->
    log.info "logging out #{JSON.stringify req.user}"
    req.session.destroy() if req.session
    res.end wrapper()