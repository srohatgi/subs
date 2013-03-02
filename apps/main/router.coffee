MainRouter = Backbone.Router.extend
	routes: 
		"*actions": "defaultRoute"

main_router = new MainRouter

main_router.on 'route:defaultRoute', (actions)-> alert(actions)

Backbone.history.start()