[Unit]
Description=ToDoApp
Requires=network-online.target
After=network-online.target

[Service]
Environment="DB_URL=mongodb://mongousername:mongopassword@todo-app.cluster-ciwgmikiqe2t.us-east-1.docdb.amazonaws.com:5432/?ssl=true&ssl_ca_certs=rds-combined-ca-bundle.pem&replicaSet=rs0&readPreference=secondaryPreferred&retryWrites=false"
Environment=SESSION_SECRET=secret
WorkingDirectory=
Type=simple
ExecStart=
Restart=on-failure
