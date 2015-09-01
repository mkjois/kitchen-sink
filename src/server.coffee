'use strict'

# Node modules
bodyParser = require 'body-parser'
express = require 'express'
fs = require 'fs'
http = require 'http'
https = require 'https'

# U/page modules
api = require './api'

# Important for process termination on failures
process.title = api.config.proc.title

# Initialize app and settings
app = express()
for setting in api.config.app.enable
  app.enable setting

# Redirect http to https
app.use (req, res, next) ->
  if not req.secure and req.hostname isnt 'localhost'
    host = req.get 'host'
    res.redirect 308, "https://#{ host }#{ req.originalUrl }"
  else
    next()

# Set Access-Control-* headers
app.use (req, res, next) ->
  res.set api.config.app.access
  next()

# Middleware initializers
app.use bodyParser.json limit: api.config.app.limits.json

# Set up all route middleware and handlers
for url, methods of api.routes
  for method, route  of methods
    if route.hasOwnProperty 'middleware'
      route.middleware.forEach (mw) ->
        app[method] url, mw
    app[method] url, route.handler

httpServer = http.createServer app
httpPort = api.config.proc.port.http

dieWithHonor = () ->
  die = (err) ->
    if err
      console.error err
      process.exit 1
    else
      process.exit 0
  httpServer.close die

process.on 'SIGINT', dieWithHonor
process.on 'SIGTERM', dieWithHonor

httpServer.listen httpPort
