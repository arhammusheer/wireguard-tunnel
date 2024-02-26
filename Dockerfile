# Use an official Ubuntu base image
FROM ubuntu:20.04

# Avoid prompts during package installation
ARG DEBIAN_FRONTEND=noninteractive

# Install WireGuard, iptables, qrencode, and iproute2 (for the ip command)
RUN apt-get update && \
    apt-get install -y wireguard iptables qrencode iproute2

# Copy the startup script into the container
COPY entrypoint.sh /entrypoint.sh

# Make the startup script executable
RUN chmod +x /entrypoint.sh

# Use the ENTRYPOINT to run the startup script
ENTRYPOINT ["/entrypoint.sh"]
