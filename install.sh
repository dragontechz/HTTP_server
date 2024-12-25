json_content=$(cat <<-EOF
[Unit]
Description=Daemon HTTP Tunnel Server
Wants=network.target
After=network.target

[Service]
ExecStart=/root/HTTP_server/server
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF
)

echo "$json_content" > /etc/systemd/system/server.service
systemctl daemon-reload
systemctl start server
systemctl enable server

echo "HTTP Proxy installed successfully"
exit 1
