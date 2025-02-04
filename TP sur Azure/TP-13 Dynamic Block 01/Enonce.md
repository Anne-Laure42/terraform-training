Dynamic Block

Créez un NSG avec 3 règles de sécurité pour les ports suivants : 80 (http), 22 (ssh), 443 (https) en utilisant un "Dynamic Block" et "For each loop"

Exemple:

resource "aws_elastic_beanstalk_environment" "tfenvtest" {
  name                = "tf-test-name"
  application         = "${aws_elastic_beanstalk_application.tftest.name}"
  solution_stack_name = "64bit Amazon Linux 2018.03 v2.11.4 running Go 1.12.6"

  dynamic "setting" {
    for_each = var.settings
    content {
      namespace = setting.value["namespace"]
      name = setting.value["name"]
      value = setting.value["value"]
    }
  }
}


Première possibilité avec :

Une variable "nsg_rules" en type "list(objet)" et un dossier "terraform.tfvars" pour définir les clés-valeurs souhaitées

Exemple:

- variables.tf

variable tenants {
  description = "Map of project names to configuration."
  type = list(object({
    name  = string
    dname = string
    desc  = string
    site  = list(string)
  }))

  - terraform.tfvars

  default = [{
      name  = "Tenant-1",
      dname = "Tenant-1",
      desc  = "Test Tenant 1",
      site  = ["site1", "site2"]
    },
    {
      name  = "Tenant-2",
      dname = "Tenant-2",
      desc  = "Test Tenant 2",
      site  = ["site1"]
    }]
}
