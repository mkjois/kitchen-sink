'use strict'

# Node modules
bodyParser = require 'body-parser'
express = require 'express'
http = require 'http'
path = require 'path'

# Kitchen Sink modules
config = require './config'
middleware = require './middleware'
routes = require './routes'

# Routers
jmoc = require './jmoc'

# Important for process termination on failures
process.title = config.proc.title

# Initialize app and settings
app = express()
for setting in config.app.enable
  app.enable setting

# Mount routers
app.use '/jmoc', middleware.httpsRedirect, jmoc

# Set up all route middleware and handlers
for url, methods of routes
  for method, route  of methods
    if route.hasOwnProperty 'middleware'
      route.middleware.forEach (mw) ->
        app[method] url, mw
    app[method] url, route.handler

# Static middleware
app.use '/static', middleware.httpsRedirect, express.static path.join process.cwd(), '/static'

# Create HTTP[S] servers
httpServer = http.createServer app
httpPort = config.proc.port.http

# Custom termination handling
dieWithHonor = () ->
  die = (err) ->
    if err
      console.error err
      process.exit 1
    else
      process.exit 0
  httpServer.close die

# Register termination handler
process.on 'SIGINT', dieWithHonor
process.on 'SIGTERM', dieWithHonor

# Listen
httpServer.listen httpPort
