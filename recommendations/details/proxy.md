# Proxy

### Goals
1. Single point of contact for the outside world to speak to our back end services.
  * Authentication managed centrally
  * Traffic direction handled centrally
  * Security settings in one place, and not scattered
2. Caching for responses, where appropriate

### Non-Goals
1. Having any knowledge of concern about what kind of client is making a request, or knowledge of the contents of the payload.
2. Using or enforcing any particular format of message.

### The original idea...
There were plans, in early 2020, to aggregate all of our internal services using a GraphQL layer.  The primary purpose of this project was to facilitate the creation of new internal administrative applications by using Apollo Server to create a unified interface for all the data these applications would need from different services.  

The idea was to use Apollo Server's "GraphQL Federation" feature to allow the client to make a single request, and then let the server make parallel requests to as many services were necessary to fulfill the initial request.

This presented some challenges, though.  For example: Our different services and APIs can be either public or private, and can have different authentication states and methods.  Also, querying multiple services requires a strategy for handling an error response from one request, but not necessarily the rest.  This is just a sample.

This plan tightly couples two ideas: The concept of a single API endpoint, which figures out what service or services to direct you to (an "ingress controller", in service mesh parlance), and a translator, which can turn one or more responses from these services into a single, properly-formatted response to a GraphQL query or mutation.

It turns out that we no longer have a use case for the second idea.  Discovery doesn't need to merge responses from different APIs.  Every part of the system is fully served by exactly one service, whether it's GraphQL or REST.  And, it has been stated that we don't want to be federating our data for internal use.  Additionally, a recent Tech Radar recommends against using Apollo Federation, [rating it a hold](https://www.thoughtworks.com/radar/techniques?blipid=202010003).

There is still a strong need to simplify and shrink the security around our APIs, however.  We should look at creating a single entry point for our services, so that we don't have to set each one up with its own WAF, rate limiting, etc.

### Options

#### Istio Gateway
Istio [contains functionality](https://istio.io/latest/docs/concepts/traffic-management/#gateways) to handle our use case out of the box.  Other service mesh frameworks (such as Consul) have similar functionality.  These are generally implemented behind the scenes by using [Envoy](https://www.envoyproxy.io).

#### AWS API Gateway
API Gateway can manage our traffic centrally, but there's no easy way to automate adding new services to its configuation.  It can be done, but it would likely be hacky.

#### In-house implementation
We can stand up a simple service, which would:
* Read the CI and/or k8s configuration from github projects on startup,
* Use that to determine how to find services internally,
* Forward requests to the service they're asking for by URL.

This would get the job done, but probably won't be as robust as the other options.  It also requires the most work from developers.  So, it's less than ideal.  The only real appeal of it is that it can take a piece of our infrastructure, and make it work like any other platform application - at the cost of reinventing the wheel.