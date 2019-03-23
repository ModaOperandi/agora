# Introduction
[Radar](https://radar.thoughtworks.com/?sheetId=https%3A%2F%2Fraw.githubusercontent.com%2FModaOperandi%2Fagora%2Fmaster%2Fcsv%2Ffrontend.csv)

Frontend work is a glorously diverse ecosystem of technologies - many of them on the bleeding edge. Moda Tech should take care to introduce tools at the right time, doing our best to avoid choosing the current hotness that might eventually lose momentum/community/support.

# Languages & Frameworks

## Trial

### ReasonML

[ReasonML](https://reasonml.github.io/) is an alternative syntax to [OCaml](http://www.ocaml.org/) - a language which features functional, imperative, and object-oriented programming with a compiler that employs static typing and type inference. It was founded by the creator of ReactJS, [Jordan Walke](https://github.com/jordwalke), with the backing of Facebook, Bloomberg, and other individual contributors within the open source community.

#### Why?

Reason leverages the power of OCamls compiler, while providing a familiar syntax, in an effort to create a clean, fast, and effective way to write JS. It provides us the ability to create safe and robust frontend applications. 

The type system allows us to avoid most runtime errors that waste large portions of time trying to debug, as well as the ability to refactor existing code while keeping the entire application in sync, from container to view.

It's usually difficult to modify someone else's code, or to try and reason (hah!) about a system that you didn't write. This is where the static typing comes in handy the most. In our use case, we just turn data into views, so when we're modifying each others written code, the type system will guide us; Therefore allowing us to do our jobs quicker, without sacrificing quality!

#### JS Interop (how can we interact with existing JS?)

[BuckleScript](https://bucklescript.github.io/docs/en/what-why) is a fork of OCaml that allows ReasonML or OCaml code to be compiled into JS. It was originally produced by [Hongbo Zhang](https://github.com/bobzhang) at Bloomberg, and has grown to be its own library and repository, so that others could contribute. It also provides a way to bind to existing JS and incorporate it into a Reason project.

We end up bundling our compiled Reason code, along with all the dependencies we use, with webpack into a compressed and uglified JS file. Now, we can just import our components into any other JS application, just like any other library.

#### React?

There is an actively supported library, [ReasonReact](https://reasonml.github.io/reason-react/en/), which gives users the ability to write React components (and soon [hooks](https://github.com/reasonml/reason-react/pull/351)) in Reason. This library serves as the backbone of Moda's [display library](https://github.com/modaoperandi/not-elixir). It provides a way to render components written in plain JS, as well as a way to export components written in Reason for use in the JS world. The hooks PR linked above also includes support for the new context API in React, which allows global data storage and retrieval.

#### Drawbacks

- [bs-platform](https://github.com/BuckleScript/bucklescript/issues/1187), the BuckleScript runtime, is bundled by webpack with our code. They are [working on a solution](https://bucklescript.github.io/blog/2018/12/05/release-4-0-8) to separate the runtime and the standard library, so that generated JS can be shipped as a library without the need of a bundler.
- The learning curve is steep. People coming with experience in typescript or another strongly typed language will have a way easier time adjusting, otherwise it can be quite challenging.
- A small sample size for existing examples of widely solved problems. For example, it's been hard to find examples of how to do intricate things in Reason while developing the standard library, and we've had to stumble for a long time to fix relatively simple problems (compared to JS). Although, that problem has been easing with time and experience.
- Smaller audience compared to typescript.

#### Positives

- Build times are extremely fast. I use BuckleScript to compile all the **\*.re** files into **\*.bs.js**, which is taken by Webpack and bundled up to be required in an index.html file that I load in my browser. Compiling the Reason to JS takes roughly 30 to 40 milliseconds on average. Writing code & checking the functionality or the design almost instantly is pretty nice.
- Refactoring is very easy. Due to the static typing, changing how data enters a component or removing code from an existing component becomes very intuitive. The compiler will point out every instance of how that code was being used, and what it is trying to compile now.
- [Pattern matching!](https://reasonml.github.io/docs/en/pattern-matching) It is a [very early proposal](https://github.com/tc39/proposal-pattern-matching) in JavaScript land, but we have it right now in Reason! It's way to handle each way that a piece of data could be represented, and the compiler enforces it through the type system!
- The type system has been a great benefit to us when writing code. We avoid annoying runtime bugs that are caught by the compiler early on from simple mistakes. I feel assured knowing that the code being compiled will run and not break (assuming our components are rendered correctly!)
- A large company in facebook backs it and uses it currently in production.

#### Future

As stated above in the drawbacks, the learning curve for me was steep, as my strongly typed language experience was lacking. We have encountered many problems that were not documented in Stackoverflow or the Reason forums/discord, and that set back deadlines.

**BUT**, saying all of that, I believe we are now in a great place with understanding how to incorporate Reason end-to-end in our applications. The work in the display library is going along quite nicely, and I find myself to be very productive when writing Reason code in the present.

The end goal here would be to use Reason for the entire website, which I believe is doable. Although it would be quite a large undertaking.