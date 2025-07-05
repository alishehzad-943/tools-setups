     vim sonar.sh
    #copy below all script and run
      sh sonar.sh

#!/bin/bash

# Exit on error
set -e

# Variables
SONAR_VERSION="sonarqube-8.9.6.50800"
SONAR_ZIP="$SONAR_VERSION.zip"
INSTALL_DIR="/opt"
SONAR_USER="sonar"

# Step 1: Install Java 11
echo "Installing Java 11..."
amazon-linux-extras enable java-openjdk11
yum install java-11-openjdk -y

# Step 2: Download and unzip SonarQube
echo "Downloading SonarQube..."
cd $INSTALL_DIR
wget https://binaries.sonarsource.com/Distribution/sonarqube/$SONAR_ZIP
unzip $SONAR_ZIP

# Step 3: Create sonar user and assign permissions
useradd -m -d /home/$SONAR_USER $SONAR_USER || true
chown -R $SONAR_USER:$SONAR_USER $SONAR_VERSION

# Step 4: Start SonarQube as sonar user
echo "Starting SonarQube..."
sudo -u $SONAR_USER bash -c "$INSTALL_DIR/$SONAR_VERSION/bin/linux-x86-64/sonar.sh start"

# Optional: Check SonarQube status
sudo -u $SONAR_USER bash -c "$INSTALL_DIR/$SONAR_VERSION/bin/linux-x86-64/sonar.sh status"

# Reminder
echo "✅ SonarQube should now be running at http://<your-ec2-ip>:9000"



publicip :9000




