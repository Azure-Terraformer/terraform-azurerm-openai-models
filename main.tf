data "azapi_resource_action" "location_models" {
  type        = "Microsoft.CognitiveServices/locations@2024-10-01"
  resource_id = "/subscriptions/${var.subscription_id}/providers/Microsoft.CognitiveServices/locations/${var.location}"

  action = "models"
  method = "GET"

  response_export_values = ["value"]
}

locals {
  models_raw = data.azapi_resource_action.location_models.output["value"]
  models_latest = {
    for name, versions in {
      for m in local.models_raw :
      m.model.name => m.model.version...
    } :
    name => sort(versions)[
      length(versions) - 1
    ]
  }
}
