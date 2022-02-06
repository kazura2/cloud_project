# Umieszczanie obrazów dockera za pomocą ACR na klastrze kubernetesa (AKS)

### Opis
Stworzenie obrazu dockera na podstawie pliku ***.py***, umieszczenie go w Azure Container Registry (ACR), a następnie użycie utworzonego kontenera w Azure Kubernetes Service (AKS)

### wymagane zainstalowane narzędzia
* Azure CLI
* Docker
* kubectl


#### 1. Pobieranie repozytorium 
```
git clone https://github.com/kazura2/cloud_project 
```

#### 2. Tworzenie obrazu dockera
zbuduj obraz dockera z wcześniej stworzonej aplikacji
```
docker build -t apka_python3 .
```

## AZURE CLI
#### 3. Tworzenie grupy
```
az login
az group create --name cloud_project --location eastus
```

#### 4. Tworzenie ACR w CLI
```
az acr create --name mojacrproject --resource-group cloud_project --sku basic
az acr login --name mojacrproject
```

#### 5. Dodawanie obrazu dockera do kontenera ACR
```
docker tag apka_python3:latest mojacrproject.azurecr.io/python_hello_world:latest
docker push mojacrproject.azurecr.io/python_hello_world:latest
```


#### 6. Tworzenie klastra AKS w CLI
```
az aks create --resource-group cloud_project --name mojAKSproject --node-count 1 --generate-ssh-keys --attach-acr mojacrproject
```

#### 7. Połączenie z klastrem
```
az aks install-cli
az aks get-credentials --resource-group cloud_project --name mojAKSproject
```

#### 8. Użycie kontenera ACR w klastrze AKS
```
kubectl apply -f deployment.yaml
```

#### 9. Sprawdzanie podname
```
get pods
```
#### 10. Aby sprawdzić czy skrypt w pythonie wykonuje sie wpisujemy komende
```
kubectl logs [podname] -p
```

