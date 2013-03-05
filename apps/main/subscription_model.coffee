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

subscriptions = new Subscriptions

subscriptions.add [ { name: "Netflix" }, { name: "Vonage" }, { name: "RedBox" }, { name: 'YouSendIt'} ]

main_app.add('models','subscriptions',subscriptions)