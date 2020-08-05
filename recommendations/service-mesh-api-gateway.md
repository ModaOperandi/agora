# Service Mesh and API Gateway Solution

## Goal

The ultimate goal is for all existing services, both legacy and current platforms, to have access to token authorization without needing to implement it per service. 

## Proposed Architecture

<img src="/images/gateway-servicemesh.png">

## Proposal Summary

Deploy [Istio](https://istio.io/latest/docs/concepts/what-is-istio/) into each EKS cluster for environment-separated service meshes. Legacy services will be fronted by a centralized AWS API gateway using Lambda authorizers deployed in the corresponding accounts. The gateway will be removed once all legacy services have been migrated to EKS.

### AWS API Gateway
* First million API invocations are free; next 300 million are $1 per million requests, assuming we use HTTP APIs
* Can generate API keys without additional setup
* Additional OAuth/JWT token authorization via [custom request authorizer lambdas](https://aws.amazon.com/jp/blogs/compute/introducing-custom-authorizers-in-amazon-api-gateway/)
* Gateway itself will be [centralized](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-lambda-authorizer-cross-account-lambda-authorizer.html) in Core Shared Services account - one gateway for all envs since env distinction isn't well-defined for legacy services 
* Can track API calls, latency, error rates through the gateway if desired

### Istio
* Open source - no additional cost other than EKS usage
* Allows for native A/B testing of services, canary deployments, percentage-based rollouts, service tracing
* Can configure JWT/OAuth token generation as needed

### Concerns
* If we do need JWT-type auth, we'd need to write our own Lambda authorizer - not trivial
* Istio may be able to front legacy services anyway - should explore this first