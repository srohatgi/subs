SubscriptionsView = Backbone.View.extend
	el: $('#slide_panel')
	
	initialize: ()-> @render()
	
	template: Handlebars.templates['subscription_view.hbs']
	
	render: ()->
		console.log "inside the view collection = #{JSON.stringify @collection,null,2}"
		@$el.empty()
		@$el.html @template(@collection)
		@

subscription_view = new SubscriptionsView 
	collection: { subscription: window.App.models["subscriptions"] } 