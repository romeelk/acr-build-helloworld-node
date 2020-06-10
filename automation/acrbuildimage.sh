ACR_NAME=acregistrydev

# run acr task to build image
az acr build --registry $ACR_NAME --image helloacrtasks:v1 .
