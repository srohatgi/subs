{mongoose} = require './common_db_utils'

accountSchema = mongoose.Schema
  first_name: String 
  last_name: String 
  sex: String
  facebook_id: Number
  email: String
  password: String

Account = mongoose.model 'Account', accountSchema

module.exports = 
  save: (json,cb)->
    acct = new Account json
    acct.save (err,obj)->
      return cb(err) if err
      cb(null,obj._id)
