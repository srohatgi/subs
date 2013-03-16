StatusView = Backbone.View.extend
	el: $('#status_panel')
	
	initialize: ()-> 
	
	template: Handlebars.templates['status_view.hbs']

	update: ()-> this.model.fetch()
	
	render: ()->
		console.log "inside the status view #{JSON.stringify(this.model.attributes)}"
		@$el.empty()
		@$el.html @template( this.model.attributes )
		@

account = main_app.get('models','account')

status_view = new StatusView model: account

main_app.add('views','status_view',status_view)