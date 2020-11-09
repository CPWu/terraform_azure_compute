# Terraform Azure Compute Module

This repo will use Terraform/Azure/Github Actions to provision three basic compute instances.

## Tech Stack

* [Terraform CLI](https://www.terraform.io) v0.13.4
* [Azure Terraform Provider](https://www.terraform.io/docs/providers/azurerm/index.html#features) v2.20.0
* [Azure CLI](https://azure.microsoft.com) v2.14.0
* [Azure](https://azure.microsoft.com)
* [Github](https://www.github.com)
* [Github Actions](https://github.com/features/actions)

## Authentication to Azure

1. Authentication to Azure Using Service Principal
    - Azure Active Directory > App registrations > New registration
    - Generate Client Secret
    - Assign RBAC through IAM (Contributor)

## Usage

Non-Modular approach to creating this stack, as currently there are some issues with Terraform & Azure handling argument based initialization of resources.

## Variable Values

To be developed

## Outputs

To be developed

## History

## Authors

## License

