# Kitchen Sink
By Manny Jois

***

Whatever API microservices I come up with, written in [CoffeeScript](http://coffeescript.org/), compiled to [Node](https://nodejs.org/), contained by [Docker](https://www.docker.com/), deployed on [AWS](https://aws.amazon.com/).

NOTE: As of 10/5/2015 the server will become indefinitely offline due to AWS costs (expired free tier usage)

***

## Jmoc

Post JSON and get a URL endpoint that provides similar objects on GET requests.

Send a POST request to `https://dontrea.ch/jmoc/mock/` (the trailing slash is important) with the following headers:
```
Content-Type: application/json
```
and the following body:
```
{"Json": <JSON>}
```
where `<JSON>` is any valid JSON.

You'll receive a response with key `Id`, a 16-digit base-64 value that represents your mock. Send a GET request to `https://dontrea.ch/jmoc/mock/<ID>` to get a mocked version of your JSON.

## FAQ

*Why deploy all these microservices as one project?*

I am a singular, thrifty human being trying to stay on as much of the AWS [free tier](https://aws.amazon.com/free/) as I can, so application servers are stateless and run the full Kitchen Sink suite.

*Why is each service hosted on a top-level route instead of a subdomain?*

This way I didn't need a multi-domain or wildcard SSL certificate, which are more expensive than one that covers a single domain.

*Future plans?*

No idea. Don't have that much free time so definitely nothing super extensive. If you've got an idea or question, create an appropriately labeled [issue](https://github.com/mkjois/kitchen-sink/issues) and I'll be happy to consider and respond.
