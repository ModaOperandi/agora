# Core Tenets: Replatform

## No Undifferentiated Heavy Lifting

This is the core tenet from AWS; AWS does the undifferentiated heavy lifting (i.e. running data centers, administering databases, etc) so other companies can focus on the things that are meaningful to their particular business. We should invest primarily in the features and core competencies that are differentiators for Moda. Example: don’t run a fully custom e-commerce platform because e-commerce is a “solved problem” and being “good at e-commerce” is not going to make Moda rise above competitors. If we are distracted by implementing and maintaining features that come “out of the box” from commodity software, that reduces our ability to build the things that make Moda “Moda”.


## Choose enterprise software

Enterprise software allows Moda to take advantage of expertise and product features built by a company whose entire business is to make that software great. Benefits include:
* The feature suite will almost always be more fully baked and thought out than something we build internally.
* We can choose the right tool for the job.
* The third-party is responsible for platform-level uptime and incident resolution.
* When factoring in long term maintenance and personnel salary, cost may actually be lower.


## Avoid tight coupling

In a system with a number of enterprise tools, it can be easy to tightly couple those systems by integrating one directly into another. Following such an approach makes it more difficult to replace any of those tightly coupled tools - and leads to higher vendor lock-in and long term tool and cost commitments. If we instead invest in moving data between systems (using Workato or a similar approach), that reduces (or eliminates) the coupling of two systems and they can run independently of each other. Furthermore, you are establishing the core data models that matter for each system - which then flips a tool change from a direct integration to a much simpler data transformation task. Tight coupling can be acceptable for strong, existing, direct integrations between platforms, assuming they also minimize customization, cost, and maintenance. Note that this approach requires a clear definition of which tools are the ‘system of record’ for each type of data.


## Minimize Customization

The more we choose standard features, the less we need to invest in maintaining and documenting customizations in the long term. Each customization is something that Moda Tech will then need to own (and maintain and debug and monitor; related: even [Shopify themes require patching](https://help.shopify.com/en/manual/online-store/themes/managing-themes/updating-themes), which have to be easier to roll out with fewer customizations) in perpetuity. Furthermore, choosing standard features allows us to follow best practices established by the platform. Lastly, customization requires institutional knowledge over those customizations, which over time can become concentrated in a small number of individuals who then become single points of failure; standard features allow people to move around more easily, new people to join the organization more easily, contractors to be able to contribute more easily.


## But customize for differentiators

Yes, there will be times when we need to customize - and even build entire features fully customized; an example might be Stylist Suite because stylists drive 50% of the business and are one of the things our clients love about us (check out defined levels in column F [here](https://docs.google.com/spreadsheets/d/1MGM_wTh1q8yZHs-SvpPptuEX_nLEF41cTUpvCwIYiaE/edit?gid=9527547#gid=9527547)). But we should be deliberate when making such a choice and only make it when absolutely necessary. When being asked to customize something, our first question should always be “but do we really need to customize?”
