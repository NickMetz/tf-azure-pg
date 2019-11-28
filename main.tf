provider "azurerm" {
  version = "=1.37.0"
  // client_id       = "${Replace with client_id}"
  // subscription_id = "${Replace with subscription_id}"
  // tenant_id       = "${Replace with tenant_id}"
  // client_secret   = "${Replace with client_secret}"
}

provider "random" {
  version = "=2.2.1"
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = "westeurope"
}

resource "azurerm_postgresql_server" "pg_server" {
  name                = "azure-postgresql-server"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  sku {
    name     = var.sku_name
    capacity = var.sku_capacity
    tier     = var.sku_tier
    family   = var.sku_family
  }

  storage_profile {
    storage_mb            = 5120
    backup_retention_days = 7
    geo_redundant_backup  = "Disabled"
    auto_grow             = "Enabled"
  }

  administrator_login          = "pgadmin"
  administrator_login_password = random_password.password.result
  version                      = "11"
  ssl_enforcement              = "Enabled"

}

resource "azurerm_postgresql_database" "pg_db" {
  for_each            = var.pg_databases
  name                = each.key
  resource_group_name = azurerm_resource_group.resource_group.name
  server_name         = azurerm_postgresql_server.pg_server.name
  charset             = lookup(each.value, "charset", "UTF8")
  collation           = lookup(each.value, "collation", "en-US")
}



