
Vagrant.configure("2") do |config|

  # The order of provisioning matters. We need to set up the database and caching services before configuring the application servers and the web server.

  # Hostmanager plugin configuration
  # This plugin allows us to manage the /etc/hosts file on both the host and guest machines.
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.manage_guest = true

  ### DB vm  ####
  config.vm.define "db01" do |db01|
    db01.vm.box = "centos/stream9"
	  db01.vm.hostname = "db01"
    db01.vm.network "private_network", ip: "192.168.33.15"
    # MySQL installation and configuration
    db01.vm.provision "shell", path: "db01-setup.sh"
  end

  ### Memcache vm  #### 
  config.vm.define "mc01" do |mc01|
    mc01.vm.box = "centos/stream9"
	  mc01.vm.hostname = "mc01"
    mc01.vm.network "private_network", ip: "192.168.33.14"
    # Memcached installation and configuration
    mc01.vm.provision "shell", path: "mc01-setup.sh"
  end

  ### RabbitMQ vm  ####
  config.vm.define "rmq01" do |rmq01|
    rmq01.vm.box = "centos/stream9"
	  rmq01.vm.hostname = "rmq01"
    rmq01.vm.network "private_network", ip: "192.168.33.13"
    # RabbitMQ installation and configuration
    rmq01.vm.provision "shell", path: "rmq01-setup.sh"
  end

  ### tomcat vm 1 ###
  config.vm.define "app01" do |app01|
    app01.vm.box = "centos/stream9"
    app01.vm.hostname = "app01"
    app01.vm.network "private_network", ip: "192.168.33.11"
	  app01.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 2
	  end
    # Tomcat installation and configuration
    app01.vm.provision "shell", path: "app-setup.sh"
  end

  ### tomcat vm 2 ###
  config.vm.define "app02" do |app02|
    app02.vm.box = "centos/stream9"
    app02.vm.hostname = "app02"
    app02.vm.network "private_network", ip: "192.168.33.12"
	  app02.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 2
	  end
    # Tomcat installation and configuration
    app02.vm.provision "shell", path: "app-setup.sh"
  end

  ### Nginx VM ###
  config.vm.define "web01" do |web01|
    web01.vm.box = "ubuntu/jammy64"
    web01.vm.hostname = "web01"
	  web01.vm.network "private_network", ip: "192.168.33.10"
    web01.vm.network "forwarded_port", guest: 80, host: 8080
    web01.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 2
    end
    # Nginx reverse proxy configuration
    web01.vm.provision "shell", path: "web01-setup.sh"
  end
  
end
