[Unit]
Description=ToDoApp
Requires=network-online.target
After=network-online.target

[Service]
Environment=DB_URL=
Environment=SESSION_SECRET=secret
WorkingDirectory=
Type=simple
ExecStart=
Restart=on-failure

[Install]
WantedBy=multi-user.target
