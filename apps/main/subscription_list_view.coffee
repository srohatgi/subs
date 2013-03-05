SubscriptionListView = Backbone.View.extend
	el: $('#side_panel')
	
	initialize: ()-> @render()
	
	template: Handlebars.templates['subscription_list_view.hbs']
	
	render: ()->
		#console.log "inside the view collection = #{JSON.stringify @collection.toJSON(),null,2}"
		@$el.empty()
		@$el.html @template( subscription: @collection.toJSON() )
		@

subscription_list_view = new SubscriptionListView 
	collection: main_app.get('models','subscriptions')

main_app.add('views','subscription_list_view',subscription_list_view)