#!/bin/bash

# Update system
sudo apt-get update -y

# Create a node_exporter user
sudo useradd --no-create-home --shell /bin/false node_exporter

# Download Node Exporter latest version
cd /tmp
wget https://github.com/prometheus/node_exporter/releases/download/v1.6.1/node_exporter-1.6.1.linux-amd64.tar.gz

# Extract files
tar xvf node_exporter-1.6.1.linux-amd64.tar.gz
sudo cp node_exporter-1.6.1.linux-amd64/node_exporter /usr/local/bin/

# Set permissions
sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter

# Create systemd service file
cat <<EOF | sudo tee /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd and start service
sudo systemctl daemon-reload
sudo systemctl start node_exporter
sudo systemctl enable node_exporter

# Allow port 9100 in firewall/security group if needed
echo "Node Exporter installation complete."
echo "Check it by opening: http://<EC2-Public-IP>:9100/metrics"
