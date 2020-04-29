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

## Terraform style standards
There are many different ways of writing Terraform, all depending on the preferences of the individual. As an organization, we agree upon Terraform style standards in order to streamline our workflow and ensure all HCL notation is easily understandable and maintainable.


### Formatting

#### What type of casing should be used?
When naming Terraform resources, snake_casing should be used. When naming files, kebab-casing should be used. So, you could end up with a filename like iam-my_role.tf. 


#### How should HCL be formatted?
HCL should always be formatted prior to submitting to Github using terraform fmt. This can be done automatically using various plugins depending on your preferred IDE or text editor. 


#### Should filenames be capitalized?
No, filenames should be lowercased.


#### How should locals/variables/outputs be arranged?
In general, this sort of data should be organized alphabetically. Certain variable sets, such as desired/min/max counts in autoscaling groups, may be grouped together and placed after the alphabetical variables. Variables that are maps, such as tags, should be placed last. Their keys should be listed alphabetically. For example:

```
  another_var = "another_value"
  my_var_1    = "my_value"
  node_size   = 4

  desired_size = 1
  max_size     = 3
  min_size     = 1

  map_value = {
    this  = "banana"
    value = "orange"
  }
```


### IAM

#### Should inline JSON or Terraform policy documents be used for IAM resources?
Inline JSON often causes frustrating AWS errors due to formatting errors - one extra space can cause errors. Also, using inline JSON often causes invalid IAM resources to plan successfully, so users may not know if a resource is valid until they attempt to apply their changes. Policy documents have native error checking, and also eliminate the need to check JSON formatting. Policy documents are also [recommended as a Terraform best practice](https://learn.hashicorp.com/terraform/aws/iam-policy). 


### Lambdas 

#### Where should Lambda resources be kept?
All Lambda source code and other materials should be kept in a /lambda subfolder.


### Locals

#### When should a local be used?
Locals should be used when a value is comprised of another variable (for example, ${var.env}-instance) and is also used more than once. Locals should also be used when a given value's meaning is unclear to the reader (for example, local.hosted_zone_id).


#### Where should a local be put?
If there are no locals that span use between files, locals can be kept within the resource file. However, if there are locals accessed by multiple files, there should be a locals.tf file.


### Outputs

#### When to add a value to an output?
A value should be included in the outputs either to assure to a human that a resource was successfully created (for example, the name of a resource) or when that output is needed by another resource (for example, the ARN of a resource).


#### Where should an output be put?
Outputs should be kept in outputs.tf.


### Providers

#### Where should a provider be put?
Providers should be maintained in main.tf


### Resources

#### When should a resource file be split?
When a given resource needs more than 2 components it should be split into resource-name1.tf and resource-name2.tf.


#### How should resource files be named?
Resource files should be named like iam.tf or route53.tf or for relatively simple groupings of resources. For more complex situations, such as many (usually at least 2 or 3) similar resources relating to different logical ideas, a more specific naming convention can be used. For example, if a module has IAM resources relating to my-role-1 and my-role-2, you might have:

```
   iam_my-role-1.tf
   iam_my-role-2.tf
```

#### How should resources be named?
Since provider resource names are meant for managing Terraform state, resource names should clearly indicate what infrastructure they are helping to create. For example, if you are creating an EKS cluster and an S3 bucket, you might name resources like the following:

```
  resource aws_eks_cluster my_eks_cluster {
    ...
  }

  resource aws_iam_role my_eks_cluster {
    ...
  }

  resource aws_iam_policy my_eks_cluster {
    ...
  }

  resource aws_s3_bucket my_bucket {
    ...
  }

  resource aws_iam_role my_bucket {
      ...
  }
```

If you need to make many similar resources in relation to another resource (for example, multiple IAM policy attachments), then name that resource according to its function.

```
  resource aws_iam_policy_attachment sns {
    ...
  }
  resource aws_iam_policy_attachment sqs {
    ...
  }
``` 


#### When should resources be dynamically created?
Resources should be dynamically created (for example, through for_each loops) either when the final resource count is not known or is subject to change, or if the total amount of resources needed is more than 2.


#### Should count or for_each be used for dynamic resources?
Whenever possible, for_each should be used.


### Scripts

#### Where should invoked shell scripts be kept?
Shell and other scripts should be kept in a /scripts subfolder.


### Versions

#### Where should versions be defined?
Versions should be defined in versions.tf.

#### What versions should be specified?
Versions should be specified for Terraform, as well as each provider. The Terraform version ensures that it is clear to the user if a repo uses the legacy Terraform 11 or the current Terraform 12. 

#### Should versions be pinned?
Versions should be approximately equivalent. For example:

```
  aws = "~> 2.4"
```

### Variables

#### Where should a variable be defined?
A variable should be defined in a variables.tf file. This way, it is clear what each value represents. For example:

```
  module my_module {
    source       = ""
    my_var       = var.my_var
    my_other_var = var.my_other_var
  }
```

If there are multiple instances of one module, however, some variables can be defined inline if they change between module invocations. For example:

```
  module my_module_instance-1 {
    source       = ""
    disk_size    = 20
    my_var       = var.my_var
    my_other_var = var.my_other_var
    name         = "instance-1"
  }

  module my_module_instance-2 {
    source       = ""
    disk_size    = 10
    my_var       = var.my_var
    my_other_var = var.my_other_var
    name         = "instance-2"
  }
```

####  When should a variable be used?
A variable should be used if a module needs data from the caller repo (for example, the caller AWS account number), or if the value will be periodically updated (for example, the Kubernetes version of an EKS cluster).


#### Where should a variable be put?
Variables should be kept in variables.tf.


### Remote States

#### When should we pull from remote state vs manual input?
Remote state is preferred if the value is easily accessible via remote state lookup or is subject to change. Manual input may be used if the remote state lookup is extremely long or obfuscated, and the value will not change. Note the usage of or vs and in the previous statements.


#### Where do we put remote state lookups?
Remote state lookups should be maintained in main.tf.


### Modules

#### What constitutes a Terraform module?
A Terraform module is a set of complex interdependent Terraform resources that will be instantiated more than once. For example, if each AWS SDLC account needs an instance of an IAM role, that role should be a module. However, if only one account needs that role, then it may be created as usual within the account Terraform. 

If a given set of Terraform resources is needed in multiple AWS accounts, but is NOT complex (ie, contained to one reasonbly sized file), then it may be easier to maintain that file in each account instead of creating a separate module.
