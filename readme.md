Pobieranie repozytorium 
git clone https://github.com/kazura2/cloud_project 

Tworzenie obrazu dockera
zbuduj obraz dockera z wcześniej stworzonej aplikacji
docker build -t apka_python3 .

AZURE CLI
tworzenie grupy
az group create --name cloud_project \
    --location eastus


Tworzenie ACR w CLI
az acr create --name acr_project --resource-group cloud_project --sku basic
az acr login --name acr_project

Dodawanie obrazu dockera do kontenera ACR
docker tag apka_python3:latest acr_project.azurecr.io/python_hello_world:python
docker push acr_project.azurecr.io/python_hello_world:python



Tworzenie klastra AKS w CLI
az aks create --resource-group cloud_project \
    --name AKS_project \
    --node-count 1 \
    --generate-ssh-keys\
    --attach-acr acr_project

Połączenie
az aks install-cli
az aks get-credentials \
   --resource-group cloud_project \
   --name AKS_project