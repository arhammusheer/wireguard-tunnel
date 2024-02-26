FROM alpine:latest
LABEL maintainer="arhammusheer"

# Install WireGuard and other necessary packages
RUN apk add --no-cache wireguard-tools iptables bash

# Generate WireGuard keys
RUN wg genkey | tee /etc/wireguard/privatekey | wg pubkey > /etc/wireguard/publickey

# Adjust permissions for the keys
RUN chmod 600 /etc/wireguard/privatekey /etc/wireguard/publickey

# Copy the entrypoint script into the container
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
