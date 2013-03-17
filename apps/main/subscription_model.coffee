Subscription = Backbone.Model.extend
	defaults: 
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

subscriptions = new Subscriptions

for model_name in [ "Netflix", "Vonage", "LinkedIn" ]
	s = new Subscription({ name: model_name })
	subscriptions.add(s)

console.log "model(#{s.cid}): #{JSON.stringify(s)}" for s in subscriptions.models	

main_app.add('models','subscriptions',subscriptions)