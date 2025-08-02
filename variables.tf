variable "platform" {
    description                 = "Platform metadata configuration object."
    type                        = object({
        client                  = string
        environment             = string
    })
}

variable "dynamo" {
    description                 = "DynamoDB configuration object"
    type                        = object({
        suffix                  = string
        attributes              = list(object({
            name                = string
            type                = string
            partition           = optional(bool, false)
            sort                = optional(bool, false)
        }))
    })

    validation {
        condition               = length([for attr in var.dynamo.attributes : attr if attr.partition == true]) == 1
        error_message           = "Exactly one attribute must be specified as the partition key (partition = true)."
    }

    validation {
        condition               = length([for attr in var.dynamo.attributes : attr if attr.sort == true]) <= 1
        error_message           = "A maximum of one attribute can be specified as the sort key (sort = true)."
    }
}

variable "kms" {
    description                 = "KMS configuration object"
    type                        = object({
        aws_managed             = optional(bool, true)
        id                      = optional(string, null)
        arn                     = optional(string, null)
        alias_arn               = optional(string, null)
    })
    default                     = {
        aws_managed             = true
        id                      = null
        arn                     = null
        alias_arn               = null
    }
}