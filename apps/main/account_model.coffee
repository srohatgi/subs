Accounts = Backbone.Model.extend
  defaults: 
    error: "404"
    message: "not logged in"
    payload: 
      name: "noname"
      type: "notype"
      sex: "male"
      id: "me"

  url: "/api/accounts/me"

account = new Accounts

main_app.add('models','account',account)