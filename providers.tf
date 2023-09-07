provider "azurerm" {
  features {}
  alias           = "Prod"
  subscription_id = "6ff1da01-3b3d-4db3-bd6e-b5fc68561c96"
}

provider "azurerm" {
  features {}
  alias           = "Dev"
  subscription_id = "960edb14-5680-4e2d-9dd0-d9572040ae41"
}

provider "azurerm" {
  features {}
  alias           = "Test"
  subscription_id = "d5564584-9e08-45cc-a2ff-e951ff6688cc"
}

provider "azurerm" {
  features {}
  alias           = "UAT"
  subscription_id = "7d46ecfe-2287-4bce-98af-2e8fdf0dbaa9"
}
