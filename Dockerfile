# Use an official Ubuntu base image
FROM ubuntu:20.04

# Install WireGuard and other necessary tools
RUN apt-get update && \
	apt-get install -y software-properties-common && \
	add-apt-repository -y ppa:wireguard/wireguard && \
	apt-get update && \
	apt-get install -y wireguard iptables qrencode

# Copy the startup script into the container
COPY entrypoint.sh /entrypoint.sh

# Make the startup script executable
RUN chmod +x /entrypoint.sh

# Run the startup script
ENTRYPOINT ["/entrypoint.sh"]
