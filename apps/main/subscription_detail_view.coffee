SubscriptionDetailView = Backbone.View.extend
  el: $('#center_panel2')
  
  initialize: ()-> 
  
  template: Handlebars.templates['subscription_detail_view.hbs']
  
  render: ()->
    #console.log "inside the view collection = #{JSON.stringify @collection.toJSON(),null,2}"
    @$el.empty()
    @$el.html @template
      name: "Netflix"
      description: "movie streaming service"
      username: "nidhirohatgi@hotmail.com"
      password: "********"
      plans: [ 
        { plan_id: 1, plan_name: 'Streaming' },
        { plan_id: 2, plan_name: 'DVD' },
        { plan_id: 3, plan_name: 'Streaming & DVD'} ]
      is_started: false
    @

subscription_detail_view = new SubscriptionDetailView 

main_app.add('views','subscription_detail_view',subscription_detail_view)