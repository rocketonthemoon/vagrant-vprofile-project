sudo -i
dnf update -y
dnf install epel-release -y

dnf install java-1.8.0-openjdk -y

dnf install git maven wget -y

wget https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.37/bin/apache-tomcat-8.5.37.tar.gz -O /tmp/apache-tomcat-8.5.37.tar.gz
tar xzvf /tmp/apache-tomcat-8.5.37.tar.gz -C /tmp

useradd --home-dir /usr/local/tomcat8 --shell /sbin/nologin tomcat

cp -r /tmp/apache-tomcat-8.5.37/* /usr/local/tomcat8/

cat <<EOF > /etc/systemd/system/tomcat.service
[Unit] 
Description=Tomcat 
After=network.target

[Service]
User=tomcat
WorkingDirectory=/usr/local/tomcat8 
Environment=JRE_HOME=/usr/lib/jvm/jre 
Environment=JAVA_HOME=/usr/lib/jvm/jre 
Environment=CATALINA_HOME=/usr/local/tomcat8 
Environment=CATALINE_BASE=/usr/local/tomcat8 
ExecStart=/usr/local/tomcat8/bin/catalina.sh run 
ExecStop=/usr/local/tomcat8/bin/shutdown.sh 
SyslogIdentifier=tomcat-%i

[Install] 
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl start tomcat
systemctl enable tomcat

git clone -b local-setup https://github.com/devopshydclub/vprofile-project.git /home/vagrant/vprofile-project
mvn install -f /home/vagrant/vprofile-project/pom.xml
systemctl stop tomcat
rm -rf /usr/local/tomcat8/webapps/ROOT*
cp /home/vagrant/vprofile-project/target/vprofile-v2.war /usr/local/tomcat8/webapps/ROOT.war
systemctl start tomcat
# for execution , we also have to give read rights to tomcat user
chmod 755 /usr/local/tomcat8/bin/*.sh
chown tomcat.tomcat /usr/local/tomcat8 -R
systemctl restart tomcat