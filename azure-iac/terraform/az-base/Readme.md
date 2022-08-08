## Scaffolding for Azure Environment

This pipeline is responsible for setting up vnet and its subnets, followed by Private DNS and P2S vnet Gateway.


```
 terraform init -backend-config="resource_group_name=${{ secrets.TF_BASE_RG_NAME }}" \
          -backend-config="storage_account_name=${{ secrets.TF_BASE_SG_ACCT_NAME }}" \
          -backend-config="container_name=${{ secrets.TF_BASE_SG_CONTAINER_NAME }}" \
          -backend-config="key=${{ secrets.TF_BASE_STATE_KEY }}"
```


terraform init -backend-config="resource_group_name=azbase-weu" \
          -backend-config="storage_account_name=azbaseweu" \
          -backend-config="container_name=azbase" \
          -backend-config="key=azbase.tfstate"     