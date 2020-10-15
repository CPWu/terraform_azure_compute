resource "azurerm_resource_group" "resouce_group" {
    name                                =var.RESOURCE_GROUP_NAME
    location                            =var.AZURE_REGION
}

