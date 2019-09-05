# TypeScript

[TypeScript](https://www.typescriptlang.org) is a superset of Javascript's built in feature set plus items still under
consideration for being accepted into the JS core API. It is created by Microsoft as a compile-time-typed alternative
to Javascript, with a large community of tooling and cross-mixing with existing JS libraries.

## Why?

TypeScript provides a nearly full set of tooling for Object Oriented approaches as well as a powerful foundation for
functional ones as well (supplemented by libraries such as Ramda). It has immense and growing support across the entire
JS/Node-based development community and type definitions are easy to come by or create.

Overall, the use of a strong type system will help us develop faster (with better compile-time tooling) and avoid
type related errors. Further, TypeScript's type system and write-time tooling help enforce coding standards to a
higher level than most JS-centric tools, with more aggressive and comprehensive linting and stricter requirements.

## JS Interop (how can we interact with existing JS?)

Working with existing JS in TypeScript is extremely simple. The only real requirement is to create or download a type
definitions file for the existing library, and editor and compilation tools largely handle the rest of the work of
integrating with intellisense or `tsc`.

## React?

TypeScript is steadily becoming the default for many significant libraries in the React ecosystem, such as Jest which
is migrating their entire codebase to TypeScript, and React itself which puts TypeScript as on par with, if not slightly
more preferred than Flow, Facebook's own typed JS library (almost all React docs now show TS examples as equal to the Flow
example, sometimes with preference).

## Drawbacks

- There is a learning curve still.
TypeScript is not Javascript and especially with stricter linting settings, it can take some getting used to.
- It is not a perfect model of Object Oriented Programming tools.
For example, abstract types typically exist only at compile time, causing difficulty in telling TypeScript you
want to use a class that implements an abstract class during runtime. Further, `static` doesn't really exist
in the same way as it normally does in truly/fully compiled languages like Java. This can be a bit misleading.
- It requires a bit more of a build process.
Source maps become more useful, and compilation of TypeScript to JS is obviously required.
- More libraries are required.
Type definition libraries are often not an option but a requirement.

## Positives

- Typescript has immense support, fantastic tutorials, and valid JS is, if not lint-passing, valid TS.
As such, the learning curve should be quite minimal. This is especially the case as OOP is a largely abandoned
concept in Frontend environments these days, meaning proper implementation of OOP principles will likely
not be necessary (generics can be very helpful, however).
- Typescript types are powerful.
TypeScript has a rich type system, especially with the experimental `decorators` option enabled.
- Combined with GraphQL's runtime type checking, can guarantee 100% type-safety (when/where used) of code from GraphQL
proxies forward to the smallest component.
- Automatic documentation generation via comments above types, and the community's available tooling.
TypeScript has incredible support across virtually every Frontend environment at this point, and the tooling is often
equivalent to or a step above its JS counterpart; in many cases it *is* the JS option, possibly with extra
features and abilities added on.
