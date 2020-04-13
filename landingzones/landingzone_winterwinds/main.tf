provider "azurerm" {
  version = "~>2.4.0"
  features {}
}

terraform {
    backend "azurerm" {
    }
}

data "terraform_remote_state" "landingzone_caf_wwr" {
  backend = "azurerm"
  config = {
    storage_account_name  = var.lowerlevel_storage_account_name
    container_name        = var.workspace
    key                   = "landingzone_caf_wwr.tfstate"
    resource_group_name   = var.lowerlevel_resource_group_name
  }
}

locals {  
    prefix                      = data.terraform_remote_state.landingzone_caf_wwr.outputs.prefix
    caf_wwr_accounting  = data.terraform_remote_state.landingzone_caf_wwr.outputs.blueprint_foundations_accounting 
    caf_wwr_security    = data.terraform_remote_state.landingzone_caf_wwr.outputs.blueprint_foundations_security
    global_settings             = data.terraform_remote_state.landingzone_caf_wwr.outputs.global_settings 
}