resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "local_file" "script_up" {
  content  = file("./up.sh")
  filename = "ScriptUp"
}

resource "local_file" "script_down" {
  content  = file("./down.sh")
  filename = "ScriptDown"
}

resource "azurerm_automation_account" "example" {
  name                = "account1"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  identity {
    type = "SystemAssigned"
  }

  sku_name = "Basic"
}

resource "azurerm_automation_runbook" "exampleUp" {
  name                    = "ResizeUpVM"
  location                = azurerm_resource_group.example.location
  resource_group_name     = azurerm_resource_group.example.name
  automation_account_name = azurerm_automation_account.example.name
  log_verbose             = "true"
  log_progress            = "true"
  description             = "This is runbook resize up a virtual machine"
  runbook_type            = "PowerShell"

  content = data.local_file.script_up.content
}

resource "azurerm_automation_runbook" "exampleDown" {
  name                    = "ResizeDownVM"
  location                = azurerm_resource_group.example.location
  resource_group_name     = azurerm_resource_group.example.name
  automation_account_name = azurerm_automation_account.example.name
  log_verbose             = "true"
  log_progress            = "true"
  description             = "This is runbook resize down a virtual machine"
  runbook_type            = "PowerShell"

  content = data.local_file.script_up.content
}