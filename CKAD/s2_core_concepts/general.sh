# get info
kubectl cluster-info
kubectl get nodes
kubectl run nginx --image nginx_name
kubectl run nginx --image=nginx
kubectl get pods
kubectl get pods -o wide
kubectl get pods webapp
kubectl describe pod myapp-pod
kubectl describe pod myapp-pod | grep -i  image
kubectl get replicationcontroller
kubectl get replicaset
kubectl get replicaset.apps
kubectl describe replicaset.apps <replicaset-name>
kubectl get deployments
kubectl get deployments.apps
kubectl get all
kubectl get pods --namespace=<namespace-name>
kubectl get pods --all-namespaces
kubectl get ns --no-headers | wc -l
kubectl get -n research get pods --no-headers
kubectl get pods --all-namespaces | grep blue
kubectl -n <namespace-name> get svc
kubectl describe svc redis-service

# switch namespace
kubectl config set-context $(kubectl config current-context) --namespace=<namespace-name>

# create pod
kubectl create -f pod-definition.yml
kubectl run redis --image=redis123
kubectl run redis --image=redis123 --dry-run=client -o yaml > pod.yaml # with --dry-run=client will not create it
kubectl run nginx --image=nginx
kubectl apply -f pod.yaml
kubectl create -f pod-definition.yml --namespace=<namespace-name>
kubectl create namespace <namespace-name>
kubectl run nginx-pod --image=nginx:alpine
kubectl run redis --image=redis:alpine --labels=tier=db
kubectl run custom-nginx --image=nginx --port 8080
kubectl run httpd --image=httpd:alpine --port 80 --expose --dry-run=client -o yaml
kubectl run httpd --image=httpd:alpine --port 80 --expose
# create rc, rs, deployment
kubectl create -f rc-definition.yml
kubectl create -f replicaset-definition.yml
kubectl create deployment <deployment-name> --image=httpd:2.4-alpine
kubectl create deployment --image=nginx nginx
kubectl create deployment --image=nginx nginx --dry-run -o yaml
kubectl create deployment nginx --image=nginx --replicas=4
kubectl create deployment nginx --image=nginx --dry-run=client -o yaml > nginx-deployment.yaml
kubectl create deployment webapp --image=kodekloud/webapp-color
kubectl create deployment redis-deploy --image=redis --namespace=dev-ns --dry-run=client -o yaml > redis.yaml
# create service
kubectl expose pod redis --port=6379 --name redis-service --dry-run=client -o yaml # auto use pod's label as selectors
kubectl create service clusterip redis --tcp=6379:6379 --dry-run=client -o yaml # assume selector as app=redis, cannot pass in selectors as an option
kubectl expose pod nginx --port=80 --name nginx-service --type=NodePort --dry-run=client -o yaml # auto use pod's label as selector, cannot specify the node port
kubectl create service nodeport nginx --tcp=80:80 --node-port=30080 --dry-run=client -o yaml # will not use pod's label as selectors
kubectl expose pod redis --name redis-service --port 6379 --target-port 6379

# edit pod
kubectl edit pod redis
kubectl edit deployment my-deployment
# extract definition to another yaml
kubectl get pod <pod-name> -o yaml > pod-definition.yaml
# update replicaset
kubectl replace -f replicaset-definition.yml
kubectl scale --replicas=6 -f replicaset-definition.yml
kubectl scale --replicas=6 replicaset myapp-replicaset
kubectl edit replicaset.apps <replicaset-name>
kubectl scale --repplicas=3 deployment <deployment-name>
kubectl scale deployment --replicas=3 webapp

# delete
kubectl delete pod <pod-name>
kubectl delete deployment nginx
kubectl delete replicaset myapp-replicaset

# open file
vi pod.yaml
