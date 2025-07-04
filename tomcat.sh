wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.80/bin/apache-tomcat-9.0.80.tar.gz
tar -xvzf apache-tomcat-9.0.80.tar.gz
vim apache-tomcat-9.0.80/conf/tomcat-users.xml
#last three copy and write again
 <role rolename="tomcat"/>
  <role rolename="role1"/>
  <user username="tomcat" password="<must-be-changed>" roles="tomcat"/>
  <user username="both" password="<must-be-changed>" roles="tomcat,role1"/>
  <user username="role1" password="<must-be-changed>" roles="role1"/>
-->
  <role rolename="manager-gui"/>
  <role rolename="manager-script"/>
  <user username= "Shehzad" password="Ali1001" roles="manager-gui,manager-script"/>
</tomcat-users>

vim apache-tomcat-9.0.80/webapps/manager/META-INF/context.xml
#delete 21 and 22 lines
sh apache-tomcat-9.0.80/bin/startup.sh
public ip:8080
