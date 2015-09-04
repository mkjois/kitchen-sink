'use strict'

# Configuration file allowing for arbitrary CoffeeScript

if module?
  module.exports =
    app:
      enable: [
        'strict routing'  # distinguish trailing slashes in urls
        'trust proxy'     # trust ELB X-Forwarded-* headers
      ]
    misc:
      pong: 'You have received a singular pong.'
    proc:
      port:
        http: 5056
        https: 5058
      title: 'NODE_KITCHEN_SINK'
