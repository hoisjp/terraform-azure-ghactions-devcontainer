# devcontainer for Terraform and Azure
You can get started the following things instantly after fork and git clone. The [VS Code Remote Development (Remote - Containers)](https://code.visualstudio.com/docs/remote/containers) enables us to do these with few installation.

- Manage Azure by Terraform 
  - `terraform` and Azure CLI `az` command are already installed on Docker container
- Run it on GitHub Actions

# Get started

## Requirement

Prepare the followings, 

1. Visual Studio Code : https://code.visualstudio.com/download
1. VS Code Extension : [VS Code Remote Development (Remote - Containers)](https://code.visualstudio.com/docs/remote/containers)
1. Docker Desktop (in any OS) : https://www.docker.com/get-started

That's all!

## Let's get started
1. Confirm that the Docker Desktop is running.
1. Fork this repository on GitHub (recommend fork to to your private repository just to avoid something like a key leakage).
1. Git clone to your local.
    ```sh
    git clone <your repository>
    ```
1. Open VS code on your repository directory, and click Remote Development icon at the bottom left. (Or, you can open the following step from Command Parret as well)  
    ![VS Code Remote Development](docs/images/launch-vscode-remotecontainer-01.png)
1. Select `Remote-Containers: Reopen in Containers...` on the launched menu  
    ![Reopen in containers](docs/images/vscode-remote-menu-reopenincontainer.png)
1. Open terminal in VS Code and try...  
    ```sh
    $ terraform -v
    Terraform v0.12.29
    
    $ az --version
    azure-cli                          2.9.1
    ...
    ```
    Yes! You are ready to go!

    FYI: Also `tflint` and `terragrunt` are installed. See also the [Dockerfile](.devcontainer/Dockerfile) for the detail.

# Go for Azure

## Terraform backends on Azure Storage
First, let's get start from the creating the [Terraform backends on Azure Storage](https://www.terraform.io/docs/backends/types/azurerm.html).

1. Open the VS code terminal. You are now in repository home.
    ```sh
    $ pwd
    /workspace/<your repository name>
    ```
1. Login to Azure. You will be ask to open the login page and enter the given code (the part `************` in below).
    ```sh
    $ az login
    To sign in, use a web browser to open the page https://microsoft.com/devicelogin and enter the code ************ to authenticate.
    ```
    If login succeeded, you will see the Azure subscription list in JSON format.
1. Select the appropriate subscription and run this with GUID on `id` property.
    ```sh
    $ az account set --subscription <your subscription GUID>
    ```
1. Go to the below directory.
    ```sh
    $ cd 00-create-azurerm-backend
    ```
1. Run the `terraform init`
    ```sh
    $ terraform init

    Initializing the backend...

    Initializing provider plugins...

    Terraform has been successfully initialized!

    You may now begin working with Terraform. Try running "terraform plan" to see
    any changes that are required for your infrastructure. All Terraform commands
    should now work.

    If you ever set or change modules or backend configuration for Terraform,
    rerun this command to reinitialize your working directory. If you forget, other
    commands will detect it and remind you to do so if necessary.
   ```
1. Run the `terraform plan`, and you will be asked the name of storage account. Try the one to be unique globally.
    ```sh
    $ terraform plan

    var.backend_storage_account_name
    Storage account name for terraform backend

    Enter a value: ****
    ```
    Okay if you see this terraform plan output.
    ```
    ...
    ...
    Plan: 3 to add, 0 to change, 0 to destroy.
    ```

    Notice: If you are not login to Azure, you will see this error message. Please go back to `az login`.
    ```
    Error: Error building AzureRM Client: Authenticating using the Azure CLI is only supported as a User (not a Service Principal).
    ```
1. Run the `terraform apply`, and you will be asked the name of storage account again. Entry the same one.
    ```sh
    $ terraform apply

    var.backend_storage_account_name
    Storage account name for terraform backend

    Enter a value: ****
    ```
    You will be asked the confirmation message. Entry `yes` if okay.
    ```sh
    ...
    ...
    Plan: 3 to add, 0 to change, 0 to destroy.

    Do you want to perform these actions?
    Terraform will perform the actions described above.
    Only 'yes' will be accepted to approve.

    Enter a value: yes
    ```
    Wait a little...
    ```
    azurerm_resource_group.rg: Creating...
    azurerm_resource_group.rg: Creation complete after 0s [id=/subscriptions/****GUID****/resourceGroups/terraform-rg]
    azurerm_storage_account.strg: Creating...
    azurerm_storage_account.strg: Still creating... [10s elapsed]
    azurerm_storage_account.strg: Still creating... [20s elapsed]
    azurerm_storage_account.strg: Creation complete after 20s [id=/subscriptions/****GUID****/resourceGroups/terraform-rg/providers/Microsoft.Storage/storageAccounts/****your storage account name****]
    azurerm_storage_container.strg-container: Creating...
    azurerm_storage_container.strg-container: Creation complete after 0s [id=https://********.blob.core.windows.net/tfstate]
    ```

    Finished!
    ```
    Apply complete! Resources: 3 added, 0 changed, 0 destroyed.
    ```
1. Check if the storage accont is created.
    ```sh
    $ az group show --name terraform-rg --out table
    (result)
    
    $ az storage account show --name '<replace by yours>' --out table
    (result)
    ```

# Go for GitHub Actions


# Customize
You want to customize? Check these files. These are the tricks. See also the [VS Code document](https://code.visualstudio.com/docs/remote/containers) how to customize.

- [.devcontainer/devcontainer.json](.devcontainer/devcontainer.json)
- [.devcontainer/Dockerfile](.devcontainer/Dockerfile)

## Personalize by dotfiles

You can personalize by dotfiles mechanizm as you like it.

[.devcontainer/devcontainer.json](.devcontainer/devcontainer.json)
```json
    "settings": {
        // ...
        // dotfiles
        "dotfiles.repository": "hoisjp/terraform-azure-ghactions-devcontainer", // change here to your repository.
        "dotfiles.targetPath": "~/.devcontainer/dotfiles",
        "dotfiles.installCommand": "~/.devcontainer/dotfiles/install.sh"
    },
```

- [Personalizing with dotfile repositories](https://code.visualstudio.com/docs/remote/containers#_personalizing-with-dotfile-repositories)

# Reference

## VS Code docs

- Developing inside a Container : https://code.visualstudio.com/docs/remote/containers

## Terraform for Azure

- https://docs.microsoft.com/en-us/azure/developer/terraform/
- Terraform - Azure Provider : https://www.terraform.io/docs/providers/azurerm/index.html
- [Terraform - Azure Provider - GitHub Repos](https://github.com/terraform-providers/terraform-provider-azurerm)
- [Terraform - Azure Provider - GitHub Repos - Examples](https://github.com/terraform-providers/terraform-provider-azurerm/tree/master/examples)
