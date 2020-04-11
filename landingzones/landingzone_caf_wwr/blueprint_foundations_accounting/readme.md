# blueprint WinterWinds accounting

Blueprint_Winterwinds sets up the Azure environment 

## Capabilities

WinterWinds Robotics deploys the following components:

 - Resource groups
    - Core resource groups for foundation resources
 - Activity Logging
    - Auditing all subscription activities and archiving
        - Storage Account
        - Event Hubs (optional)
 - Diagnostics Logging
    - All operations logs kept for 30 days
        - Storage Account
        - Event Hubs
 - Log Analytics
    - Stores all the operations logs
    - Solutions management

## Customization

Customization happens at the landing zone using the variables.


