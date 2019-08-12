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
Terraform is the current best-in-class [infrastructure-as-code](https://www.hashicorp.com/resources/what-is-infrastructure-as-code)) provider, providing (among other things) a multi-service approach through the "front door" of provider APIs that is actively developed both via core HashiCorp support and the open source community.

[Details](https://github.com/ModaOperandi/agora/blob/master/recommendations/details/terraform.md)


## Hold

### CloudFormation
Being only AWS-specific and generally lagging behind new services and API improvements in AWS itself, there are other better options for infrastructure-as-code.

[Details](https://github.com/ModaOperandi/agora/blob/master/recommendations/details/cloudformation.md)
