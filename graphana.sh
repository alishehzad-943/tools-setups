# Install dependencies
sudo yum install -y fontconfig freetype urw-fonts

# Add Grafana repo
sudo tee /etc/yum.repos.d/grafana.repo<<EOF
[grafana]
name=Grafana
baseurl=https://rpm.grafana.com
repo_gpgcheck=1
enabled=1
gpgcheck=1
gpgkey=https://rpm.grafana.com/gpg.key
EOF

# Install Grafana
sudo yum install -y grafana

# Enable and start service
sudo systemctl daemon-reload
sudo systemctl enable grafana-server
sudo systemctl start grafana-server

# Check status
sudo systemctl status grafana-server --no-pager
