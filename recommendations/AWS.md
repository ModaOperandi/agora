# Introduction
[Radar](https://radar.thoughtworks.com/?sheetId=https%3A%2F%2Fraw.githubusercontent.com%2FModaOperandi%2Fagora%2Fmaster%2Fcsv%2FAWS.csv)

Moda has recently started investing more into AWS and is gaining expertise with its services. As such, many services will be in Trial to start with, until we build instituional knowledge in specific areas.

# Tools

## Assess

### Pulumi
There is a recent trend to attempt to pull infrastructure-as-code (IaC) out of [vendor](https://www.terraform.io/docs/configuration/syntax.html)-[specific](https://docs.ansible.com/ansible/latest/user_guide/playbooks_intro.html#playbook-language-example) [DSLs](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-anatomy.html) and into strongly-typed code libraries; [Pulumi](https://www.pulumi.com) is perhaps the most advanced option within this space. The general idea is to reduce friction by bringing IaC to where the developers live, i.e. in the same language and with the same constructs (dependency management, importing libraries, etc) within they are accustomed to working.

A quick (proof-of-concept-less) look at Pulumi (and generally any other similar tool) raises the following concerns:
1. This is another layer of abstraction that:
  * obfusicates the inner workings of the base tool (CloudFormation, Terraform, etc)
  * may be implemented to different degrees based on language and cloud provider/service
  * will always lag behind the base tool
  * can have bugs
2. Unclear that there is major benefit to performing IaC in a developer's chosen language:
  * may not be implemented in your language of choice
  * are the DSLs _that_ inscrutable?
  * there likely will always need to be another pipeline/step for IaC anyway, with a (Pulumi)-specific environment
3. Is an imported library _that_ different from a module?
4. How much traction will this gain? A strong community is essential for the long-term viability of any technology that relies on third-party-specific integration work.

That said, this is an interesting space with some industry attention devoted to it and it might make sense to do some work to prove out the above (or contradict it). If we do, here are a few basic requirements:

1. Should be extensible. This tool will never have full coverage into all infrastructure partners, and we should be able to extend it to work with our partners if we decide it is worth the investment.
2. Underlying configuration that is produced (CloudFormation, Terraform, etc) should be commited to a repository.
3. Keep cost in mind.

In the meantime, we should continue working with established tools and follow best-practices.


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
