# Pulumi

There is a recent trend to attempt to pull infrastructure-as-code (IaC) out of [vendor](https://www.terraform.io/docs/configuration/syntax.html)-[specific](https://docs.ansible.com/ansible/latest/user_guide/playbooks_intro.html#playbook-language-example) [DSLs](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-anatomy.html) and into strongly-typed code libraries; [Pulumi](https://www.pulumi.com) is perhaps the most advanced option within this space. The general idea is to reduce friction by bringing IaC to where the developers live, i.e. in the same language and with the same constructs (coding constructs, dependency management, importing libraries, etc) within they are accustomed to working.

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
