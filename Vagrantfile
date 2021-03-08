$script = <<-SCRIPT
echo I am provisioning...
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io git
echo Creating docker group if needed...
sudo usermod -aG docker vagrant
sudo apt-get install -y python3-pip
sudo python3 -m pip install --upgrade pip
sudo pip3 install docker-compose
cd /vagrant
docker-compose up -d
SCRIPT

$script2 = <<-SCRIPT
echo "Create CentOS user"
adduser centos
usermod --password $(openssl passwd -1 'centos') centos
usermod -aG wheel centos
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
systemctl restart sshd
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.network "private_network", type: "dhcp"

  config.vm.define "deployment_vm" do |subconfig|
    subconfig.vm.box = "ubuntu/bionic64"
    subconfig.vm.network :forwarded_port, guest: 8080, host: 8080
    subconfig.vm.network :forwarded_port, guest: 50000, host: 50000
    subconfig.vm.provision "shell", inline: $script

    subconfig.vm.provider "virtualbox" do |v|
      v.memory = 4096
    end
  end

  config.vm.define "app_vm" do |subconfig|
    subconfig.vm.box = "centos/7"
    subconfig.vm.network :forwarded_port, guest: 80, host: 8081
    subconfig.vm.provision "shell", inline: $script2
  end
end
