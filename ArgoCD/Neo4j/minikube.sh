minikube version

minikube start --nodes 2 -p neo4j-demo
minikube stop -p neo4j-demo

minikube profile list
minikube status -p neo4j-demo
minikube dashboard -p neo4j-demo
minikube ssh -p neo4j-demo

minikube delete --all
