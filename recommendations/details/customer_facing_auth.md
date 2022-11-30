# Customer Auth for public-facing website and App

## Current State
- The Moda website currently uses a combination of [Devise](https://github.com/plataformatec/devise) and [Doorkeeper](https://github.com/doorkeeper-gem/doorkeeper) to provide authentication and tokens to customers.
- There are some limited authorization functionality such as private trunkshows.

## Migrating to Identity as a Service (such as Auth0)
- Decrease internal security threat profile
- Anomaly-detection and Bot protection utilities
- Potentially enhance authorization features to customers.  For example, VIP customers could be given access to view/purchase items not on the site, private trunkshows, etc.
- Authorization can be done in a session-less manner. 
- It will cost more
