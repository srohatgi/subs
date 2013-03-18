StatusView = Backbone.View.extend
  el: $('#status_panel')
  
  initialize: ()-> 
    @listenTo(@model, "change", @render);
  
  template: Handlebars.templates['status_view.hbs']

  update: (@logged_in)-> @model.fetch()
  
  render: ()->
    console.log "inside the status view #{JSON.stringify(@model.attributes)}"
    if @model.attributes.error != "200"
      main_app.get('routers','main_router').navigate('#logout',trigger: true)
      return
    @logged_in.status = true
    @$el.empty()
    @$el.html @template( @model.attributes )
    @

account = main_app.get('models','account')

status_view = new StatusView model: account

main_app.add('views','status_view',status_view)