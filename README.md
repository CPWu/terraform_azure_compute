# terraform_azure_compute

This repo will use Terraform/Azure/Github Actions to provision a basic compute using CI/CD

## Tech Stack
* [Terraform CLI](https://www.terraform.io) v0.13.4
* [Azure Terraform Provider](https://www.terraform.io/docs/providers/azurerm/index.html#features) v2.20.0
* [Azure CLI](https://azure.microsoft.com) v2.13.0
* [Azure](https://azure.microsoft.com)
* [Github](https://www.github.com)
* [Github Actions](https://github.com/features/actions)

### Authentication to Azure
1. Authentication to Azure Using Service Principal
    - Azure Active Directory > App registrations > New registration
    - Generate Client Secret
    - Assign RBAC through IAM (Contributor)
2. Environment Variables
    - ARM_TENANT_ID, ARM_SUBSCRIPTION_ID
    - ARM_CLIENT_ID, ARM_CLIENT_ID
3. Hardcoded
4. MSI

