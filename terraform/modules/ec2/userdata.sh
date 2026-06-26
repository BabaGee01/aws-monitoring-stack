#!/bin/bash
set -e

# Update system
dnf update -y

# ── NODE EXPORTER ──────────────────────────────────────────
useradd --no-create-home --shell /bin/false node_exporter

wget https://github.com/prometheus/node_exporter/releases/download/v1.7.0/node_exporter-1.7.0.linux-amd64.tar.gz
tar xvf node_exporter-1.7.0.linux-amd64.tar.gz
cp node_exporter-1.7.0.linux-amd64/node_exporter /usr/local/bin/
chown node_exporter:node_exporter /usr/local/bin/node_exporter

cat > /etc/systemd/system/node_exporter.service << 'EOF'
[Unit]
Description=Node Exporter
After=network.target

[Service]
User=node_exporter
ExecStart=/usr/local/bin/node_exporter
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

# ── PROMETHEUS ─────────────────────────────────────────────
useradd --no-create-home --shell /bin/false prometheus
mkdir -p /etc/prometheus /var/lib/prometheus
chown prometheus:prometheus /etc/prometheus /var/lib/prometheus

wget https://github.com/prometheus/prometheus/releases/download/v2.49.0/prometheus-2.49.0.linux-amd64.tar.gz
tar xvf prometheus-2.49.0.linux-amd64.tar.gz
cp prometheus-2.49.0.linux-amd64/prometheus /usr/local/bin/
cp prometheus-2.49.0.linux-amd64/promtool /usr/local/bin/
cp -r prometheus-2.49.0.linux-amd64/consoles /etc/prometheus
cp -r prometheus-2.49.0.linux-amd64/console_libraries /etc/prometheus
chown -R prometheus:prometheus /usr/local/bin/prometheus /usr/local/bin/promtool /etc/prometheus

cat > /etc/prometheus/prometheus.yml