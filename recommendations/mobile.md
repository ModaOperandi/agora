# Languages & Frameworks

## Adopt

### Swift

Swift is now our default choice for development in the Apple ecosystem. 
With the release of Swift 2, the language approached a level of maturity that provides the stability 
and performance required for most projects. A good number of libraries that support iOS development
are now migrated over to Swift, and most of the new ones are built in swift directly. 

Since when Swift was open sourced, the language greatly improved in terms of new language features, native 
support for json coding/decoding, and now with swift 5 and 5.1 the language is now ABI stable and Module 
stable making it a good choice also for SDKs.

### RxSwift

Distributed systems often utilize multithreading, event-based communication and nonblocking I/O to improve 
the overall system efficiency. These programming techniques impose challenges such as low-level threading,
synchronization, thread safety, concurrent data structures, and non-blocking I/O. The open source ReactiveX 
library beautifully abstracts away these concerns, provides the required application plumbing, and extends 
the observable pattern on streams of asynchronous events. ReactiveX also has an active developer community 
and supports a growing list of languages, the most recent addition being RxSwift. It also implements binding 
to mobile and desktop platforms.

### MERLin

MERLin' is a reactive framework that aims to simplify the adoption of an event-driven architecture within an 
iOS app. It emphasises the concept of modularity, promoting an easy to implement communication channel to deliver 
events from producers to listeners.

## Trial

### SwiftUI
Swift UI is a new framework presented in 2019 WWDC that aims to replace entirely `UIKit`. While this framework is 
available in iOS 13 only, i believe that we should start building iOS 13 controllers along with legacy view controller.
swift language makes easy to switch between iOS versions and inject the right dependency in the right time.

Swift UI promises to greatly simplify UI development giving more time to build a proper structure with safer code
promoting concepts like unique source of thruth, modularisation and reactive/functional paradigms.

## Hold

### Objective-C

Currently apple is pushing pretty hard towards new Swift building frameworks strictly available to swift users.
SwiftUI and Combine are just the beginning of a completely new era of iOS development. While the objective-c community
is still strong and active, apple in documentation, tutorials and WWDCs are just showing swift code (with an option to 
switch to objective-c in the case of documentation). While it is true that any objective-c feature is present in swift, 
it's not true that greatly appreciated swift language features are not available on Objective-C.

### Alamofire

Alamofire is a networking framework that wraps `URLSession` in order to simplify our networking layers. Moda App 
networking layer is not that complex to justify this big dependency in the project and it was therefore removed in favor
of RxSwift `data` operator that so far fullfils all our needs.
