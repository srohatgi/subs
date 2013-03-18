bootup = ()->
  subscription_detail_view = main_app.get('views','subscription_detail_view')
  subscription_list_view = main_app.get('views','subscription_list_view')
  loggedout_view = main_app.get('views','loggedout_view')
  status_view = main_app.get('views','status_view')

  account = main_app.get('models','account')

  logged_in = status: false

  MainRouter = Backbone.Router.extend
    routes: 
      "subscription_detail/:model_name": "setupAppViews"
      "logged_in": "logged_in"
      "logout": "logout"
      "*actions": "defaultRoute"

    logout: ->
      console.log "logout called"
      status_view.remove()
      subscription_list_view.remove()
      loggedout_view.show()

    logged_in: -> 
      loggedout_view.hide()
      status_view.update(logged_in)
      subscription_list_view.update()

    setupAppViews: (model_name)->
      console.log "detail for #{model_name} requested; logged_in: #{JSON.stringify logged_in}"
      return if logged_in.status == false 
      subscription_list_view.render()
      subscription_detail_view.render()

  main_router = new MainRouter
  main_router.on 'route:defaultRoute', (actions)-> loggedout_view.render()
  main_app.add('routers','main_router',main_router)

  Backbone.history.start()

$(document).ready(bootup)