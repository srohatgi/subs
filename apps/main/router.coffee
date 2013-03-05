bootup = ()->
	MainRouter = Backbone.Router.extend
		routes: 
			"subscription/:name": "setupViews"
			"*actions": "defaultRoute"

		setupViews: (name)->
			console.log "detail on #{name} requested"
			subscription_detail_view = main_app.get('views','subscription_detail_view')
			subscription_list_view = main_app.get('views','subscription_list_view')

			subscription_list_view.render()
			subscription_detail_view.render()

	main_router = new MainRouter

	main_router.on 'route:defaultRoute', (actions)-> alert(actions)

	console.log "hello world app"

	main_app.add('routers','main_router',main_router)

	Backbone.history.start()

$(document).ready(bootup)