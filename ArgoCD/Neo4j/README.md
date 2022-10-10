# Hosting a Neo4j with ArgoCD
In this folder will guide how to host a neo4j database by using argo CD.

## Pre-Requisite
1. Have docker installed and start the docker
1. Have [kubectl tools](https://kubernetes.io/docs/tasks/tools/install-kubectl-macos/#install-with-homebrew-on-macos) installed with homebrew, `brew install kubectl`
1. Have [minikube](https://formulae.brew.sh/formula/minikube) installed with homebrew, `brew install minikube`
1. Have [argocd](https://formulae.brew.sh/formula/argocd) installed with homebrew, `brew install argocd`
1. Have [helm](https://helm.sh/docs/intro/install/) installed with homebrew, `brew install helm`

## Setup
### Set up Kubernetes with Minikube
1. Create a minikube with `minikube start -p neo4j-demo`
1. Serve the minikube with `minikube dashboard -p neo4j-demo` (optional)

### Host ArgoCD UI with Kubernetes
1. Create a namespace with `kubectl create namespace argocd`
1. Switch the namespace with `kubectl config set-context --current --namespace=argocd`
1. Verify the current namespace with `kubectl config view --minify | grep namespace:`
1. Host the argocd ui with `kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml`
1. Serve the argocd ui with `kubectl port-forward svc/argocd-server -n argocd 8080:443`, go to https://localhost:8080
1. Run `argocd login localhost:8080` to login in terminal
1. Login with username `admin` and password from `kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo`

### Host Neo4j with ArgoCD
1. Create neo4j with `argocd app create neo4j -f ArgoCD/Neo4j/neo4j.yaml`
1. Get information of neo4j with `argocd app get neo4j`
1. Sync neo4j with `argocd app sync neo4j`
1. Serve neo4j for all 3 ports:
  1. `kubectl port-forward svc/neo4j 7474:7474`
  1. `kubectl port-forward svc/neo4j 7473:7473`
  1. `kubectl port-forward svc/neo4j 7687:7687`
1. Go to http://localhost:7474/ 
1. Login with username `neo4j` and password which is defined in [neo4j.yaml](/ArgoCD/Neo4j/neo4j.yaml)

## Reference
1. [kubectl cheatsheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
1. [minikube guide](https://minikube.sigs.k8s.io/docs/start/)
1. [argocd guide](https://argo-cd.readthedocs.io/en/stable/getting_started/)
1. [argocd configuration](https://argo-cd.readthedocs.io/en/stable/operator-manual/declarative-setup/)
1. Step by step [argocd implementation](https://www.digitalocean.com/community/tutorials/how-to-deploy-to-kubernetes-using-argo-cd-and-gitops)
1. [neo4j helm chart](https://github.com/neo4j/helm-charts)
