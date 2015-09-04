'use strict'


# Any interesting middleware goes here
middleware =

  # Tell the user agent not to cache the response
  noCache: (req, res, next) ->
    res.set
      'Cache-Control': 'private, no-cache, no-store, must-revalidate'
      'Expires': '-1'
      'Pragma': 'no-cache'
    next()

  # Redirect http to https
  httpsRedirect: (req, res, next) ->
    if not req.secure and req.hostname isnt 'localhost'
      host = req.get 'host'
      res.redirect 308, "https://#{ host }#{ req.originalUrl }"
    else
      next()


if module?
  module.exports = middleware
