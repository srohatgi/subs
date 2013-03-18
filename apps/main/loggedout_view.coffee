LoggedoutView = Backbone.View.extend
	el: $('#center_panel1')
	
	class: "span12"

	initialize: ()-> @render()
	
	template: Handlebars.templates['loggedout_view.hbs']
	
	hide: -> @$el.hide()

	show: -> @$el.show()

	render: ()->
		console.log "inside loggedout_view"
		@$el.empty()
		@$el.html @template( {} )
		@

loggedout_view = new LoggedoutView 

main_app.add('views','loggedout_view',loggedout_view)
