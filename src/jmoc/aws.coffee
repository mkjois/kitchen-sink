'use strict'

# Node modules
aws = require 'aws-sdk'
dynamo = require 'dynamodb-doc'

# Jmoc modules
config = require './config'

# Any required initialization
aws.config.credentials = new aws.SharedIniFileCredentials profile: config.aws.access.profile
aws.config.apiVersions =
  dynamodb: config.aws.ddb.version
aws.config.update region: config.aws.access.region

if module?
  module.exports =
    ddb: new dynamo.DynamoDB new aws.DynamoDB()
