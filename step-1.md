
# ansible-training

# Step 1

In this step we will...

- Install Ansible on the workstation
- Create ou first inventory

## Install Ansible on the workstation

Connect to the workstation...

```Shell
vagrant ssh ansible_workstation
```

Install Ansible...

```Shell
sudo yum install ansible
```

>[Ansible installation guide](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

## Add our first host

The default inventory folder is `/etc/ansible/hosts`
use vi to add ou first host...

```Shell
vi /etc/ansible/hosts
```

Add name of one of our host (ex: `webserver.dev`) and save the change.

Now we will use ansible to ping this host...

```Shell
ansible all -m ping
```

## Create ou first inventory

```Shell
cd /vagrant   # The shared folder between the workstation and your computer
touch hosts   # Create the inventory
vi hosts      # Edit the file
```

Add all of our hosts...

```INI
webserver.dev
webserver.staging
webserver.production
database.dev
database.staging
database.production
```

And ping all the hosts...

```Shell
ansible -i hosts all -m ping
````

