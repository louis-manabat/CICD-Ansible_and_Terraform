# data "template_cloudinit_config" "config" {
#   gzip          = false
#   base64_encode = false

#   part {
#     content_type = "text/x-shellscript"
#     content      = <<-EOF

#     #!/bin/bash
#     rm -f /etc/app/dist/conf.toml

#     cat > /etc/app/dist/conf.toml << EOL
#     "DbUser" = "mongousername"
#     "DbPassword" = "mongopassword"
#     "DbPort" = "5432"
#     "DbHost" = "'${aws_docdb_cluster.docodb.endpoint}'"
#     "ListenHost" = "0.0.0.0"
#     "listenPort" = "80"
#     EOL

#     cat > /usr/lib/systemd/system/techtestapp.service << EOL
#     [Unit]
#     Description=TechTestApp
#     Requires=network-online.target
#     After=network-online.target

#     [Service]
#     WorkingDirectory=/etc/app/dist
#     Type=simple
#     ExecStart=/etc/app/dist/TechTestApp serve
#     Restart=on-failure

#     [Install]
#     WantedBy=multi-user.target
#     EOL

#     systemctl daemon-reload
#     sudo systemctl restart techtestapp

#     EOF
#   }
# }