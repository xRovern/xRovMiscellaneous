mkdir demos
cd demos
mkdir pod
cd pod

# create a yml file
cat > pod-definition.yml
# paste pod-definition.yml contains here
# ^C to exit
# verify the yml file
cat pod-definition.yml
clear

# check pods
kubectl get pods
# delete a deployment
kubectl delete deployment nginx

# check pods again
kubectl get pods
# create a pod
kubectl create -f pod-definition.yml
kubectl get pods
