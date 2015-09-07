# Kitchen Sink
By Manny Jois

***

Whatever API services I come up with, implemented in Node compiled from CoffeeScript.

### Jmoc

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
