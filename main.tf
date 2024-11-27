#---------------------------------------------------------
# Generates Random String for resources naming
#---------------------------------------------------------
resource "random_string" "unique_4" {
  length      = 4
  special     = false
  upper       = false
  min_numeric = 2
}

resource "azurerm_container_group" "aci" {
  name                = format("aci-%s-%s-%s-%s", var.function_name, local.full_env_code, var.purpose_name, random_string.unique_4.result)
  resource_group_name = var.resource_group_name
  location            = var.location
  ip_address_type     = var.ip_address_type
  dns_name_label      = var.dns_name_label
  os_type             = var.os_type
  subnet_ids          = var.subnet_ids

  dynamic "dns_config" {
    for_each = var.dns_config != null ? [var.dns_config] : []
    content {
      nameservers    = dns_config.value.nameservers
      search_domains = dns_config.value.search_domains
    }
  }

  image_registry_credential {
    username = var.image_registry_credential_username
    password = var.image_registry_credential_password
    server   = var.image_registry_credential_server
  }

  dynamic "container" {
    for_each = var.containers
    content {
      name   = container.value.name
      image  = container.value.image
      cpu    = container.value.cpu
      memory = container.value.memory

      dynamic "ports" {
        for_each = container.value.ports
        content {
          port     = ports.value.port
          protocol = ports.value.protocol
        }
      }
      environment_variables        = container.value.environment_variables
      secure_environment_variables = container.value.secure_environment_variables

    }
  }
}
