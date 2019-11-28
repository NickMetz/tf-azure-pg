## Terraform Azure Provider 
- Azure Postgresql Server
- Azure Postgresql Database

# Instruction 
 1. Download Terraform https://www.terraform.io/downloads.html
 2. Configure Authenthication via settings in main.tf > azure provider block or environment variables
 - Replace Placeholder:
   - client_id       = "${Replace with client_id}"
   - subscription_id = "${Replace with subscription_id}"
   - tenant_id       = "${Replace with tenant_id}"
   - client_secret   = "${Replace with client_secret}"
 - Set Environment variables:
   - ARM_CLIENT_ID       = "${Replace with client id}"
   - ARM_SUBSCRIPTION_ID = "${Replace with subscription id}"
   - ARM_TENANT_ID       = "${Replace with tenant id}"
   - ARM_CLIENT_SECRET   = "${Replace with client secret}"
 3. Initialize Terraform provider plugins
   - Run: "$ terraform init"
 4. Run Test for Postgresql
   - Basic tier: "$ terraform apply --var-file ./basic.tfvars"
   - GP tier: "$ terraform apply --var-file ./gp.tfvars"
 5. In case of basic we will see this error by creation of postgresql database 
   - Error: Code="OperationTimedOut" Message="The operation timed out and automatically rolled back. Please retry the operation."
 6. Cleanup Test for Postgres
   - Basic tier: "$ terraform destroy --var-file ./basic.tfvars"
   - GP tier: "$ terraform apply --var-file ./gp.tfvars"

Debug API Calls set this env variables:
  - AZURE_GO_SDK_LOG_LEVEL="Debug"
  - AZURE_GO_SDK_LOG_FILE="${Set path to logfile}"