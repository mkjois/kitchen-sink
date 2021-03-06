// Generated by CoffeeScript 1.9.2
(function() {
  'use strict';
  var config, middleware, routes;

  config = require('./config');

  middleware = require('./middleware');

  routes = {
    '/ping': {
      get: {
        handler: function(req, res) {
          var pong;
          pong = config.misc.pong;
          res.type('text/plain');
          return res.send(pong);
        },
        middleware: [middleware.noCache]
      }
    },
    '/readme': {
      get: {
        handler: function(req, res) {
          return res.sendStatus(501);
        },
        middleware: [middleware.httpsRedirect]
      }
    },
    '/youngblood': {
      get: {
        handler: function(req, res) {
          return res.redirect(303, "https://www.youtube.com/watch?v=8DnKOc6FISU");
        },
        middleware: [middleware.httpsRedirect]
      }
    }
  };

  if (typeof module !== "undefined" && module !== null) {
    module.exports = routes;
  }

}).call(this);
