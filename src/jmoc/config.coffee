'use strict'

# Configuration file allowing for arbitrary CoffeeScript

if module?
  module.exports =
    app:
      access:
        'Access-Control-Allow-Credentials': false
        'Access-Control-Allow-Headers'    : 'Content-Type'
        'Access-Control-Allow-Methods'    : 'GET, POST, PUT, PATCH, DELETE, HEAD, OPTIONS'
        'Access-Control-Allow-Origin'     : '*'
        'Access-Control-Max-Age'          : 86400
      options:
        strict: true
      limits:
        json: '256kb'
        url: 7  # days
    aws:
      access:
        profile: 'mjois'
        region: 'us-west-2'
      ddb:
        tables:
          urls:
            name: 'jmoc-urls'
            hash: 'Id'
        version: '2012-08-10'
    crypt:
      len:
        urlhash: 12
    misc:
      pong: 'Your pong has arrived.'
    regex:
      urlhash: /^[a-zA-Z0-9_-]{16}$/  # Base64-URL
