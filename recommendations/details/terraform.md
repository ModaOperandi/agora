# Terraform
Moda should be capturing infrastructure assets in committed code ([why it is important](https://www.hashicorp.com/resources/what-is-infrastructure-as-code)). Current thinking is that it is superior to [CloudFormation](#cloudformation) for the following reasons:

  1. Terraform is multi-service. This does not mean that the same Terraform resource can be deployed indiscriminately across different clouds. But it does mean that resources across multiple cloud providers (or any provider, really) can be captured in Terraform - and thus be captured in the same workflow, pipelines, etc.
  2. Terraform uses the provider's APIs. As a result, Terraform - which can model anything available via the API - will always be ahead of CloudFormation in supported resources.
  3. Terraform is infrastructure as code where CloudFormation is large yaml or json definitions.
  4. Terraform is much easier to read and write than CloudFormation.
  5. We can write Terraform modules to increase infrastructure reproducibility, consistency, and iteration.
  6. Terraform is easier to learn than CloudFormation.
  7. Hashicorp is actively developing terraform.
  8. Active open source community. Lots of contributors, docs, modules, examples, videos, talks, POCs, etc.
  9. Engineers are already using and learning Terraform at Moda.
  10. Arguably a better fit than CloudFormation for code generation and iteration.
