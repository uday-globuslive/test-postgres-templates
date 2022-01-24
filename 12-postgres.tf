

resource "azurerm_private_dns_zone" "example" {
  name                = "${azurerm_resource_group.postgres_rg.name}-${var.environment}.private.postgres.database.azure.com" #"example.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.postgres_rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "example" {
  name                  = "${var.vnet}"
  private_dns_zone_name = azurerm_private_dns_zone.example.name
  virtual_network_id    = azurerm_virtual_network.aksvnet.id #var.virtual_network_id
  resource_group_name   = azurerm_resource_group.postgres_rg.name
}

resource "azurerm_postgresql_flexible_server" "example" {
  name                   = "${azurerm_resource_group.postgres_rg.name}-${var.environment}"
  resource_group_name    = azurerm_resource_group.postgres_rg.name
  location               = azurerm_resource_group.postgres_rg.location
  version                = "13"
  delegated_subnet_id    = azurerm_subnet.example2.id
  private_dns_zone_id    = azurerm_private_dns_zone.example.id
  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password
  zone                   = "1"

  storage_mb = 131072

  sku_name   = var.postgres_sku #"GP_Standard_D2s_v3"
  depends_on = [azurerm_private_dns_zone_virtual_network_link.example]

  # New props
  backup_retention_days = 7
  
  ## Not working
  #geo_redundant_backup  = "Disabled"

}
/*
resource "azurerm_postgresql_database" "example" {
  name                = "martdatabase"
  resource_group_name = azurerm_resource_group.postgres_rg.name
  server_name         = azurerm_postgresql_flexible_server.example.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
  depends_on          = [azurerm_postgresql_flexible_server.example]
}
*/
