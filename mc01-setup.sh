sudo -i
dnf update -y
dnf install epel-release -y

dnf install memcached -y

sudo sed -i 's/OPTIONS="-l 127.0.0.1,::1"/OPTIONS="-l 0.0.0.0"/' /etc/sysconfig/memcached

systemctl start memcached
systemctl enable memcached
