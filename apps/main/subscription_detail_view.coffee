SubscriptionDetailView = Backbone.View.extend
	el: $('#center_panel2')
	
	initialize: ()-> 
	
	template: Handlebars.templates['subscription_detail_view.hbs']
	
	render: ()->
		#console.log "inside the view collection = #{JSON.stringify @collection.toJSON(),null,2}"
		@$el.empty()
		@$el.html @template( { name: "Netflix", description: "Movie streaming service" } )
		@

subscription_detail_view = new SubscriptionDetailView 

main_app.add('views','subscription_detail_view',subscription_detail_view)