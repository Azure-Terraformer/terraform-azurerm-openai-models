
module "openai_models" {

  source = "../"

  subscription_id = var.subscription_id
  location        = var.location

}

resource "local_file" "aoai_models_file" {
  filename = "${path.module}/aoai-models.json"
  content  = jsonencode(module.openai_models.latest)
}
