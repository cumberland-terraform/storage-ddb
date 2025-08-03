# Enterprise Terraform 
## Cumberland Cloud Platform
## AWS Storage - DynamoDB

This module provides a DynamoDB table.

### Usage

The bare minimum deployment can be achieved with the following configuration,

***providers.tf**

```hcl
provider "aws" {
    region                  = "us-east-1"

    assume_role {
        role_arn            = "arn:aws:iam::<target-account>:role/<target-role>"
    }
}
```
**modules.tf**

```
module "dynamodb" {
	source 					= "github.com/cumberland-terraform/storage-ddb.git"
	
	platform				= {
		client          	= "<client>"
    	environment         = "<environment>"
	}

	dynamo 					= {
		suffix 				= "<suffix>"
        attributes          = {
            name            = "<name>
            type            = "<type>
            partition       = true
        }
	}

    kms 					= {
		aws_managed 		= true
	}

}
```

`platform` is a parameter for *all* **Cumberland Cloud** modules. For more information about the `platform`, in particular the permitted values of the nested fields, see the ``platform`` module documentation. 

## KMS Key Deployment Options

### 1: Module Provisioned Key

If the `var.kms` is set to `null` (default value), the module will attempt to provision its own KMS key. This means the role assumed by Terraform in the `provider` 

### 2: User Provided Key

If the user of the module prefers to use a pre-existing customer managed key, the `id`, `arn` and `alias_arn` of the `var.kms` variable must be passed in. This will override the provisioning of the KMS key inside of the module.

### 3: AWS Managed Key

If the user of the module prefers to use an AWS managed KMS key, the `var.kms.aws_managed` property must be set to `true`.
