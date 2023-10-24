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


Deuxième possibilité avec :

Une variable "nsg_rules" en type "map(objet)" 

Exemple:

variable "custom_variables" {
  type = map(object({
    node_count = number
    vm_size    = string
  }))

  default = {
    wksp1 = {
      node_count = 2
      vm_size    = "Standard_D2_v3"
    },
    wksp2 = {
      node_count = 5
      vm_size    = "Standard_D2_v5"
    }
  }
}
