# Introduction

Moda needs a way to privately store versioned common libraries in main tech stacks.

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
