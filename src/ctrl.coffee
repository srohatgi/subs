daemon = require("daemonize2").setup(
  main: "app.js"
  name: "subs"
  pidfile: __dirname + "/../run/subs.pid"
)
switch process.argv[2]
  when "start"
    daemon.start()
  when "stop"
    daemon.stop()
  else
    console.log "Usage: [start|stop]"