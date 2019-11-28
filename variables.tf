variable "resource_group_name" {}
variable "sku_name" {}
variable "sku_capacity" {}
variable "sku_tier" {}
variable "sku_family" {}

variable "pg_databases" {
  type        = map(map(string))
  description = "Postgresql databases to create."
  default = {
    "pgdb1" = {}
    "pgdb2" = {}
    "pgdb3" = {}
  }
}