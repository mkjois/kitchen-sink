'use strict'


middleware =

  noCache: (req, res, next) ->
    res.set
      'Cache-Control': 'private, no-cache, no-store, must-revalidate'
      'Expires': '-1'
      'Pragma': 'no-cache'
    next()


if module?
  module.exports = middleware
