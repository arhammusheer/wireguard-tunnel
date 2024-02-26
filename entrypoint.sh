#!/bin/bash

# Path to the WireGuard configuration directory
WG_DIR="/etc/wireguard"
CONFIG="$WG_DIR/wg0.conf"

# Generate new WireGuard keys
PRIVATE_KEY=$(wg genkey)
PUBLIC_KEY=$(echo "$PRIVATE_KEY" | wg pubkey)

# Prepare the WireGuard configuration
cat > "$CONFIG" <<EOF
[Interface]
Address = 10.0.0.1/24
ListenPort = 51820
PrivateKey = $PRIVATE_KEY
EOF

# (Optional) Add peers. This example assumes you have a way to manage and distribute peer configurations.
# [Peer]
# PublicKey = PEER_PUBLIC_KEY
# AllowedIPs = 10.0.0.2/32

# Enable IP forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward

# Start WireGuard
wg-quick up wg0

# Keep the container running and log to docker
exec tail -f /dev/null
