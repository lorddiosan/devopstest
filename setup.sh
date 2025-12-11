#!/bin/bash
echo "=== Installation des dépendances DevOps ==="

# Mettre à jour le système
sudo apt-get update

# Installer Java 17
sudo apt-get install -y openjdk-17-jdk

# Installer Maven
sudo apt-get install -y maven

# Installer Docker
sudo apt-get install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER

# Installer Minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Installer kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Démarrer Minikube
minikube start

echo "=== Installation terminée ==="
echo "Java version:"
java -version
echo "Maven version:"
mvn --version
echo "Docker version:"
docker --version
echo "Minikube version:"
minikube version
echo "kubectl version:"
kubectl version --client
