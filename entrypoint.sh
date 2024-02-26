#!/bin/bash

# Check if the WireGuard private key file exists, generate one if it does not
WG_DIR="/etc/wireguard"
PRIVATE_KEY_FILE="$WG_DIR/privatekey"
PUBLIC_KEY_FILE="$WG_DIR/publickey"
CONF_FILE="$WG_DIR/wg0.conf"

if [ ! -f "$PRIVATE_KEY_FILE" ]; then
    wg genkey | tee $PRIVATE_KEY_FILE | wg pubkey > $PUBLIC_KEY_FILE
fi

PRIVATE_KEY=$(cat $PRIVATE_KEY_FILE)

# Generate the WireGuard configuration file
cat > $CONF_FILE <<EOF
[Interface]
Address = 10.0.0.1/24
SaveConfig = true
PrivateKey = $PRIVATE_KEY
ListenPort = 51820
PostUp = iptables -A FORWARD -i %i -j ACCEPT; iptables -A FORWARD -o %i -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -D FORWARD -o %i -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE
EOF

# Add peers configuration here or through a different method
# [Peer]
# PublicKey = <ClientPublicKey>
# AllowedIPs = 10.0.0.2/32

# Start WireGuard
wg-quick up wg0

# Keep the container running
exec "$@"
