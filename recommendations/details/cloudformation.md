# CloudFormation
Moda should be capturing infrastructure assets in committed code ([why it is important](https://www.hashicorp.com/resources/what-is-infrastructure-as-code)). CloudFormation is the AWS-native way to do IaC. Please see commentary on [Terraform](#terraform) for reasons why CloudFormation is not recommended.

## Note regarding AWS CDK (Cloud Development Kit)
Per the [CDK FAQ](https://aws.amazon.com/cdk/faqs):
```
Since AWS CDK leverages CloudFormation, AWS CDK applications are subject to the same limits imposed by the CloudFormation service.
```
As such, the CDK should be considered on `Hold` because CloudFormation itself is.
