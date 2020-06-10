#Pre-requisites get PAT token
ACR_NAME=acregistrydev          # The name of your Azure container registry
GIT_USER=romeelk      # Your GitHub user account name

# get this from a secure vault such Hashicorp vault. For this example i have used my personal dev keyvault
# get the Github pat token
GIT_PAT=$(az keyvault secret show --vault-name rom-work-kv-01 --name acrgithubpat --query value -o json) 

# works in powershell throws error in WSL
az acr task create \
    --registry $ACR_NAME \
    --name taskhelloworld \
    --image helloworld:v1 \
    --context https://github.com/$GIT_USER/acr-build-helloworld-node.git \
    --file Dockerfile \
    --git-access-token $GIT_PAT

# test the task
az acr task run --registry $ACR_NAME --name taskhelloworld
