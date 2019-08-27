# Introduction
[Radar](https://radar.thoughtworks.com/?sheetId=https%3A%2F%2Fraw.githubusercontent.com%2FModaOperandi%2Fagora%2Fmaster%2Fcsv%2Ffrontend.csv)

Frontend work is a gloriously diverse ecosystem of technologies - many of them on the bleeding edge. Moda Tech should take care to introduce tools at the right time, doing our best to avoid choosing the current hotness that might eventually lose momentum/community/support.

# Languages & Frameworks

## Adopt

### React

The most popular Frontend UI/component library currently in use, with a rich toolset and powerful set of suggested patterns based in functional composition and immutability. React's philosophy of treating UI's as a dynamically generated tree of functionally composable elements of style, functionality, and output, represents a very strong foundation with which to build frontend applications.

[Details](https://github.com/ModaOperandi/agora/blob/master/recommendations/details/react.md)


## Trial

### TypeScript

Typescript has immense support, fantastic tutorials, and valid JS is, if not lint-passing, valid TS. As such, the learning curve should be quite minimal. It is created by Microsoft as a compile-time-typed alternative to Javascript, with a large community of tooling and cross-mixing with existing JS libraries.

[Details](https://github.com/ModaOperandi/agora/blob/master/recommendations/details/typescript.md)


## Hold

### Angular

Though there are a number of internal tools within Moda that use Angular as a frontend framework, React has somewhat caught up with Angular in terms of ease-of-use. Given that there are no more internal advocates of Angular over React and that some Moda apps are on Angular 1, we are deprecating usage of Angular in order to simplify our system. We are developing the plan to drive down usage of Angular over time.


### ReasonML

[ReasonML](https://reasonml.github.io/) is an alternative syntax to [OCaml](http://www.ocaml.org/) - a language that features functional, imperative, and object-oriented programming with a compiler that employs static typing and type inference. Though Moda Tech trialed ReasonML, we decided to deprecate its usage due to: steep learning curve, low internal knowledge, and lacking community support / documentation.

[Details](https://github.com/ModaOperandi/agora/blob/master/recommendations/details/reason.md)
