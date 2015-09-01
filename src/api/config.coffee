'use strict'

if module?
  module.exports =
    app:
      access:
        'Access-Control-Allow-Credentials': false
        'Access-Control-Allow-Headers'    : 'Content-Type'
        'Access-Control-Allow-Methods'    : 'GET, POST, PUT, PATCH, DELETE, HEAD, OPTIONS'
        'Access-Control-Allow-Origin'     : '*'
        'Access-Control-Max-Age'          : 86400
      enable: [
        'strict routing'  # distinguish trailing slashes in urls
        'trust proxy'     # trust ELB X-Forwarded-* headers
      ]
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
            name: 'mockery-urls'
            hash: 'Id'
        version: '2012-08-10'
    crypt:
      len:
        urlhash: 12
    misc:
      pong: 'You have received a singular pong.'
    proc:
      port:
        http : 5056
        https: 5058
      title: 'NODE_MOCKERY'
    regex:
      urlhash: /^[a-zA-Z0-9_-]{16}$/
    ssl:
      cert: 'ssl/mockery.self.crt.pem'
      key : 'ssl/mockery.key.pem'
