LoginView = Backbone.View.extend
	el: $('#center_panel')
	
	class: "span12"

	initialize: ()-> @render()
	
	template: Handlebars.templates['login_view.hbs']
	
	hide: -> @$el.hide()

	show: -> @$el.show()

	render: ()->
		console.log "inside login view"
		@$el.empty()
		@$el.html @template( {} )
		@

login_view = new LoginView 

login_view2 = new LoginView 

main_app.add('views','login_view',login_view)
