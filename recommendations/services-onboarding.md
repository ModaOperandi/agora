# Services Platform Onboarding Strategy

There's a goal to onboard as many existing services to the platform as possible.

Benefits:
1. Less AWS accounts to manage. Basically eliminates EC2, ECS besides Mojo.
2. Better resources utilization of kubernetes cluster. Lower costs
3. Unified CD and in most cases unified CI (Scala services).

Ideally all AWS accounts will be decommissioned besides one used for Mojo and platform SDLC accounts.

## Onboarding Levels

#### Build

* Source control workflow changed to standard master-based development.
* Build is done via standard build service job.

#### Deployment

* Service is moved to kubernetes platform.
* Deployment moved to standard deployment pipeline.

#### Codegen

* API related code moved to code generation.

#### Zero

* Obviously no onboarding is done

## Recommended Levels

| Stack  | Currently Supported | Recommended Level            |
| :----- | :------------------ | :--------------------------- |
| scala  | yes                 | Build + Deployment + Codegen |
| python | no                  | Build + Deployment           |
| java   | no                  | Deployment                   |
| ruby   | no                  | Zero                         |

## Required Work

1. Python stack should be supported for deployment.
2. Java stack should be supported for deployment.
3. Standard build job for Python AIOHTTP service should be developed to build Python services.
4. Standard Java build job is not needed since we are dealing with vendor-service only.
5. Some services have AWS Lambda functions added. Lambda functions are not currently supported on platform. There are some plans to potentially provide such support.
6. MySQL database access is not provided from platform. Each individual case should be considered separately.
7. Network HTTP calls are not allowed from platform to Mojo. Each individual case should be considered separately.

## Migration Candidates

These services are already on scala stack and already using codegen. Full Build + Deployment + Codegen seems to be best scenario for these services. 
1. preferences-api
2. recommendations-api

Next migrations are TBD