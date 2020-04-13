#Create the resource groups to host the blueprint
resource "azurecaf_naming_convention" "rg_coresec_name" {  
  name    = var.resource_groups_hub.HUB-CORE-SEC.name
  prefix  = var.prefix
  resource_type    = "rg"
  max_length = 50
  convention  = var.convention
}

resource "azurecaf_naming_convention" "rg_operations_name" {  
  name    = var.resource_groups_hub.HUB-OPERATIONS.name
  prefix  = var.prefix
  resource_type    = "rg"
  max_length = 50
  convention  = var.convention
}

resource "azurerm_resource_group" "rg_coresec" {
  name     = azurecaf_naming_convention.rg_coresec_name.result
  location = var.resource_groups_hub.HUB-CORE-SEC.location
  tags     = local.tags
}

resource "azurerm_resource_group" "rg_operations" {
  name     = azurecaf_naming_convention.rg_operations_name.result
  location = var.resource_groups_hub.HUB-OPERATIONS.location
  tags     = local.tags
}

#Set up the cluster 
resource "azurerm_kubernetes_cluster" "k8s" {
  name                = "wwr-k8s"
  location            = azurerm_resource_group.cot.location
  resource_group_name = azurerm_resource_group.cot.name
  dns_prefix          = "wwr"
  depends_on          = [azurerm_role_assignment.k8s]
  # TODO VERSION

  default_node_pool {
    name            = "agentpool"
    node_count      = "5"
    vm_size         = "Standard_DS1_v2"
  }

# Set it up
module "k8s" {
  source = "../../"
  
  prefix                      = local.prefix
  convention                  = local.convention
  name                        = local.name
  resource_group_name         = module.rg_test.names.test
  location                    = local.location 
  tags                        = local.tags
  # to be enabled for vnext log analytics/diagnostics extension
  # log_analytics_workspace_id  = module.la_test.id
  # diagnostics_map             = module.diags_test.diagnostics_map
  # diagnostics_settings        = local.diagnostics

  network_interface_ids       = [azurerm_network_interface.nic_test.id]
  primary_network_interface_id= azurerm_network_interface.nic_test.id
  os                          = local.os
  os_profile                  = local.os_profile
  storage_image_reference     = local.storage_image_reference
  storage_os_disk             = local.storage_os_disk
  vm_size                     = local.vm_size
}
#Specify the operations diagnostic logging repositories 
module "diagnostics_logging" {
  source  = "aztfmod/caf-diagnostics-logging/azurerm"
  version = "2.0.1"

  convention            = var.convention
  name                  = var.accounting_settings.azure_diagnostics_logs_name
  enable_event_hub      = var.accounting_settings.azure_diagnostics_logs_event_hub
  prefix                = var.prefix
  resource_group_name   = azurerm_resource_group.rg_operations.name
  location              = var.location
  tags                  = local.tags
}

#Create the Azure Monitor - Log Analytics workspace
module "log_analytics" {
  source  = "aztfmod/caf-log-analytics/azurerm"
  version = "2.0.1"

  convention          = var.convention
  prefix              = var.prefix
  name                = var.accounting_settings.analytics_workspace_name
  solution_plan_map   = var.accounting_settings.solution_plan_map
  resource_group_name = azurerm_resource_group.rg_operations.name
  location            = var.location
  tags                = local.tags
}