# Chef Install

Install chef-workstation

```
wget https://packages.chef.io/files/stable/chef-server/14.1.0/ubuntu/18.04/chef-server-core_14.1.0-1_amd64.deb
dpkg -i chef-server-core_14.1.0-1_amd64.deb
chef-server-ctl reconfigure
chef-server-ctl user-create vagrant testfirst testlast test@example.com 'testtest' --filename testtest
cp testtest /root/.chef/vagrant.pem
chef-server-ctl org-create myorg 'my_orga' --association_user vagrant --filename test-validator.pem
```

Add ssh between VMs, add master hostname in node1 `/etc/hosts`

```
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
knife configure initial
knife ssl fetch
knife bootstrap IP -N node1vm -U root
```

Start a workstation cookbook (the infra-as-code itself)

```
mkdir -p /var/chef/cookbooks
cd /var/chef/cookbooks
chef generate cookbook firstcook
```

Upload it on the server and set the node for it

```
knife cookbook upload firstcook
knife node run_list add node1vm firstcook
```

Apply the code on node

```
chef-client
```
