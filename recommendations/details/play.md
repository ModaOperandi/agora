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

## http4s

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
3. steep learning curve

# Examples

There is an [example implementation of the preferences-api that uses http4s (and circe and Scanamo)](https://github.com/ModaOperandi/api-preferences/tree/initial-commit). This can be [compared against a contemporaneous version of the main preferences-api (with play-json and Slick)](https://github.com/ModaOperandi/preferences-api/commit/32f1c127c2839436bda92693894bf7d95a5d8d86).

Services are roughly the same: [Play](https://github.com/ModaOperandi/preferences-api/blob/integration/app/services/PreferencesService.scala) vs [http4s](https://github.com/ModaOperandi/api-preferences/blob/initial-commit/src/main/scala/com/moda/preferences/services/PreferencesService.scala).

Models are roughly the same, only with different JSON converters due to imported libraries: [Play](https://github.com/ModaOperandi/preferences-api/blob/integration/app/models/DesignerPreference.scala) vs [http4s](https://github.com/ModaOperandi/api-preferences/blob/initial-commit/src/main/scala/com/moda/preferences/models/DesignerPreference.scala).

DAOs very different, again due to imported libraries: [Play](https://github.com/ModaOperandi/preferences-api/blob/integration/app/db/MysqlPreferencesDao.scala) vs [http4s](https://github.com/ModaOperandi/api-preferences/blob/initial-commit/src/main/scala/com/moda/preferences/db/DynamoPreferencesDao.scala).

Controllers are very different, due to the frameworks (i.e. the point): [Play](https://github.com/ModaOperandi/preferences-api/blob/integration/app/controllers/PreferencesController.scala) vs [http4s](https://github.com/ModaOperandi/api-preferences/blob/initial-commit/src/main/scala/com/moda/preferences/server/ServerRoutes.scala).
