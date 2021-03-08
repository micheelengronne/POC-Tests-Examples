# Chef Install

Everything should be done as `root`. So `sudo su` first.

Add master hostname in node1 `/etc/hosts`.

Install chef-workstation on master:

```
wget https://packages.chef.io/files/stable/chef-workstation/21.2.278/ubuntu/20.04/chef-workstation_21.2.278-1_amd64.deb
dpkg -i chef-workstation_21.2.278-1_amd64.deb
chef -v
```

Install chef-server on master:

```
wget https://packages.chef.io/files/stable/chef-server/14.1.0/ubuntu/18.04/chef-server-core_14.1.0-1_amd64.deb
dpkg -i chef-server-core_14.1.0-1_amd64.deb
chef-server-ctl reconfigure
chef-server-ctl user-create vagrant testfirst testlast test@example.com 'testtest' --filename testtest
mkdir /root/.chef
cp testtest /root/.chef/vagrant.pem
chef-server-ctl org-create myorg 'my_orga' --association_user vagrant --filename test-validator.pem
```

Add ssh between VMs.

On master:

```
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
knife configure initial
knife ssl fetch
knife bootstrap IP -N node1vm -U root
```

Start a workstation cookbook (the infra-as-code itself) on master:

```
mkdir -p /var/chef/cookbooks
cd /var/chef/cookbooks
chef generate cookbook firstcook
```

Upload it on the server and set the node for it on master:

```
knife cookbook upload firstcook
knife node run_list add node1vm firstcook
```

Apply the code on node

```
chef-client
```
