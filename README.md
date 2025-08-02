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

}
```

**NOTE**: `platform` is a parameter for *all* **Cumberland Cloud** modules. For more information about the `platform`, in particular the permitted values of the nested fields, refer to the platform module documentation.