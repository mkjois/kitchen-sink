'use strict'

# Node modules
base64url = require 'base64url'
crypto = require 'crypto'
validator = require 'validator'

# U/page modules
aws = require './aws'
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


  '/mock/:id':

    get:
      handler: (req, res) ->
        id = req.params.id?.normalize?()
        switch
          when not id?
            res.status(400).json msg: 'Missing endpoint ID'
          when id.constructor isnt String
            res.status(400).json msg: 'Endpoint ID must be a string'
          when not validator.matches id, config.regex.urlhash
            res.status(400).json msg: 'Endpoint ID must be base64url-encoded'
          else
            params =
              TableName: config.aws.ddb.tables.urls.name
              Key: "#{ config.aws.ddb.tables.urls.hash }": id

            aws.ddb.getItem params, (err, awsdata) ->
              if err? then res.status(500).json err
              else
                if Date.now() > awsdata.Item.Expiry
                  res.status(410).json msg: "This JSON mock expired on #{ new Date(awsdata.Item.Expiry).toUTCString() }"
                  # TODO: delete item
                else
                  res.json mockify awsdata.Item.Json


    delete:
      handler: (req, res) ->
        id = req.params.id?.normalize?()
        switch
          when not id?
            res.status(400).json msg: 'Missing endpoint ID'
          when id.constructor isnt String
            res.status(400).json msg: 'Endpoint ID must be a string'
          when not validator.matches id, config.regex.urlhash
            res.status(400).json msg: 'Endpoint ID must be base64url-encoded'
          else
            params =
              TableName: config.aws.ddb.tables.urls.name
              Key: "#{ config.aws.ddb.tables.urls.hash }": id

            aws.ddb.deleteItem params, (err, awsdata) ->
              if err? then res.status(500).json err else res.sendStatus 204


  '/mock/':

    post:
      handler: (req, res) ->
        options = req.body.Options
        json = req.body.Json
        numKeys = Object.keys(req.body).length
        switch
          when not json?
            res.status(400).json msg: "Missing field: 'Json'"
          when numKeys > 2 or (not options? and numKeys > 1)
            res.status(400).json msg: 'Unknown fields specified'
          else
            id = base64url.encode crypto.randomBytes config.crypt.len.urlhash
            nowMillis = Date.now()
            expireMillis = nowMillis + 86400000 * config.app.limits.url
            data =
              "#{ config.aws.ddb.tables.urls.hash }": id
              Json: json
              Expiry: expireMillis

            params =
              TableName: config.aws.ddb.tables.urls.name
              Item: data
              ConditionExpression: 'attribute_not_exists(#HK)'
              ExpressionAttributeNames: '#HK': config.aws.ddb.tables.urls.hash

            aws.ddb.putItem params, (err, awsdata) ->
              if err? then res.status(500).json err
              else
                data.Expiry = new Date(data.Expiry).toUTCString()
                res.status(201).json data


mockify = (json) ->
  if not json? then return json
  switch json.constructor
    when Number
      random = Math.random() * 2 * json
      numStr = json.toString()
      decimalIndex = numStr.indexOf '.'
      if decimalIndex < 0  # integer precision
        return Math.round random
      else  # use given precision
        precision = numStr.length - decimalIndex - 1
        return random.toFixed precision
    when String
      mid = Math.floor(json.length / 2)
      start = Math.floor(Math.random() * mid)
      end = mid + Math.floor(Math.random() * (json.length - mid + 1))
      return json.slice start, end
    when Boolean
      return Math.random() < 0.5
    when Array
      return (mockify item for item in json)
    when Object
      data = {}
      for k, v of json
        data[k] = mockify v
      return data
    else return json  # fallback


if module?
  module.exports =
    aws: aws
    config: config
    middleware: middleware
    routes: routes
