
# ansible-training

# Prerequisites

In this step we will see how to...

- Create an ssh key to connect our hosts
- Start up the vagrant environment
- Connect to the workstation host

## Create an ssh key to connect our hosts

Ansible is agent less however he use ssh to communicate with hosts. So we will create an ssh key that vagrant will use to configure the authorization mechanism.

```Shell
ssh-keygen -b 2048 -t rsa -f ~/.ssh/vagrant-key_rsa -q -N ""
```

## Start up the vagrant environment

> You dont have Vagrant and virtualBox installed ? </br>
[=> Vagrant](https://www.vagrantup.com/downloads.html)</br>
[=> VirtualBox](https://www.virtualbox.org/wiki/Downloads)

Install some usefull plugin we need:

```Shell
vagrant plugin install vagrant-hostmanager vagrant-vbguest
```

Now you could spawn the hosts we will use for this training:

```Shell
vagrant up
```

> You could show the list of vagrant managed hosts like this :</br>
> `$ vagrant status`

## Connect your workstation

```Shell
vagrant ssh ansible_workstation
```