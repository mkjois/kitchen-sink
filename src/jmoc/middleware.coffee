'use strict'

# Jmoc modules
config = require './config'


# Any interesting middleware goes here
middleware =

  # Tell the user agent not to cache the response
  noCache: (req, res, next) ->
    res.set
      'Cache-Control': 'private, no-cache, no-store, must-revalidate'
      'Expires': '-1'
      'Pragma': 'no-cache'
    next()

  # Set Access-Control-* headers
  accessControl: (req, res, next) ->
    res.set config.app.access
    next()


if module?
  module.exports = middleware
