output "id" {
  description = "Container Group IDs"
  value = concat(azurerm_container_group.aci.*.id, [""])
}

output "fqdn" {
  description = "Container Group FQDNs"
  value = concat(azurerm_container_group.aci.*.fqdn, [""])
}

output "name" {
  description = "Container Group Names"
  value = concat(azurerm_container_group.aci.*.name, [""])
}

