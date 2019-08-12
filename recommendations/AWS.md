# Introduction
[Radar](https://radar.thoughtworks.com/?sheetId=https%3A%2F%2Fraw.githubusercontent.com%2FModaOperandi%2Fagora%2Fmaster%2Fcsv%2FAWS.csv)

Moda has recently started investing more into AWS and is gaining expertise with its services. As such, many services will be in Trial to start with, until we build instituional knowledge in specific areas.

# Tools

## Assess

### Pulumi
There is a recent trend to attempt to pull infrastructure-as-code (IaC) out of [vendor](https://www.terraform.io/docs/configuration/syntax.html)-[specific](https://docs.ansible.com/ansible/latest/user_guide/playbooks_intro.html#playbook-language-example) [DSLs](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-anatomy.html) and into strongly-typed code libraries; [Pulumi](https://www.pulumi.com) is perhaps the most advanced option within this space. The general idea is to reduce friction by bringing IaC to where the developers live, i.e. in the same language and with the same constructs (coding constructs, dependency management, importing libraries, etc) within they are accustomed to working.

This is an interesting space with some industry attention devoted to it and it might make sense to do some work to prove it out.

[Details](https://github.com/ModaOperandi/agora/blob/master/recommendations/details/pulumi.md)


## Trial

### Terraform
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

## Hold

### CloudFormation
Moda should be capturing infrastructure assets in committed code ([why it is important](https://www.hashicorp.com/resources/what-is-infrastructure-as-code)). CloudFormation is the AWS-native way to do IaC. Please see commentary on [Terraform](#terraform) for reasons why CloudFormation is not recommended.

#### Note regarding AWS CDK (Cloud Development Kit)
Per the [CDK FAQ](https://aws.amazon.com/cdk/faqs):
```
Since AWS CDK leverages CloudFormation, AWS CDK applications are subject to the same limits imposed by the CloudFormation service.
```
As such, the CDK should be considered on `Hold` because CloudFormation itself is.
