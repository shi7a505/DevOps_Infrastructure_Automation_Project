#!/bin/bash
set -e

# Update system
sudo apt-get update
sudo apt-get upgrade -y

# Install Java 8 (Nexus requires Java 8)
sudo apt-get install -y openjdk-8-jdk

# Create nexus user
sudo useradd -M -d /opt/nexus -s /bin/bash -r nexus

# Download and install Nexus
cd /opt
NEXUS_VERSION="3.60.0-02"
sudo wget https://download.sonatype.com/nexus/3/nexus-${NEXUS_VERSION}-unix.tar.gz
sudo tar -xvzf nexus-${NEXUS_VERSION}-unix.tar.gz
sudo mv nexus-${NEXUS_VERSION} nexus
sudo rm nexus-${NEXUS_VERSION}-unix.tar.gz

# Set permissions
sudo chown -R nexus:nexus /opt/nexus
sudo chown -R nexus:nexus /opt/sonatype-work

# Configure Nexus to run as nexus user
echo 'run_as_user="nexus"' | sudo tee /opt/nexus/bin/nexus.rc

# Create systemd service
sudo tee /etc/systemd/system/nexus.service > /dev/null << 'SERVICE'
[Unit]
Description=Nexus Repository Manager
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
ExecStart=/opt/nexus/bin/nexus start
ExecStop=/opt/nexus/bin/nexus stop
User=nexus
Restart=on-abort

[Install]
WantedBy=multi-user.target
SERVICE

# Start Nexus
sudo systemctl daemon-reload
sudo systemctl enable nexus
sudo systemctl start nexus

# Wait for Nexus to generate admin password
sleep 60

# Save admin password
if [ -f /opt/sonatype-work/nexus3/admin.password ]; then
    sudo cp /opt/sonatype-work/nexus3/admin.password /home/ubuntu/nexus-admin-password.txt
    sudo chown ubuntu:ubuntu /home/ubuntu/nexus-admin-password.txt
fi

# Create completion marker
echo "Nexus setup completed at $(date)" | sudo tee /home/ubuntu/nexus-setup-complete.txt

echo "Nexus is starting... It may take 2-3 minutes to be fully ready."
echo "Access Nexus at: http://$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4):8081"

