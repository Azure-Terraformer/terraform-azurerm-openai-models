# Azure AI Model Version Discovery (Terraform Module)

This Terraform module queries Azure Cognitive Services for a specific
**subscription + location** and returns a **map of model names → their
latest available version**.\
Use this module when you want to **avoid hardcoding model versions** in
your `azurerm_cognitive_deployment` resources.

------------------------------------------------------------------------

## 📥 Inputs

| Name              | Type     | Required | Description                                   |
|-------------------|----------|----------|-----------------------------------------------|
| `subscription_id` | `string` | ✔️       | The Azure subscription ID to query.           |
| `location`        | `string` | ✔️       | The Azure region to query (e.g., `westus3`, `eastus`). |


## 📤 Output

### `latest` (map(string))

A map where:

-   **Key** = model name\
-   **Value** = latest version string for that model in the specified
    location

Example:

    {
      "gpt-35-turbo"        = "1106"
      "gpt-4o"              = "2024-11-20"
      "text-embedding-3-small" = "1"
      "Phi-3.5-mini-instruct"  = "6"
      "Meta-Llama-3.1-70B-Instruct" = "4"
      "tts"                 = "001"
      "whisper"             = "001"
    }

------------------------------------------------------------------------

## 🚀 How to Use

### 1. Call the Module

    module "models" {
      source = "github.com/your-org/terraform-azapi-location-models"

      subscription_id = var.subscription_id
      location        = var.location
    }

### 2. Access the Output

    locals {
      model_versions = module.models.latest
    }

------------------------------------------------------------------------

## 🧩 Example: Use with `azurerm_cognitive_deployment`

    resource "azurerm_cognitive_deployment" "gpt4o" {
      name                 = "gpt-4o"
      cognitive_account_id = azurerm_cognitive_account.openai.id

      sku {
        name     = "Standard"
        capacity = 10
      }

      model {
        format  = "OpenAI"
        name    = "gpt-4o"
        version = module.models.latest["gpt-4o"]
      }
    }

------------------------------------------------------------------------

## 📝 Summary

This module:

-   Takes **subscription ID** and **location**
-   Queries Azure for all model versions in that region
-   Picks the **latest version** of each model
-   Returns a **simple map** you can plug into deployments

Future‑proof your Azure OpenAI deployments with zero manual version
updates.
