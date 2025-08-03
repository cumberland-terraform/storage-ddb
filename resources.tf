resource "aws_dynamodb_table" "this" {
    lifecycle {
        ignore_changes      = [ 
                                tags,
                                server_side_encryption
                            ]
    }
    
    name                    = local.name
    billing_mode            = local.platform_defaults.billing_mode
    hash_key                = local.hash_key
    range_key               = local.range_key
    tags                    = local.tags

    dynamic "attribute" {
        for_each                = var.dynamo.attributes
        content {
            name                = attribute.value.name
            type                = attribute.value.type
        }
    }

    server_side_encryption {
        enabled             = true
        kms_key_arn         = local.kms.arn
    }
}

