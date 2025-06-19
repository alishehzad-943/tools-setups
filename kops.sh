#vim .bashrc
#export PATH=$PATH:/usr/local/bin/
#source .bashrc


#! /bin/bash
aws configure
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
wget https://github.com/kubernetes/kops/releases/download/v1.32.0/kops-linux-amd64
chmod +x kops-linux-amd64 kubectl
mv kubectl /usr/local/bin/kubectl
mv kops-linux-amd64 /usr/local/bin/kops

#Buckets Create:
aws configure
  aws s3api create-bucket --bucket devopsclusterstate.k8s.local --region eu-north-1 --create-bucket-configuration LocationConstraint=eu-north-1
  aws s3api put-bucket-versioning   --bucket devopsclusterstate.k8s.local   --versioning-configuration Status=Enabled
  export KOPS_STATE_STORE=s3://devopsclusterstate.k8s.local
  kops create cluster   --name=devopscluster.k8s.local   --zones=eu-north-1a   --node-count=2   --node-size=t3.micro   --control-plane-size=t3.micro   --dns-zone=devopscluster.k8s.local   --yes
  kops validate cluster --wait 10m


