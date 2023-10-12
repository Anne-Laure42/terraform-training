


###  TP-5  - Remote Backend

- Dans le fichier main.tf, ajouter les ressources pour créez un conteneur (blob storage) dans un compte de stockage.
  
- Lancez les commandes "terraform plan" et "terraform apply" avec les fichiers du tp-4. Une fois l'infra déployée, créez un fichier backend.tf et insérez le code nécessaire à la création d'un backend pour le ".tfstate".

- Vérifiez après avoir lancé un déploiement que le fichier ".tfstate" est bien créé dans le "Blob" et contient les infos à jour.

- BONUS : Ajoutez une variable "locals" avec des tags "environement" et "owner" dans le fichier provider.tf

- Une fois terminé, supprimez vos ressources avec terraform destroy
  
- Ne pas oublier de supprimer les fichiers .terraform (ls -la) pour ne pas avoir de message d'erreur lors du prochain "terraform init"

- Créez un dossier **tp-5** comme vous l’avez fait au **tp-4** pour conserver votre code


### Solution :

Le fichier `main.tf` est fourni

Commande :

```shell
terraform init --migrate-state
```

Affichage en sortie:

```shell
Initializing the backend...

Successfully configured the backend "azurerm"! Terraform will automatically
use this backend unless the backend configuration changes.

Initializing provider plugins...


Terraform has made some changes to the provider dependency selections recorded
in the .terraform.lock.hcl file. Review those changes and commit them to your
version control system if they represent changes you intended to make.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

```
