#!/bin/bash
set -e

# Update system
sudo apt-get update
sudo apt-get upgrade -y

# Install Java 17
sudo apt-get install -y openjdk-17-jdk

# Install PostgreSQL
sudo apt-get install -y postgresql postgresql-contrib

# Configure PostgreSQL for SonarQube
sudo -u postgres psql -c "CREATE USER sonar WITH ENCRYPTED PASSWORD 'sonar123';"
sudo -u postgres psql -c "CREATE DATABASE sonarqube OWNER sonar;"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE sonarqube TO sonar;"

# System configuration for SonarQube
echo "vm.max_map_count=524288" | sudo tee -a /etc/sysctl.conf
echo "fs.file-max=131072" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

echo "sonarqube   -   nofile   131072" | sudo tee -a /etc/security/limits.conf
echo "sonarqube   -   nproc    8192" | sudo tee -a /etc/security/limits.conf

# Create sonarqube user
sudo useradd -M -d /opt/sonarqube -s /bin/bash sonarqube

# Download and install SonarQube
cd /opt
SONAR_VERSION="10.3.0.82913"
sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-${SONAR_VERSION}.zip
sudo apt-get install -y unzip
sudo unzip sonarqube-${SONAR_VERSION}.zip
sudo mv sonarqube-${SONAR_VERSION} sonarqube
sudo rm sonarqube-${SONAR_VERSION}.zip

# Configure SonarQube
sudo tee /opt/sonarqube/conf/sonar.properties > /dev/null << 'SONAR'
sonar.jdbc.username=sonar
sonar.jdbc.password=sonar123
sonar.jdbc.url=jdbc:postgresql://localhost:5432/sonarqube
sonar.web.host=0.0.0.0
sonar.web.port=9000
SONAR

# Set permissions
sudo chown -R sonarqube:sonarqube /opt/sonarqube

# Create systemd service
sudo tee /etc/systemd/system/sonarqube.service > /dev/null << 'SERVICE'
[Unit]
Description=SonarQube service
After=network.target

[Service]
Type=forking
ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start
ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop
User=sonarqube
Group=sonarqube
Restart=on-failure
LimitNOFILE=131072
LimitNPROC=8192

[Install]
WantedBy=multi-user.target
SERVICE

# Start SonarQube
sudo systemctl daemon-reload
sudo systemctl enable sonarqube
sudo systemctl start sonarqube

# Create completion marker
echo "SonarQube setup completed at $(date)" | sudo tee /home/ubuntu/sonarqube-setup-complete.txt

echo "SonarQube is starting... It may take 3-5 minutes to be fully ready."
echo "Default credentials: admin / admin"
echo "Access SonarQube at: http://$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4):9000"

