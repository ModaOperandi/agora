# Introduction
[Radar](https://radar.thoughtworks.com/?sheetId=https%3A%2F%2Fraw.githubusercontent.com%2FModaOperandi%2Fagora%2Fmaster%2Fcsv%2Fmicroservices.csv)

Moda is opportunistically moving functionality out of its Rails monolith (Mojo) and into microservices.

# Languages & Frameworks

## Hold

### JsonApi

[JsonApi](https://jsonapi.org) is a specification for API requests and responses using JSON format. A main goal of the specification is to optimize HTTP requests, both in terms of the number of requests and the size of the data payload exchanged between clients and servers. While this is an extremely important consideration for customer facing layers, it is of less importance for micro-services, which reside on the same fast network.

The specification is used by mojo and the website.

The alternative is an API-first approach, where the only way to describe an API and its data is through an IDL, and all necessary code is generated from that IDL, and nothing is written by hand. This eliminates any confusion about field names, their types, the order, and so on. Whether we adopt something like OpenAPI (formerly known as Swagger) or something similar, there should be no need for JsonApi.

## Assess

### http4s

Very lightweight library, functional, built on top of FS2 and Cats Effect (or compatible). The only choice, really, for building a pure FP service.

[Details](https://github.com/ModaOperandi/agora/blob/master/recommendations/details/play.md)


### Kotlin

Kotlin is increasingly being considered as a viable language option for microservices. Moda Tech should keep an eye on it as a "better Java" if functional programming is not a priority. Moving Kotlin out of Assess would require a strong estimate of the level of investment to support it at the platform level.

[Details](https://github.com/ModaOperandi/agora/blob/master/recommendations/details/kotlin.md)


## Trial

### Play

Battle-tested HTTP / MVC framework that is the industry go-to for Scala development; supports Futures and Akka.

[Details](https://github.com/ModaOperandi/agora/blob/master/recommendations/details/play.md)


### Scala

Scala is a more-mature modern language that gives Moda Tech an approachable entry to functional programming. It enjoys widespread adoption and many library options for HTTP frameworks, testing, actors, etc.

[Details](https://github.com/ModaOperandi/agora/blob/master/recommendations/details/scala.md)
