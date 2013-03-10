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

	localStorage: new Backbone.LocalStorage("subscriptions-backbone")

subscriptions = new Subscriptions

subscriptions.add [ 
	{ name: "Netflix" }, 
	{ name: "Vonage" }, 
	{ name: "RedBox" }, 
	{ name: 'YouSendIt'} 
]

subscriptions.on "sync", (col,res,options)->
	console.log "succesful sync"

subscriptions.on "error", (col,xhr,options)->
	console.log "error in sync #{col}:#{xhr}:#{options}"

try
	console.log "model(#{s.cid}): #{JSON.stringify(s)}" for s in subscriptions.models	
	subscriptions.sync("create",subscriptions)
	console.log "added all models to localStorage"
catch e
	console.log "error: #{e}"

main_app.add('models','subscriptions',subscriptions)