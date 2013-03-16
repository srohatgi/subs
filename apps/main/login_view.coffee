LoginView = Backbone.View.extend
	el: $('#center_panel')
	
	initialize: ()-> @render()
	
	template: Handlebars.templates['login_view.hbs']
	
	render: ()->
		#console.log "inside the view collection = #{JSON.stringify @collection.toJSON(),null,2}"
		@$el.empty()
		@$el.html @template( {} )
		@

login_view = new LoginView 

main_app.add('views','login_view',login_view)