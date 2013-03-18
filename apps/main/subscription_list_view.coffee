SubscriptionListView = Backbone.View.extend
	el: $('#side_panel')
	
	initialize: -> 
		console.log "inside subscription list view, @collection= #{@collection}"
		@listenTo(@collection, "add", @render);
	
	template: Handlebars.templates['subscription_list_view.hbs']

	update: -> @collection.fetch( update: true )
	
	render: ->
		console.log "inside the subscription list view collection = #{JSON.stringify @collection.toJSON(),null,2}"
		@$el.empty()
		@$el.html @template( subscription: @collection.toJSON() )
		@

subscription_list_view = new SubscriptionListView 
	collection: main_app.get('models','subscriptions')

main_app.add('views','subscription_list_view',subscription_list_view)