
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
echo "webserver.dev
webserver.staging
webserver.production
database.dev
database.staging
database.production" >> ./hosts
```

And ping all the hosts...

```Shell
ansible all -i hosts -m ping
````

Try the same comand with `-f` option to fork 6 parallel executions and see the difference...

```Shell
ansible all -i hosts -f 6 -m ping
````

> Note that we specify the inventory file with `-i` option. Here our inventory file is >`hosts` when `all` is the default group where stand all the host ansible could discover >in the his inventory.

## Using groups to manage all of our hosts

Groups are described with section commonly used in `.ini` files...

```INI
[webserver-dev]
webserver1.dev
webserver2.dev

[webserver-dev:vars]
db_hostname=database.dev

[database-dev]
database.dev

[dev:children]
webserver-dev
database-dev

[dev:vars]
env=development

[webserver-prod]
webserver1.prod
webserver2.prod

[webserver-prod:vars]
db_hostname=database.prod

[database-prod]
database.prod

[prod:children]
webserver-prod
database-prod

[prod:vars]
env=production

```

Change your inventory file and Try to ping all your development hosts...

```Shell
ansible development -i hosts -m ping
```

