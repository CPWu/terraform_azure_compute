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
    default = "temporary-rg"
}
variable "AZURE_REGION" {
    type = string
    default = "canadacentral"
}