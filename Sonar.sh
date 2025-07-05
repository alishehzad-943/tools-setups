#Launch EC2 port 9000 and SSH Access ,t2.medium
     vim sonar.sh
    #copy below all script and run
     sh sonar.sh

#!/bin/bash
set -e
SONAR_VERSION="sonarqube-8.9.6.50800"
SONAR_ZIP="$SONAR_VERSION.zip"
INSTALL_DIR="/opt"
SONAR_USER="sonar"

echo "Installing Java 11..."
amazon-linux-extras enable java-openjdk11
yum install java-11-openjdk -y
echo "Downloading SonarQube..."

cd $INSTALL_DIR
wget https://binaries.sonarsource.com/Distribution/sonarqube/$SONAR_ZIP
unzip $SONAR_ZIP

useradd -m -d /home/$SONAR_USER $SONAR_USER || true
chown -R $SONAR_USER:$SONAR_USER $SONAR_VERSION

echo "Starting SonarQube..."
sudo -u $SONAR_USER bash -c "$INSTALL_DIR/$SONAR_VERSION/bin/linux-x86-64/sonar.sh start"
sudo -u $SONAR_USER bash -c "$INSTALL_DIR/$SONAR_VERSION/bin/linux-x86-64/sonar.sh status"
echo "✅ SonarQube should now be running at http://<your-ec2-ip>:9000"



public ip:9000 paste via browser




