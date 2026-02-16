# Authentication and authorization for internal users and applications
- Pink, Pumo and Stylist Suite currently uses a combination of [Devise](https://github.com/plataformatec/devise) and [Doorkeeper](https://github.com/doorkeeper-gem/doorkeeper) to provide authentication and tokens to customers.
- In many cases, every HTTP request is validated via a database request

# AWS Elastic Load Balance and API Gateway
- support vanilla OIDC providers
- simpler since microservice endpoints only need to think about tokens and not the entire auth flow

# GSuite as an authentication provider
- All employees are GSuite users
- Easy to provision/ deprovision
- Difficult to assign roles and persist them in JWT 
- What about third parties that are not in Gsuite?

# Identity as a Service (Auth0)
- Supports enterprise integrations (GSuite)
- security certifications
- Audit trail

# Other microservice architectures
- Kubernetes
- Service mesh approaches (Istio, ...)
