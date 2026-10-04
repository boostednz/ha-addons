#!/usr/bin/with-contenv bashio

SERVER=$(bashio::config 'server')
SERVER_PORT=$(bashio::config 'server_port')
TOKEN=$(bashio::config 'token')
SUBDOMAIN=$(bashio::config 'subdomain')

bashio::log.info "Starting Boosted Connect..."
bashio::log.info "Server: ${SERVER}:${SERVER_PORT}"
bashio::log.info "Subdomain: ${SUBDOMAIN}.${SERVER}"

# Write frpc config
cat > /tmp/frpc.toml <<EOF
serverAddr = "${SERVER}"
serverPort = ${SERVER_PORT}
auth.method = "token"
auth.token = "${TOKEN}"

[[proxies]]
name = "${SUBDOMAIN}"
type = "http"
localIP = "127.0.0.1"
localPort = 8123
customDomains = ["${SUBDOMAIN}.${SERVER}"]
EOF

bashio::log.info "Connecting tunnel..."
exec frpc -c /tmp/frpc.toml
