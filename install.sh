
read -p "Saisissez le numéro du port : " port

# Vérifie si le numéro saisi est un nombre
if [[ $port =~ ^[0-9]+$ ]]; then
  # Si c'est un numéro, affiche une message de confirmation
  echo "Vous avez saisi un numéro valide pour le port : $port"
  json_content=$(cat <<-EOF
  [Unit]
  Description=Daemonize ASH HTTP Tunnel Server
  Wants=network.target
  After=network.target
  
  [Service]
  ExecStart=/root/HTTP_server/server -p $port
  Restart=always
  RestartSec=3
  
  [Install]
  WantedBy=multi-user.target
EOF
)
  echo "$json_content" > /etc/systemd/system/server.service -p $port

else
  
  echo "utilisation du port par defaut 8080"
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


echo "$json_content" > /etc/systemd/system/server.service
systemctl daemon-reload
systemctl start server
systemctl enable server

lsof -i :"$http_port"
echo -e "$YELLOW"
echo "HTTP Proxy installed successfully"
echo -e "$NC"
exit 1
fi


systemctl daemon-reload
systemctl start server
systemctl enable server

lsof -i :"$http_port"
echo -e "$YELLOW"
echo "HTTP Proxy installed successfully"
echo -e "$NC"
exit 1
