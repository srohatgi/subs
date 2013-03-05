SubscriptionsView = Backbone.View.extend
	el: $('#slide_panel')
	
	initialize: ()-> @render()
	
	template: Handlebars.templates['subscription_view.hbs']
	
	render: ()->
		#console.log "inside the view collection = #{JSON.stringify @collection,null,2}"
		@$el.empty()
		hack = JSON.parse JSON.stringify({ subscription: @collection })
		@$el.html @template(hack)
		@

subscription_view = new SubscriptionsView 
	collection: window.App.models["subscriptions"] 