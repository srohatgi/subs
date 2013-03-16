Accounts = Backbone.Model.extend
	defaults: 
		name: "noname"
		type: "notype"
		sex: "male"
		id: "me"

	url: "/api/accounts/me"

account = new Accounts

main_app.add('models','account',account)