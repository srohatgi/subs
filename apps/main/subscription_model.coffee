Subscription = Backbone.Model.extend
  defaults: 
    id: "unknown"
    name: "noname"
    type: "notype"
    description: "nodescription"
    billing: "monthly"
    amount: 0
    username: null
    password: null

Subscriptions = Backbone.Collection.extend
  model: Subscription

  url: "/api/subscriptions/me"

  parse: (response)-> 
    console.log "Subscriptions fetched: #{JSON.stringify response}"
    response.payload.subscriptions

subscriptions = new Subscriptions

#for model_name in [ "Netflix", "Vonage", "LinkedIn" ]
# s = new Subscription({ name: model_name })
# subscriptions.add(s)

console.log "model(#{s.cid}): #{JSON.stringify(s)}" for s in subscriptions.models 

main_app.add('models','subscriptions',subscriptions)