### Partial config from file

terraform init --backend-config=".local"


az ad sp list --show-mine | jq '.[].appId' | wc -l

az ad sp list --show-mine --query "[].{id:appId, tenant:appOwnerTenantId}"