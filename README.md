### Build SSD Disk
```sh

kubectl apply -f ./ssd-storage-class.yaml 

kubectl apply -f ./ssd-volume-claim.yaml

kubectl apply -f ./nfs-server.yaml 
kubectl apply -f ./nfs-service.yaml
kubectl get service  | grep -e "nfs-server" | awk ' { print $3 }'

```
### Update the nfs server address in nfs-pv.yaml

```sh
kubectl apply -f ./onenet-ns.yaml
kubectl apply -f ./nfs-pv.yaml
kubectl apply -f ./nfs-pvc.yaml 
kubectl apply -f ./noop-cli.yaml

```

### Open the CLI 

```sh

kubectl exec -it `kubectl --namespace=onenet get pods | grep -e "cli" | awk '{print $1}' ` bash --namespace=onenet

```

### Inside the shell of noop-cli container

```sh 
mkdir -p /opt/ws
cd /opt/ws
git clone https://github.com/suddutt1/gkehlfonenet.git .
./downloadbin.sh
./generateartifacts.sh
exit

```
### Deploy orderer and peers

```sh
kubectl apply -f ./orderer-deployment.yaml 
kubectl apply -f ./orderer-service.yaml 
kubectl apply -f ./peer0-deployment.yaml 
kubectl apply -f ./peer0-service.yaml 

```


####Check if the orderer and peer is created or not 

```sh
kubectl get pods  --all-namespaces -o wide
```

### Create HLF CLI 

```sh
kubectl apply -f ./hlfcli-deployment.yaml 
```

###Check if the CLI created or not 

```
kubectl --namespace=onenet get pods

```

#### Useful scripts 

```sh

kubectl exec -it `kubectl --namespace=onenet get pods | grep -e "hlfcli" | awk '{print $1}' ` bash --namespace=onenet

kubectl logs `kubectl --namespace=onenet get pods | grep -e "peer0" | awk '{print $1}' `  --namespace=onenet

kubectl exec -it `kubectl --namespace=onenet get pods | grep -e "peer0" | awk '{print $1}' ` bash --namespace=onenet

```

### Delete network elements

```sh
kubectl --namespace=onenet delete service peer0
kubectl --namespace=onenet delete service orderer
kubectl --namespace=onenet delete deployment peer0
kubectl --namespace=onenet delete deployment orderer

```

### To query the chain code 

```sh

peer chaincode query -C xcchannel -n mcc -c '{"Args":["probe",""]}'

```

### Create an asset 

```sh
cd /opt/ws
. setpeer Org1 pee0

peer chaincode invoke -o orderer.onenet:7050  --tls --cafile $ORDERER_CA -C xcchannel -n mcc -c '{"Args":["createAsset","n","{ \"objType\":\"car\", \"n\":\"1\", \"color\":\"red\" }"]}'
```

### Retive created asset

```sh
cd /opt/ws
peer chaincode query -C xcchannel -n mcc -c '{"Args":["getAssetDetails","1"]}'

```