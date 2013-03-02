SubscriptionsView = Backbone.View.extend
	initialize: ()-> @render()
	render: ()->
		$(@el).html Handlebars.templates['subscription_view.hbs']()
		@

subscription_view = new SubscriptionsView el: $('#slide_panel')