# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "centos/7"

  config.vbguest.auto_update = true

  config.vm.provision "file", source: "~/.ssh/vagrant-key_rsa.pub", destination: "~/.ssh/mykey_rsa.pub"
  config.vm.provision "file", source: "~/.ssh/vagrant-key_rsa", destination: "~/.ssh/mykey_rsa"

  $script_vim=<<-EOF
  echo 'Installing vim'
  sudo yum install -y vim
  EOF

  $script_key=<<-EOF
  echo 'Setting Keys Access'
  ssh-add /home/vagrant/.ssh/mykey_rsa
  EOF
  config.vm.provision :shell, :inline => $script_key

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

  boxes = {
    "ansible_workstation" => { :hostname => "ansible.workstation",  :memory => 1024, :workstation => true },
    "webserver1_dev"      => { :hostname => "webserver1.dev",       :memory => 512  },
    "webserver2_dev"      => { :hostname => "webserver2.dev",       :memory => 512  },
    "database_dev"        => { :hostname => "database.dev",         :memory => 512  },
    "webserver1_prod"     => { :hostname => "webserver1.prod",      :memory => 512  },
    "webserver2_prod"     => { :hostname => "webserver2.prod",      :memory => 512  },
    "database_prod"       => { :hostname => "database.prod",        :memory => 512  }
  }

  boxes.each do |node_name, info|
    config.vm.define node_name, primary: true do |node|
      node.vm.provider :virtualbox do |v, override|
        v.customize ["modifyvm", :id, "--memory", info[:memory]]
      end
      if info[:workstation]
        node.vm.synced_folder ".", "/vagrant",
            type: "nfs", :bsd__nfs_options => ['rw','no_subtree_check','all_squash','async']
        node.vm.provision :shell, :inline => $script_vim
      end
      node.vm.network :private_network, type: "dhcp"
      node.vm.host_name = "#{info[:hostname]}"
      node.hostmanager.aliases = ["#{info[:hostname]}.vagrant.local"]
  
      node.vm.provision "shell", inline: "cat /home/vagrant/.ssh/mykey_rsa.pub >> /home/vagrant/.ssh/authorized_keys"
    end  
  end #boxes
end