[Unit]
Description=Puma HTTP Server
After=network.target

[Service]
Environment="DATABASE_URL=${db_address}"
Type=simple
User=appuser
WorkingDirectory=/home/appuser/reddit
ExecStart=/bin/bash -lc 'puma'
Restart=always

[Install]
WantedBy=multi-user.target
