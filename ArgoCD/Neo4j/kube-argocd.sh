## basic kubectl
# retrieve details
kubectl get nodes
kubectl get pod -A
kubectl describe pod <pod-name>
# create namespace
kubectl create namespace argocd
# switch namespace
kubectl config set-context --current --namespace=<namespace-name>
# verify
kubectl config view --minify | grep namespace:

## host argo with kubectl
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml --dry-run=client -o yaml>file_name.yaml
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl get pods -n argocd
# serve argocd
kubectl port-forward svc/argocd-server -n argocd 8080:443
# retreive password
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
argocd login localhost:8080
# apply on target cluster
kubectl config get-contexts -o name
argocd cluster add target-k8s

## host neo4j with argocd
argocd app create neo4j -f ArgoCD/Neo4j/neo4j.yaml
argocd app get neo4j
argocd app sync neo4j
argocd app terminate-op neo4j
# serve neo4j
kubectl port-forward svc/neo4j 7474:7474
kubectl port-forward svc/neo4j 7473:7473
kubectl port-forward svc/neo4j 7687:7687
# delete argocd app
argocd app delete neo4j

## debug
kubectl describe pod <pod-name> -n argocd
kubectl logs --previous --tail 10 -p <pod-name>
