data "aws_kms_key" "this" {
    count                   = var.kms.aws_managed ? 1 : 0

    key_id                  = local.platform_defaults.aws_managed_key_alias
}