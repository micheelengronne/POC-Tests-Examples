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
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
echo Creating docker group if needed...
sudo usermod -aG docker vagrant
echo Installing ansible...
sudo apt-get install -y python3-pip
pip3 install ansible
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.network "private_network", type: "dhcp"

  config.vm.define "master" do |subconfig|
    subconfig.vm.box = "generic/ubuntu1804"
    subconfig.vm.network :forwarded_port, guest: 8080, host: 8081
    subconfig.vm.provision "shell", inline: $script
  end

  config.vm.define "node1" do |subconfig|
    subconfig.vm.box = "generic/ubuntu1804"
  end

  config.vm.define "node2" do |subconfig|
    subconfig.vm.box = "generic/ubuntu1804"
  end
end
