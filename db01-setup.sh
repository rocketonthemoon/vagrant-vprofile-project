sudo -i
dnf update -y
dnf install epel-release -y

export DATABASE_PASS='admin123'
echo "export DATABASE_PASS='${DATABASE_PASS}'" | sudo tee -a /etc/profile
source /etc/profile

dnf install git mariadb-server -y
systemctl start mariadb
systemctl enable mariadb      
            
mysql <<-EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DATABASE_PASS}';
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
FLUSH PRIVILEGES;
EOF

git clone -b local-setup https://github.com/devopshydclub/vprofile-project.git /home/vagrant/vprofile-project

mysql -u root -p"$DATABASE_PASS" -e "create database accounts"
mysql -u root -p"$DATABASE_PASS" -e "grant all privileges on accounts.* TO 'admin'@'app01' identified by 'admin123' "
mysql -u root -p"${DATABASE_PASS}" -e "GRANT ALL PRIVILEGES ON accounts.* TO 'admin'@'app02' IDENTIFIED BY 'admin123'"
mysql -u root -p"${DATABASE_PASS}" accounts < /home/vagrant/vprofile-project/src/main/resources/db_backup.sql      
mysql -u root -p"$DATABASE_PASS" -e "FLUSH PRIVILEGES"

systemctl restart mariadb      