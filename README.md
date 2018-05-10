kubectl apply -f ./ssd-storage-class.yaml 

kubectl apply -f ./ssd-volume-claim.yaml

kubectl apply -f ./nfs-server.yaml 
kubectl apply -f ./nfs-service.yaml
kubectl get service  | grep -e "nfs-server" | awk ' { print $3 }'

kubectl apply -f ./onenet-ns.yaml
kubectl apply -f ./nfs-pv.yaml
kubectl apply -f ./nfs-pvc.yaml 
kubectl exec -it `kubectl --namespace=onenet get pods | grep -e "cli" | awk '{print $1}' ` bash --namespace=onenet
mkdir -p /opt/ws
cd /opt/ws
git clone https://github.com/suddutt1/gkehlfonenet.git .
kubectl apply -f ./orderer-deployment.yaml 
 kubectl apply -f ./orderer-service.yaml 
 kubectl apply -f ./peer0-deployment.yaml 
kubectl apply -f ./peer0-service.yaml 

kubectl --namespace=onenet get pods

kubectl apply -f ./hlfcli-deployment.yaml 
kubectl exec -it `kubectl --namespace=onenet get pods | grep -e "hlfcli" | awk '{print $1}' ` bash --namespace=onenet

