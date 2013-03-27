{mongoose} = require './common_db_utils'
{log} = require '../appconfig'

ServicesSchema = mongoose.Schema
  name: String
  type: String
  description: String
  plans: [{ plan_id: String, plan_name: String, plan_type: String }]
  create_date: Date
  update_date: Date

Service = mongoose.model 'Service', ServicesSchema

module.exports = 
  save: (json,cb)->
    log.info "trying to save json: #{JSON.stringify json}"
    svc = new Service json
    svc.save (err)->
      return cb(err) if err
      cb null, svc