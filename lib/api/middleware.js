// Generated by CoffeeScript 1.9.2
(function() {
  'use strict';
  var middleware;

  middleware = {
    noCache: function(req, res, next) {
      res.set({
        'Cache-Control': 'private, no-cache, no-store, must-revalidate',
        'Expires': '-1',
        'Pragma': 'no-cache'
      });
      return next();
    }
  };

  if (typeof module !== "undefined" && module !== null) {
    module.exports = middleware;
  }

}).call(this);