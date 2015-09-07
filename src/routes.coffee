'use strict'

# Kitchen Sink modules
config = require './config'
middleware = require './middleware'


# Explicitly set handlers and middleware for every route
routes =

  '/ping':

    get:
      handler: (req, res) ->
        pong = config.misc.pong
        res.type 'text/plain'
        res.send pong
      middleware: [ # list middleware in order
        middleware.noCache
      ]


  # TODO: send version/branch info, basic usage, disclaimers, etc.
  '/readme':

    get:
      handler: (req, res) ->
        res.sendStatus 501
      middleware: [
        middleware.httpsRedirect
      ]


  # easter egg
  '/youngblood':

    get:
      handler: (req, res) ->
        res.redirect 303, "https://www.youtube.com/watch?v=8DnKOc6FISU"
      middleware: [
        middleware.httpsRedirect
      ]


if module?
  module.exports = routes
