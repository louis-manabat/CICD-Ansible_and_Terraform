[Unit]
Description=ToDoApp
Requires=network-online.target
After=network-online.target

[Service]
Environment=DB_URL=mongodb://{{ db_username }}:{{ db_password }}@{{ db_endpoint }}:{{ db_port }}
Environment=SESSION_SECRET=secret
WorkingDirectory=/etc/app/dist
Type=simple
ExecStart=/etc/app/dist/package serve
Restart=on-failure
