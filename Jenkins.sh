#!/bin/bash
set -e

echo "=== STEP 1: Update system ==="
sudo yum update -y

echo "=== STEP 2: Install Java 17 (Amazon Corretto) ==="
sudo yum install java-17-amazon-corretto -y

echo "=== STEP 3: Install Git & Maven ==="
sudo yum install git maven wget -y

echo "=== STEP 4: Add Jenkins repo & key ==="
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

echo "=== STEP 5: Clean cache ==="
sudo yum clean all
sudo rm -rf /var/cache/yum

echo "=== STEP 6: Try installing Jenkins from repo ==="
if ! sudo yum install jenkins -y; then
  echo "Repo install failed, trying manual download..."
  wget https://get.jenkins.io/redhat-stable/jenkins-2.516.3-1.1.noarch.rpm -O /tmp/jenkins.rpm
  sudo yum install /tmp/jenkins.rpm -y
fi

echo "=== STEP 7: Ensure Java 17 is default ==="
sudo alternatives --install /usr/bin/java java /usr/lib/jvm/java-17-amazon-corretto.x86_64/bin/java 2
sudo alternatives --set java /usr/lib/jvm/java-17-amazon-corretto.x86_64/bin/java

echo "=== STEP 8: Enable & Start Jenkins ==="
sudo systemctl daemon-reload
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins --no-pager

echo "=== STEP 9: Check Versions ==="
java -version
mvn -version

echo "=== STEP 10: Jenkins Initial Admin Password ==="
sudo cat /var/lib/jenkins/secrets/initialAdminPassword || echo "Jenkins not started yet!"






chmod +x install_jenkins.sh
./install_jenkins.sh

.
   


































