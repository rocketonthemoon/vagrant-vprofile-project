sudo -i
dnf update -y
dnf install epel-release -y

dnf install wget -y
wget http://packages.erlang-solutions.com/erlang-solutions-2.0-1.noarch.rpm -O /tmp/erlang-solutions-2.0-1.noarch.rpm
rpm -Uvh /tmp/erlang-solutions-2.0-1.noarch.rpm
dnf -y install erlang socat

curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash
dnf install rabbitmq-server -y

systemctl start rabbitmq-server
systemctl enable rabbitmq-server

sh -c 'echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config'
rabbitmqctl add_user test test
rabbitmqctl set_user_tags test administrator

systemctl restart rabbitmq-server