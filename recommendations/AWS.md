# Introduction
[Radar](https://radar.thoughtworks.com/?sheetId=https%3A%2F%2Fraw.githubusercontent.com%2FModaOperandi%2Fagora%2Fmaster%2Fcsv%2FAWS.csv)

Moda has recently started investing more into AWS and is gaining expertise with its services. As such, many services will be in Trial to start with, until we build instituional knowledge in specific areas.

# Tools

## Trial

### Terraform
Moda should be capturing infrastructure assets in committed code ([why it is important](https://www.hashicorp.com/resources/what-is-infrastructure-as-code)). Current thinking is that it is superior to [CloudFormation](#cloudformation) for the following reasons:

  1. Terraform is multi-service. This does not mean that the same Terraform resource can be deployed indiscriminately across different clouds. But it does mean that resources across multiple cloud providers (or any provider, really) can be captured in Terraform - and thus be captured in the same workflow, pipelines, etc.
  2. Terraform uses the provider's APIs. As a result, Terraform - which can model anything available via the API - will always be ahead of CloudFormation in supported resources.
  

## Hold

### CloudFormation
Moda should be capturing infrastructure assets in committed code ([why it is important](https://www.hashicorp.com/resources/what-is-infrastructure-as-code)). CloudFormation is the AWS-native way to do IaC. Please see commentary on [Terraform](#terraform) for reasons why CloudFormation is not recommended.
