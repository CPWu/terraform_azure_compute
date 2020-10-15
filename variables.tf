// Provider Variables

variable "SUBSCRIPTION_ID" {
    type = string
}
variable "CLIENT_ID" {
    type = string
}
variable "CLIENT_SECRET" {
    type = string
}
variable "TENANT_ID" {
    type = string
}

variable "RESOURCE_GROUP_NAME" {
    type = string
    default = "sandbox-rg"
}
variable "AZURE_REGION" {
    type = string
    default = "canadacentral"
}

variable "VNET_ADDRESS_SPACE" {
    type = string
    default = "10.0.0.0/16"
}
variable "SUBNET_ADDRESS_PREFIX" {
    type = string
    default = "10.0.2.0/24"
}

variable "SERVER_NAME" {
    type = string
    default = "sandbox"
}
variable "IP_TYPE" {
    type = string
    default = "Static"
}