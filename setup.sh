sudo apt update

# Install commonly used tools
sudo apt install -y neofetch python3-pip


# Download Tailscale
curl -fsSL https://tailscale.com/install.sh | sh

# Configure IP Forwarding
echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.conf
echo 'net.ipv6.conf.all.forwarding = 1' | sudo tee -a /etc/sysctl.conf
sudo sysctl -p /etc/sysctl.conf

# Download docker
curl -fsSL https://get.docker.com -o ./tmp/get-docker.sh

# Install docker
sudo sh ./tmp/get-docker.sh

# Download + Install Webmin
sudo curl -o setup-repos.sh https://raw.githubusercontent.com/webmin/webmin/master/setup-repos.sh
sudo sh setup-repos.sh
sudo apt-get install webmin --install-recommends -y

# Provision Tailscale
#sudo tailscale up --authkey tskey-auth-REDACTED --advertise-exit-node --ssh


# Create user
username=REDACTED
password=REDACTED

echo "Group $username does not exist, adding it now"
sudo groupadd "$username"
echo "Created personal group $username"
sudo useradd -m -g $username -s /bin/bash "$username"
echo "Created a new user $username"
sudo usermod -aG sudo $username 
sudo usermod -aG docker $username
echo "$username:$password" | sudo chpasswd

su - $username

echo "ssh-rsa REACTED" >> /home/$username/.ssh/authorized_keys

echo "Setup Complete!"

neofetch
