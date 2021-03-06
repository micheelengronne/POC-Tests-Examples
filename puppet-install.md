# Puppet Install

Everything should be done as `root`. So `sudo su` first.

Add in master and node1 `/etc/hosts` the hostname of the master (mastervm) as well
as `puppet` as another hostname of the master.

On master:

```
wget https://apt.puppet.com/puppet7-release-bionic.deb
dpkg -i puppet7-release-bionic.deb
apt-get update
apt-get install -y puppetserver
```

Modify `JAVA_ARGS="-Xms512m -Xmx512m"` in `/etc/default/puppetserver`.

```
systemctl start puppetserver
export PATH=$PATH:/opt/puppetlabs/bin
puppetserver -v
```

On node:

```
wget https://apt.puppet.com/puppet7-release-bionic.deb
dpkg -i puppet7-release-bionic.deb
apt-get update
apt-get install -y puppet-agent
source /etc/profile.d/puppet-agent.sh
puppet config set server mastervm --section main
puppet ssl bootstrap
```

On master:

```
puppetserver ca sign --certname node1vm
```

On node again:

```
puppet ssl bootstrap
```

You can now manage your code in `/etc/puppetlabs/code/environments/production`
(autodetected by the master)
and apply it on the agent with `puppet agent -t`
