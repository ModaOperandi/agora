# Introduction
[Radar](https://radar.thoughtworks.com/?sheetId=https%3A%2F%2Fraw.githubusercontent.com%2FModaOperandi%2Fagora%2Fmaster%2Fcsv%2Fefficiency.csv)

This is a set of recommendations for developing queue-based services. Queue-based services are services either producing or consuming messages from queue (most often Kinesis).

## Requirements

1. Queue producer and consumer are typically separate services. They both rely on schema of the queue message. Schema is expressed in form of models types in programming language. Such set of of model types should be shared between producer and consumer. Creation and maintenance of such models libraries should be well supported.
2. Producer and consumer might be built on different technology stacks - in Scala there are two approaches currently actively used: akka-based and cats-based. Both approaches should be maintained.
3. Messages on a queue might have non-sense schema. This is typically the case for 3rd party producers or producers out of control (binlog). It would be great to have full support for developing services for such queues.

# Languages & Frameworks

### Circe

Circe Scala library is suggested library for models serialization/deserialization. It works well for all kind of data structures and data types. Both akka and cats can work fine with circe models.

# Tools

### Spec

Spec is a speicification format that allows to describe models and http endpoints. There's a codegen tool for spec format. It's suggested to use spec only for generating models types in case of queue-based services.

Spec model:

```
OrderCreatedEvent:
  id: uuid
  sku: uuid
  quanitiy: int

OrderShippedEvent:
  id: uuid
  shipped_timestamp: datetime

OrderCancelledEvent:
  id: uuid

OrderEvent:
  oneOf:
    created: OrderCreatedEvent
    shipped: OrderShippedEvent
    cancelled: OrderCancelledEvent
```

### API CI Pipeline

API CI pipeline allows to move out client libraries maintenance from producer source codebase. Instead producer maintains only models spcification. Models specification is used in producer source code for models generation. Also models specification is published into specifications repository where it's picked up by API CI for generating client library.

Here's diagram of models specification workflow:

<img src="../images/spec-workflow.png">

### Goldfish

When starting new service either akka or cats producer/consumer code could be scaffolded. Scaffolded code is not maintained by any tool - once generated service developers are responsible for maintenaning it. Goldfish command line tool is intended for such kind of scaffolding as it's capable of creating unified CI/CD pipeline and everything required to deploy scaffolded services into the platform.