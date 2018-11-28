# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "centos/7"

  config.vbguest.auto_update = true

  config.vm.provision "file", source: "~/.ssh/vagrant-key_rsa.pub", destination: "~/.ssh/mykey_rsa.pub"
  config.vm.provision "file", source: "~/.ssh/vagrant-key_rsa", destination: "~/.ssh/mykey_rsa"

  $script=<<-EOF
  echo 'Setting Keys Access'
  ssh-add /home/vagrant/.ssh/mykey_rsa
  EOF
  config.vm.provision :shell, :inline => $script

  config.ssh.forward_agent = true

  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.manage_guest = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = true

  config.hostmanager.ip_resolver = proc do |vm, resolving_vm|
    if hostname = (vm.ssh_info && vm.ssh_info[:host])
      `VBoxManage guestproperty get #{vm.id} "/VirtualBox/GuestInfo/Net/1/V4/IP"`.split()[1]
    end
  end

  config.vm.define :ansible_workstation, primary: true do |ansible_workstation|
    ansible_workstation.vm.provider :virtualbox do |v, override|
      v.customize ["modifyvm", :id, "--memory", 1024]
    end

    ansible_workstation.vm.synced_folder ".", "/vagrant",
            type: "nfs", :bsd__nfs_options => ['rw','no_subtree_check','all_squash','async']
    ansible_workstation.vm.network :private_network, type: "dhcp"
    ansible_workstation.vm.host_name = "ansible-workstation"
    ansible_workstation.hostmanager.aliases = %w(ansible-workstation.vagrant.local ansible-workstation)

    $script=<<-EOF
    echo 'Installing vim'
    sudo yum install -y vim
    EOF
    ansible_workstation.vm.provision :shell, :inline => $script
  end

  # Web Server Development
  config.vm.define :webserver_dev, primary: true do |webserver_dev|
    webserver_dev.vm.provider :virtualbox do |v, override|
      v.customize ["modifyvm", :id, "--memory", 512]
    end

    webserver_dev.vm.network :private_network, type: "dhcp"
    webserver_dev.vm.host_name = "webserver.dev"
    webserver_dev.hostmanager.aliases = %w(webserver.dev.vagrant.local webserver.dev)

    webserver_dev.vm.provision "shell", inline: "cat /home/vagrant/.ssh/mykey_rsa.pub >> /home/vagrant/.ssh/authorized_keys"
  end

  # Database Development
  config.vm.define :database_dev, primary: true do |database_dev|
    database_dev.vm.provider :virtualbox do |v, override|
      v.customize ["modifyvm", :id, "--memory", 512]
    end

    database_dev.vm.network :private_network, type: "dhcp"
    database_dev.vm.host_name = "database.dev"
    database_dev.hostmanager.aliases = %w(database.dev.vagrant.local database.dev)

    database_dev.vm.provision "shell", inline: "cat /home/vagrant/.ssh/mykey_rsa.pub >> /home/vagrant/.ssh/authorized_keys"
  end

  # Web Server Staging
  config.vm.define :webserver_staging, primary: true do |webserver_staging|
    webserver_staging.vm.provider :virtualbox do |v, override|
      v.customize ["modifyvm", :id, "--memory", 512]
    end

    webserver_staging.vm.network :private_network, type: "dhcp"
    webserver_staging.vm.host_name = "webserver.staging"
    webserver_staging.hostmanager.aliases = %w(webserver.staging.vagrant.local webserver.staging)

    webserver_staging.vm.provision "shell", inline: "cat /home/vagrant/.ssh/mykey_rsa.pub >> /home/vagrant/.ssh/authorized_keys"
  end

  # Database Staging
  config.vm.define :database_staging, primary: true do |database_staging|
    database_staging.vm.provider :virtualbox do |v, override|
      v.customize ["modifyvm", :id, "--memory", 512]
    end

    database_staging.vm.network :private_network, type: "dhcp"
    database_staging.vm.host_name = "database.staging"
    database_staging.hostmanager.aliases = %w(database.staging.vagrant.local database.staging)

    database_staging.vm.provision "shell", inline: "cat /home/vagrant/.ssh/mykey_rsa.pub >> /home/vagrant/.ssh/authorized_keys"
  end

  # Web Server Production
  config.vm.define :webserver_production, primary: true do |webserver_production|
    webserver_production.vm.provider :virtualbox do |v, override|
      v.customize ["modifyvm", :id, "--memory", 512]
    end

    webserver_production.vm.network :private_network, type: "dhcp"
    webserver_production.vm.host_name = "webserver.production"
    webserver_production.hostmanager.aliases = %w(webserver.production.vagrant.local webserver.production)

    webserver_production.vm.provision "shell", inline: "cat /home/vagrant/.ssh/mykey_rsa.pub >> /home/vagrant/.ssh/authorized_keys"
  end

  # Database Production
  config.vm.define :database_production, primary: true do |database_production|
    database_production.vm.provider :virtualbox do |v, override|
      v.customize ["modifyvm", :id, "--memory", 512]
    end

    database_production.vm.network :private_network, type: "dhcp"
    database_production.vm.host_name = "database.production"
    database_production.hostmanager.aliases = %w(database.production.vagrant.local database.production)

    database_production.vm.provision "shell", inline: "cat /home/vagrant/.ssh/mykey_rsa.pub >> /home/vagrant/.ssh/authorized_keys"
  end
end