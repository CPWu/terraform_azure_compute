data "azurerm_public_ip" "public_ips" {
    count                               = var.NODE_COUNT
    name                                = azurerm_public_ip.sandbox_public_ip[count.index].name
    resource_group_name                 = azurerm_linux_virtual_machine.server[count.index].resource_group_name

    depends_on = [
        azurerm_linux_virtual_machine.server
    ]
}

resource "azurerm_resource_group" "sandbox_rg" {
    name                                =var.RESOURCE_GROUP_NAME
    location                            =var.AZURE_REGION
}

 resource "azurerm_virtual_network" "sandbox_vnet" {
    name                                = "${azurerm_resource_group.sandbox_rg.name}-vnet"
    location                            = var.AZURE_REGION
    resource_group_name                 = var.RESOURCE_GROUP_NAME
    address_space                       = [var.VNET_ADDRESS_SPACE]

}

resource "azurerm_subnet" "sandbox_subnet" {
    name                                = "${var.RESOURCE_GROUP_NAME}-subnet"
    virtual_network_name                = azurerm_virtual_network.sandbox_vnet.name
    resource_group_name                 = var.RESOURCE_GROUP_NAME
    address_prefixes                    = [var.SUBNET_ADDRESS_PREFIX]
}

resource "azurerm_network_interface" "sandbox_nic" {
    name                                = "${var.SERVER_NAME}-${format("%02d",count.index)}-nic"
    location                            = var.AZURE_REGION
    resource_group_name                 = var.RESOURCE_GROUP_NAME
    count                               = var.NODE_COUNT

    ip_configuration {
        name                                      = "${var.SERVER_NAME}-ip"  
        subnet_id                                 = azurerm_subnet.sandbox_subnet.id
        private_ip_address_allocation             = "dynamic"
        public_ip_address_id                      = count.index == 0 ? element(azurerm_public_ip.sandbox_public_ip.*.id,count.index) : null    
    }

    depends_on = [
        azurerm_public_ip.sandbox_public_ip[1],
    ]
}

resource "azurerm_public_ip" "sandbox_public_ip" {
  name                                        = "${var.SERVER_NAME}-${format("%02d",count.index)}-public-ip"
  location                                    = var.AZURE_REGION
  resource_group_name                         = var.RESOURCE_GROUP_NAME
  allocation_method                           = var.IP_TYPE
  count                                       = var.NODE_COUNT

  depends_on = [
      azurerm_resource_group.sandbox_rg,
  ]
}

resource "azurerm_network_security_group" "server_nsg" {
    name                                      = "${var.SERVER_NAME}-nsg"
    location                                  = var.AZURE_REGION
    resource_group_name                       = var.RESOURCE_GROUP_NAME

    depends_on = [
        azurerm_resource_group.sandbox_rg,
    ]
}

resource "azurerm_network_security_rule" "server_nsg_rule_rdp" {
    name                                        = "SSH"
    priority                                    = 100
    direction                                   = "Inbound"
    access                                      = "Allow"
    protocol                                    = "TCP"
    source_port_range                           = "*"
    destination_port_range                      = "22"
    source_address_prefix                       = "*"
    destination_address_prefix                  = "*"
    resource_group_name                         = var.RESOURCE_GROUP_NAME
    network_security_group_name                 = azurerm_network_security_group.server_nsg.name
}

resource "azurerm_subnet_network_security_group_association" "sandbox_nsg_association" {
    network_security_group_id                   = azurerm_network_security_group.server_nsg.id
    subnet_id                                   = azurerm_subnet.sandbox_subnet.id
}

resource "azurerm_linux_virtual_machine" "server" {
    name                                        = "${var.SERVER_NAME}-${format("%02d",count.index)}"
    resource_group_name                         = var.RESOURCE_GROUP_NAME
    location                                    = var.AZURE_REGION
    size                                        = "Standard_B1s"
    admin_username                              = var.SERVER_USERNAME
    admin_password                              = var.SERVER_PASSWORD
    disable_password_authentication             = false
    count                                       = var.NODE_COUNT

    network_interface_ids = [
        element(azurerm_network_interface.sandbox_nic.*.id,count.index)
    ]

    os_disk {
        caching                                 = "ReadWrite"
        storage_account_type                    = "Standard_LRS"
    }

    source_image_reference {
        publisher                               = "Canonical"
        offer                                   = "UbuntuServer"
        sku                                     = "18.04-LTS"
        version                                 = "latest"
    }

    depends_on = [
        azurerm_network_interface.sandbox_nic,
    ]
}