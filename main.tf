resource "azurerm_network_interface" "nic_block" {
    for_each = var.nic_map
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name


  ip_configuration {
    name                          = each.value.ip_config_name
    subnet_id = data.azurerm_subnet.subnet_data[each.key].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = lookup(each.value, "public_ip_name", null) != null ? data.azurerm_public_ip.pip_data[each.key].id : null
  }
}



