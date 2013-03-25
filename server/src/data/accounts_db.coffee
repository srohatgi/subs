{mongoose} = require './common_db_utils'
{log} = require '../appconfig'

AccountSchema = mongoose.Schema
  facebook_id: String
  name: String
  first_name: String
  last_name: String
  link: String
  username: String
  gender: String
  timezone: Number
  locale: String 
  verified: Boolean
  updated_time: String

Account = mongoose.model 'Account', AccountSchema

module.exports = 
  save: (json,cb)->
    Account.findOne facebook_id: json.facebook_id, (err,acct)->
      return cb err if err
      return cb null,acct if acct 
      acct = new Account json
      log.info "trying to save json: #{JSON.stringify json}"
      acct.save (err)->
        return cb(err) if err
        cb null, acct

  get: (json,cb)->
    Account.findOne facebook_id: json.facebook_id, (err,acct)->
      return cb err if err
      return cb error: 'not found' if not acct
      cb null, acct 