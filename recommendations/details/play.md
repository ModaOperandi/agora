# Introduction

Moda needs the main default framework for developing HTTP-based services. Code generation should abstract developers from particular HTTP framework.

# HTTP Frameworks

## Play

Pros:
1. Battle checked. Maintained by open source community rather then specific company.
2. Based on Akka, Scala Future support.
3. Pretty simple to reason about. Similiar to HTTP frameworks in other tech stacks.
4. There are some plans to integrate with fs2 (plans for modern Scala support).

Cons:
1. Framework itself is using codegen and working throw SBT plugin (Gradle plugin is behind).
2. Custom routing DSL (pretty simple though).

## Twitter Finatra

Pros:
1. Same simple as Play.
2. No SBT plugins or codegen is needed.

Cons.
1. Twitter Future instead of Scala Future.
2. "Strage" mix of body parsing with URL/query params parsing.
3. Seems like no development.

##http4s

Very lightweight library, functional, built on top of FS2 and Cats Effect (or compatible).
The only choice, really, for building a pure FP service.

Pros:
1. minimal: does not bring a world of dependencies in every project;
2. functional: allows writing FP code that has a lot of advantages;
3. flexible: supports multiple Json libraries (argonaut, circe, json4s, json4s-jackson)
4. fast: supposed to be faster than akka-http and play, but there are even faster ones out there.

Cons:
1. immature: the library is heavily developed, subject to massive changes;
2. young: documentation is scarce, beyond the minimal `Hello, World!` app.
