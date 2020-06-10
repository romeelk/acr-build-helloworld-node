RES_GROUP=acr-registry-rg
ACR_NAME=acregistrydev
AKV_NAME=rom-work-kv-01

az container create \
    --resource-group $RES_GROUP \
    --name acr-tasks \
    --image $ACR_NAME.azurecr.io/helloacrtasks:v1 \
    --registry-login-server $ACR_NAME.azurecr.io \
    --registry-username $(az keyvault secret show --vault-name $AKV_NAME --name $ACR_NAME-pull-usr --query value -o tsv) \
    --registry-password $(az keyvault secret show --vault-name $AKV_NAME --name $ACR_NAME-pull-pwd --query value -o tsv) \
    --dns-name-label acr-tasks-$ACR_NAME \
    --query "{FQDN:ipAddress.fqdn}" \
    --output table

# check the deployment
az container attach --resource-group $RES_GROUP --name acr-tasks

# check with curl the container is running
curl -i acr-tasks-acregistrydev.uksouth.azurecontainer.io