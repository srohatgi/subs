SubscriptionsView = Backbone.View.extend
	el: $('#slide_panel')
	
	initialize: ()-> @render()
	
	template: Handlebars.templates['subscription_view.hbs']
	
	render: ()->
		#console.log "inside the view collection = #{JSON.stringify @collection.toJSON(),null,2}"
		@$el.empty()
		@$el.html @template( subscription: @collection.toJSON() )
		@

subscription_view = new SubscriptionsView 
	collection: main_app.get('models','subscriptions')
