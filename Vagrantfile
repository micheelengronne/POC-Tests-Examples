$script = <<-SCRIPT
echo I am provisioning...
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker vagrant
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.box = "generic/ubuntu1804"
  config.vm.network :forwarded_port, guest: 8080, host: 8081
  config.vm.provision "shell", inline: $script
end
