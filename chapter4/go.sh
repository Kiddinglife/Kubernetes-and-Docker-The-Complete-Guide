#!/bin/bash
tput setaf 5 
echo -e "\n*******************************************************************************************************************"
echo -e "Installing Go"
echo -e "*******************************************************************************************************************"
tput setaf 2

tput setaf 5
echo -e "\n*******************************************************************************************************************"
echo -e "Downloading Go archive"
echo -e "*******************************************************************************************************************"
tput setaf 2
wget https://dl.google.com/go/go1.16.5.linux-amd64.tar.gz

tput setaf 5
echo -e "\n*******************************************************************************************************************"
echo -e "Extracting archive"
echo -e "*******************************************************************************************************************"
tput setaf 2
tar -xzf go1.16.5.linux-amd64.tar.gz

tput setaf 5
echo -e "\n*******************************************************************************************************************"
echo -e "Cleaning up tar file"
echo -e "*******************************************************************************************************************"
tput setaf 2
rm go1.16.5.linux-amd64.tar.gz

tput setaf 5
echo -e "\n*******************************************************************************************************************"
echo -e "Moving Go binary to /usr/local"
echo -e "*******************************************************************************************************************"
tput setaf 2
sudo rm -rf /usr/local/go
sudo mv go /usr/local
echo -e "Go binary move complete"

tput setaf 5
echo -e "\n*******************************************************************************************************************"
echo -e "Adding Go environment variables to bash_profile"
echo -e "*******************************************************************************************************************"
tput setaf 2
cat << 'EOF' >> ~/.profile
export GOROOT=/usr/local/go
export GOPATH=~/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
EOF
echo -e "Variables added"

tput setaf 5
echo -e "\n*******************************************************************************************************************"
echo -e "Refreshing profile to load variables"
echo -e "*******************************************************************************************************************"
tput setaf 2
source ~/.profile
echo -e "Profile has been refreshed"

tput setaf 3
echo -e "\n*******************************************************************************************************************"
echo -e "Go installation complete"
echo -e "*******************************************************************************************************************"
tput setaf 2


GO111MODULE="on" go get sigs.k8s.io/kind@v0.8.0

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64 && \
sudo install skaffold /usr/local/bin/

sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get install -y kubectl

wget -q -O - https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash

curl -Lo kyma.tar.gz "https://github.com/kyma-project/cli/releases/download/$(curl -s https://api.github.com/repos/kyma-project/cli/releases/latest | grep tag_name | cut -d '"' -f 4)/kyma_Linux_x86_64.tar.gz" \
&& mkdir kyma-release && tar -C kyma-release -zxvf kyma.tar.gz && chmod +x kyma-release/kyma && sudo mv kyma-release/kyma /usr/local/bin \
&& rm -rf kyma-release kyma.tar.gz

reboot



