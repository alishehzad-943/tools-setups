# STEP 1: System Update
sudo yum update -y

# STEP 2: Install Java 17 (Amazon Corretto)
sudo yum install java-17-amazon-corretto -y

# STEP 3: Install Git & Maven
sudo yum install git maven -y

# STEP 4: Add Jenkins repo & key
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# STEP 5: Install Jenkins
sudo yum install jenkins -y

# STEP 6: Ensure Java 17 is default
sudo alternatives --config java
# (Choose /usr/lib/jvm/java-17-amazon-corretto.x86_64/bin/java)

# STEP 7: Start Jenkins
sudo systemctl start jenkins.service
sudo systemctl enable jenkins.service
# STEP 8: Check versions
java -version      # should show java 17
mvn -version       # should also show java 17 being used

#then copy Public ip :8080 and paste on browser 
#Start jenkins ,path copy ,paste on SSH and enter code
============================================================================

#Jenkins Prameter:
String Parameter
    Takes a single line of text input from the user.
Choice Parameter**
  Shows a dropdown menu with predefined choices.
Multi-line String Parameter**
        Allows user to input multiple lines of text.
Boolean Parameter
         A checkbox to get true/false (yes/no) input.
File Parameter
       Allows users to upload a file when triggering a build.
   


































