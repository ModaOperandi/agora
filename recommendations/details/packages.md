# Introduction

Moda needs a way to privately store versioned common libraries in main tech stacks.

In this document following terms are used:

*package* - some piece of software: library or application in form of container

*package type* - Maven, SBT, Docker, Python Wheel, etc.

*packages repository* - system that stores versioned packages

# Packages Repositroies

## Github Package Registry

Pros:

1. Packages are stored at the same place as source code for them.

2. Authentication is configured the same way as for Github.

3. No additional charge (at least now might change when it gets to prod state)

Cons:

1. No support for Scala packages yet. Maven repository does not accept them.

2. No support for Python packages yet (there's no way we won't have python codebase).

3. No support for Go modules (currently we use Go for tooling).

4. Very new - might cause some unique issue.

## Artifactory (Cloud-based)

Pros:

1. Any possible type of package is supported.

2. Defacto industry standard - will not bring unexpected issues.

Cons:

1. Authentication with Github SSO is not possible, though Google SSO integration works.

2. Not free. First 3 months: $98 per month for. Next 3 months pessimistic estimate: $235 per month.

## Multiple Repositories

We could use specific repositories for each specific package type. Here's analysis of this.

Pros:

1. Some of such repository are open source - no license costs.

Cons:

1. Self-hosted repositories are more expensive in setup and maintenance then licensing cost could be.

2. Licenses costs for cloud-hosted options (if there are any available) are multiplied by number of supported packages types.

3. Each repository requires it's own configuration on developers machines and in CI/CD system.
