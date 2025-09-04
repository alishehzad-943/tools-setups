
#Coplete content Paste in file and Executes
vim file.sh
chmod  +x file.sh
./file.sh

#!/bin/bash
set -e

### PROMETHEUS INSTALLATION ###
wget https://github.com/prometheus/prometheus/releases/download/v2.43.0/prometheus-2.43.0.linux-amd64.tar.gz
tar -xf prometheus-2.43.0.linux-amd64.tar.gz
sudo mv prometheus-2.43.0.linux-amd64/prometheus prometheus-2.43.0.linux-amd64/promtool /usr/local/bin

# create directories
sudo mkdir -p /etc/prometheus /var/lib/prometheus
sudo mv prometheus-2.43.0.linux-amd64/consoles /etc/prometheus
sudo mv prometheus-2.43.0.linux-amd64/console_libraries /etc/prometheus

# cleanup
rm -rvf prometheus-2.43.0.linux-amd64*

# Prometheus config
sudo cat <<EOF | sudo tee /etc/prometheus/prometheus.yml
global:
  scrape_interval: 10s

scrape_configs:
  - job_name: 'prometheus_metrics'
    scrape_interval: 5s
    static_configs:
      - targets: ['localhost:9090']
  - job_name: 'node_exporter_metrics'
    scrape_interval: 5s
    static_configs:
      - targets: ['localhost:9100','worker-1:9100','worker-2:9100']
EOF

# user & permissions
sudo useradd -rs /bin/false prometheus || true
sudo chown -R prometheus: /etc/prometheus /var/lib/prometheus

# systemd service
sudo cat <<EOF | sudo tee /etc/systemd/system/prometheus.service
[Unit]
Description=Prometheus
After=network.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
    --config.file /etc/prometheus/prometheus.yml \
    --storage.tsdb.path /var/lib/prometheus/ \
    --web.console.templates=/etc/prometheus/consoles \
    --web.console.libraries=/etc/prometheus/console_libraries

[Install]
WantedBy=multi-user.target
EOF

# start prometheus
sudo systemctl daemon-reload
sudo systemctl enable prometheus
sudo systemctl start prometheus
sudo systemctl status prometheus --no-pager

# open firewall
sudo firewall-cmd --add-port=9090/tcp --permanent
sudo firewall-cmd --reload

