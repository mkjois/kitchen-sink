'use strict'

# Node modules
aws = require 'aws-sdk'

# U/page modules
config = require './config'

# Any required initialization
aws.config.credentials = new aws.SharedIniFileCredentials profile: config.aws.access.profile
aws.config.update region: config.aws.access.region

# TODO: store stuff...
if module?
  module.exports = aws
