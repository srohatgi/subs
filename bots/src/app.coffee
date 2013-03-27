page = require("webpage").create()
server = require("webserver").create()
system = require("system")

data = "universe=expanding&answer=42"

if system.args.length isnt 2
  console.log "Usage: postserver.js <portnumber>"
  phantom.exit 1

port = system.args[1]

service = server.listen port, (request, response) ->
  console.log "#{new Date()}: Request received: #{JSON.stringify request.post}" 
  response.statusCode = 200
  response.headers =
    Cache: "no-cache"
    "Content-Type": "text/plain;charset=utf-8"

  phantom.exit() if request.post?.exit is "true"

  do_work(request.post.url) if request.post?.url 

  response.write JSON.stringify(request, null, 4)

  response.close()

do_work = (url)-> 
  console.log "url received: #{url}"
  page.open url, (status)->
    console.log "#{status} to open webpage: #{url}"

page.open "http://localhost:" + port + "/", "post", data, (status) ->
  if status isnt "success"
    console.log "Unable to post!"
  else
    console.log page.plainText
  #phantom.exit()