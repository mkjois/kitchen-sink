'use strict'

# Node modules
bodyParser = require 'body-parser'
express = require 'express'

# Jmoc modules
config = require './config'
middleware = require './middleware'
routes = require './routes'

# Initialize router
router = express.Router config.app.options

# Initialize middleware
router.use middleware.accessControl
router.use bodyParser.json limit: config.app.limits.json

# Set up all route middleware and handlers
for url, methods of routes
  for method, route  of methods
    if route.hasOwnProperty 'middleware'
      route.middleware.forEach (mw) ->
        router[method] url, mw
    router[method] url, route.handler

# Export
if module?
  module.exports = router
