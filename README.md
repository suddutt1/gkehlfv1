kubectl apply -f ./ssd-storage-class.yaml 

kubectl apply -f ./ssd-volume-claim.yaml

kubectl apply -f ./nfs-server.yaml 
kubectl apply -f ./nfs-service.yaml
kubectl get service  | grep -e "nfs-server" | awk ' { print $3 }'

kubectl apply -f ./onenet-ns.yaml
kubectl apply -f ./nfs-pv.yaml
kubectl apply -f ./nfs-pvc.yaml 
kubectl apply -f ./noop-cli.yaml

kubectl exec -it `kubectl --namespace=onenet get pods | grep -e "cli" | awk '{print $1}' ` bash --namespace=onenet

Inside the shell of noop-cli container

```sh 
mkdir -p /opt/ws
cd /opt/ws
git clone https://github.com/suddutt1/gkehlfonenet.git .
./downloadbin.sh
./generateartifacts.sh
exit

```

kubectl apply -f ./orderer-deployment.yaml 
kubectl apply -f ./orderer-service.yaml 
kubectl apply -f ./peer0-deployment.yaml 
kubectl apply -f ./peer0-service.yaml 

Check if the orderer and peer is created or not 
```
kubectl --all-namespace get pods
```
kubectl apply -f ./hlfcli-deployment.yaml 

Check if the CLI created or not 

```
kubectl --namespace=onenet get pods

```

kubectl exec -it `kubectl --namespace=onenet get pods | grep -e "hlfcli" | awk '{print $1}' ` bash --namespace=onenet

kubectl logs `kubectl --namespace=onenet get pods | grep -e "peer0" | awk '{print $1}' `  --namespace=onenet
kubectl exec -it `kubectl --namespace=onenet get pods | grep -e "peer0" | awk '{print $1}' ` bash --namespace=onenet

### Delete network elements

kubectl --namespace=onenet delete service peer0
kubectl --namespace=onenet delete service orderer
kubectl --namespace=onenet delete deployment peer0
kubectl --namespace=onenet delete deployment orderer
