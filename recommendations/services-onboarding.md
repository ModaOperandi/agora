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

Some "rare" stacks could be supported individually without standard support in the platform. For example we have only one Java-based service right now - it would be overkill to provide standard Java service build job.

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
| flow   | no                  | ???                          |

## Required Work

1. Python stack should be supported for deployment.
2. Java stack should be supported for deployment.
3. Standard build job for Python AIOHTTP service should be developed to build Python services.
4. Some services have AWS Lambda functions added. Lambda functions are not currently supported on platform. There are some plans to potentially provide such support.
5. RDS storage support is needed for few services. Yet to investigate if the storage is Mojo MySQL or separate database.

Mojo-related issues:
1. MySQL database access is not provided from platform. Each individual case should be considered separately.
2. Network HTTP calls are not allowed from platform to Mojo. Each individual case should be considered separately.

## Migration Candidates

These services are already on scala stack and already using codegen. Full Build + Deployment + Codegen seems to be best scenario for these services. 
1. preferences-api
2. recommendations-api

Next migrations are TBD

# Mogration Plan

This is suggested migration plan, might be not fully applicable depending on service itself.

1. Provide Build compatible with platform deployment (service.zip, etc). For many of services just migration to standard build job is needed.
2. Make service deployable with standard Deploy workflow. Check public/private access endpoints.
3. Service should start without errors: all potential connectivity issues should be identified at this phase.
4. Connect service deployed to the platform to old data storage.
5. Migrate all service inbound connections to the new service endpoint on the platform.
6. Shutdown service in it's old AWS account.
7. Prepare data migration plan. Could be simple manual backup+restore, or a ondemand-job that will migrate data.
8. Stop service. Execute on data migration plan. Start service poitning to the new data storage in SDLC account.
9. Remove old storage after validating that none of data is lost and everything is still healthy.

Steps 7-9 might be less applicable for services connecting to Mojo database look at [Mojo-related issues](#required-work)
