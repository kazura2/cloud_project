# Umieszczanie obrazów dockera za pomocą ACR na klastrze kubernetesa (AKS)

###Pobieranie repozytorium 
```
git clone https://github.com/kazura2/cloud_project 
```

###Tworzenie obrazu dockera
zbuduj obraz dockera z wcześniej stworzonej aplikacji
```
docker build -t apka_python3 .
```

##AZURE CLI
###Tworzenie grupy
```
az login
az group create --name cloud_project\
    --location eastus
```

###Tworzenie ACR w CLI
```
az acr create --name mojacrproject\
--resource-group cloud_project\
--sku basic
az acr login --name mojacrproject
```

###Dodawanie obrazu dockera do kontenera ACR
```
docker tag apka_python3:latest mojacrproject.azurecr.io/python_hello_world:latest
docker push mojacrproject.azurecr.io/python_hello_world:latest
```


###Tworzenie klastra AKS w CLI
```
az aks create --resource-group cloud_project \
    --name mojAKSproject \
    --node-count 1 \
    --generate-ssh-keys\
    --attach-acr mojacrproject
```

###Połączenie
```
az aks install-cli
az aks get-credentials \
   --resource-group cloud_project \
   --name mojAKSproject
```

###aby użyć kontenera ACR w klastrze AKS
```
kubectl apply -f deployment.yaml
```

###aby sprawdzić podname
```
get pods
```
###aby sprawdzić czy skrypt w pythonie wykonuje sie wpisujemy komende
```
kubectl logs [podname] -p
```

