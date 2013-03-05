bootup = ()->
	MainRouter = Backbone.Router.extend
		routes: 
			"*actions": "defaultRoute"

	main_router = new MainRouter

	main_router.on 'route:defaultRoute', (actions)-> alert(actions)

	console.log "hello = world"

	window.App.routers.main_router = main_router

	Backbone.history.start()

$(document).ready(bootup)