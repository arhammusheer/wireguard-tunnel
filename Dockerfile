# Use an official Ubuntu base image
FROM ubuntu:20.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install WireGuard, iptables, and qrencode for QR code generation (if needed) directly from the official repositories
RUN apt-get update && \
    apt-get install -y wireguard iptables qrencode

# Copy the startup script into the container
COPY entrypoint.sh /entrypoint.sh

# Make the startup script executable
RUN chmod +x /entrypoint.sh

# Set the entrypoint script to run when the container starts
ENTRYPOINT ["/entrypoint.sh"]
