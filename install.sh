json_content=$(cat <<-EOF
[Unit]
Description=Daemonize ASH HTTP Tunnel Server
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

lsof -i :"$http_port"
echo -e "$YELLOW"
echo "HTTP Proxy installed successfully"
echo -e "$NC"
exit 1
