# Sttp Scala HTTP Client

There should be standard way to perform HTTP requests from Scala. It's important for code uniformity but it's also critical for distributed tracing, monitoring, cricuit breaking features which could be implemented in some Moda-specific way for one client library but could be missing in another one.

Scala sttp library is suggested to be standard library for HTTP requests. Sttp is more like a standard HTTP request API layer on top of verious backends.

Pros:
- Allows different backends, could be synchronous and asynchronous
- Backend based on Akka ActorSystem is provided
- The way how backend is designed allows to implement distributed tracing, circuit breaker and similar features as a backend wrapper layer
- Allows custom serialization/deserialization layer - works with Circe
- API for building request is immutable "builder" style - convenient for generating clients
- Lightweight on dependencies - does not require Play or other heavy libraries

Cons:
- Not identified yet

Here's an example of POST request from generated client code. In this example it's sending body as serialized String and produces Response[String] where the string is JSON response body.

```scala
    val response: Future[Response[String]] =
      sttp
        .post(url)
        .body(Json.write(body))
        .parseResponseIf { status => status < 500 }
        .send()
```