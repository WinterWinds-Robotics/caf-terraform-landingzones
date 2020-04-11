
variable "prefix" {
  description = "(Optional) Prefix to uniquely identify the deployment"  
}

variable "resource_groups_hub" {
  description = "(Required) Contains the resource groups object to be created for hub"
}

# Resource_Groups:
# resource_groups = {
 #    apim          = { 
  #                   name     = "-apim-prod"
   #                  location = "centralus" 
    # },
 #    networking    = {    
 #                    name     = "-networking-prod"
 #                    location = "centralus" 
 #    },
 #    insights      = { 
 #                    name     = "-insights-prod"
 #                    location = "centralus" 
 #                    tags     = {
 #                      project     = "Olympus-Mons"
 #                      approver     = "Earthling"
 #                    }   
 #    },
 #}

variable "location" {
  description = "Azure region to create the resources"
  type        = string
}

# Location:
# location = "centralus"

variable "tags_hub" {
  description = "map of the tags to be applied"
  type    = map(string)
}

variable "convention" {

}

variable "accounting_settings" {

}