# Authentication and authorization for internal users and applications
- Pink, Pumo and Stylist Suite currently uses a combination of [Devise](https://github.com/plataformatec/devise) and [Doorkeeper](https://github.com/doorkeeper-gem/doorkeeper) to provide authentication and tokens to admin users.
- Users are assigned roles that are composed of fine-grained permissions
- Validating a user request against their permissions requires a DB request
- Very little separation between users and customers
- Currently not using scopes for access control
- Missing OIDC features like audiences, JWT and UserInfo endpoint (could be enabled through Doorkeeper extensions)

# AWS Elastic Load Balance and API Gateway
- support vanilla OIDC providers
- simpler since microservice endpoints only need to think about tokens and not the entire auth flow

# GSuite as an identity provider
- All employees are GSuite users
- Easy to provision/ deprovision
- Difficult to assign roles and persist them in JWT 
- What about third parties that are not in Gsuite?

# JSON Web Tokens
- cryptographically signed
- decentralized
- can be inspected (in a web browser, for example)

# Identity as a Service
## Auth0
	- Used by Vendor Portal
    - Supports enterprise integrations (GSuite)
    - security certifications
    - Audit trail 
	- Many more things
## Cognito	
    - Supports any OIDC identity provider
    - Provided Auth primitives as opposed to a polished Auth product
	
