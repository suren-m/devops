# Azure environment provisioned using Terraform

# Ensure SP executing the terraform pipeline has access for role assignments

```
# Skip if SP already exists
e.g. az ad sp list --show-mine | grep 'name-of-sp'

az ad sp create-for-rbac --name <sp-name>
az ad sp list --display-name <sp-name> -o table
az role assignment list --assignee "<objectId>" --all -o table
az role definition list -n 'Owner'
az role assignment create --assignee-object-id $assignee --role "Owner" --resource-group "azbase-uks"
az role assignment create --assignee-object-id $assignee --role "Owner" --resource-group "azenv-uks"
```


## To check roles on a system-managed MI for AKS

```
az aks show -n cndev -g azenv-uks --query=identity | jq '.principalId' | xargs az role assignment list --all -o table --assignee
```



## Symlinking (only if required)

If `terraform` plays up with relative paths on module sources, then either move modules to a separate github source or use symlinks and update the source path to same directory as templates `.` For more, [see here](https://stackoverflow.com/a/18791647) and [here](https://github.com/hashicorp/terraform/issues/23333)

resource_group_name="<tfstate-resourcegroup>"
storage_account_name="<tfstate-sg>"
container_name="<container-name>"
key="<.tfstate-=file-name>"

