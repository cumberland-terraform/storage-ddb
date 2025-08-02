locals {
    ## PLATFORM DEFAULTS
    #   These are platform specific configuration options. They should only need
    #       updated if the platform itself changes.   
    platform_defaults           = {
        billing_mode            = "PAY_PER_REQUEST"

    }

     ## CONDITIONS
    #   Configuration object containing boolean calculations that correspond
    #       to different deployment configurations.
    conditions                  = {
        provision_kms_key       = var.kms == null
    }

    ## CALCULATED PROPERTIES
    #   Variables that change based on the deployment configuration. 
    kms                         = local.conditions.provision_kms_key ? (
                                    module.kms[0].key
                                ) : !var.kms.aws_managed ? (
                                    var.kms
                                ) : null

    hash_key                    =  one([
        for attr in var.dynamo.attributes : attr.name if attr.partition == true
    ])

    range_key                   =  can([
        for attr in var.dynamo.attributes : attr.name if attr.sort == true][0]
    ) ? [for attr in var.dynamo.attributes : attr.name if attr.sort == true][0] : null

    tags                        = merge({
        # TODO: Dynamo specific tags
    }, module.platform.tags)

    name                        = lower(join("-", [
                                    module.platform.prefix,
                                    var.dynamo.suffix
                                ]))
}

