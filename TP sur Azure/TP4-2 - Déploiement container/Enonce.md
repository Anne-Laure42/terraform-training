TP4 - Déploiment d'un container nginx dans la VM

A partir du code du tp-4, vous allez le modifier pour installer docker et créer un container tournant avec Nginx.

Créez un fichier script nommé "customdata.sh" et ajoutez les commandes qui permettent d'installer Docker et de créer son container.

Dans le fichier main.tf, utilisez la fonction "filebase64" (lien: https://developer.hashicorp.com/terraform/language/functions/filebase64) à l'intérieur du bloc azurerm_linux_virtual_machine afin que Terraform exécute ce dernier.
