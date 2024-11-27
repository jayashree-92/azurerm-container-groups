variable "purpose_name" {
  description = "Purpose name for naming convention"
  type        = string
}

variable "function_name" {
  description = "Function name for naming convention"
  type        = string
}

variable "location" {
  description = "Azure location for resources"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group Name to use for resources"
  type        = string
}

variable "location_code" {
  description = "Location code for naming convention"
  type        = string
}

variable "environment_code" {
  description = "Environment code for naming convention"
  type        = string
}

variable "ip_address_type" {
  description = "Specifies the IP address type of the container. Public, Private or None. Changing this forces a new resource to be created. If set to Private, subnet_ids also needs to be set."
  type        = string
  default     = "Public"
}

variable "dns_name_label" {
  description = "The DNS label/name for the container group's IP. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "os_type" {
  description = "The OS for the container group. Allowed values are Linux and Windows. Changing this forces a new resource to be created."
  type        = string
  default     = "Linux"
}

variable "subnet_ids" {
  description = "(Optional) The subnet resource IDs for a container group. Changing this forces a new resource to be created."
  type        = list(string)
  default     = []
}

variable "image_registry_credential_username" {
  description = "The username with which to connect to the registry. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "image_registry_credential_password" {
  description = "The password with which to connect to the registry. Changing this forces a new resource to be created."
  type        = string
  default     = null
  sensitive   = true
}

variable "image_registry_credential_server" {
  description = "The address to use to connect to the registry without protocol ('https'/'http')."
  type        = string
}

variable "containers" {
  description = "Configuration for each container in the container group."
  type = list(object({
    name   = string
    image  = string
    cpu    = number
    memory = number

    environment_variables        = optional(map(string))
    secure_environment_variables = optional(map(string))

    ports = list(object({
      port     = number
      protocol = string
    }))
  }))
  default = []
}

variable "secure_environment_variables" {
  description = "Secure variables for containers"
  type        = map(any)
  default     = {}
}

variable "dns_config" {
  description = "DNS Configuration Block"
  type = object({
    nameservers    = list(string)
    search_domains = optional(list(string))
  })
  default = null
}
