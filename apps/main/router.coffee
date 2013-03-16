bootup = ()->
	subscription_detail_view = main_app.get('views','subscription_detail_view')
	subscription_list_view = main_app.get('views','subscription_list_view')
	login_view = main_app.get('views','login_view')
	logged_in = false

	MainRouter = Backbone.Router.extend
		routes: 
			"subscription_detail/:model_name": "setupViews"
			"*actions": "defaultRoute"

		setupViews: (model_name)->
			console.log "detail for #{model_name} requested"
			subscription_list_view.render()
			subscription_detail_view.render()

	main_router = new MainRouter

	main_router.on 'route:defaultRoute', (actions)->
		alert('hello')
		login_view.render()

	main_app.add('routers','main_router',main_router)

	Backbone.history.start()

$(document).ready(bootup)