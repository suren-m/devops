# essential rgs 
az group create -n azbase-tfstate -l uksouth 
az group create -n azbase-uks -l uksouth
az group create -n azenv-uks -l uksouth
az group create -n azvmenv-uks -l uksouth

# az ad sp list --show-mine | grep '<name>'
# az ad sp list --display-name '<name>' -o table
export assignee="" # add assignee id here
az role assignment create --assignee-object-id $assignee --role "Owner" --resource-group "azbase-uks"
az role assignment create --assignee-object-id $assignee --role "Owner" --resource-group "azenv-uks"

# verify
az role assignment list --assignee $assignee --all -o table