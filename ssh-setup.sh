#!/bin/bash

# Ensure the script is running as the vagrant user
USER="vagrant"
SSH_DIR="/home/$USER/.ssh"
AUTHORIZED_KEYS="$SSH_DIR/authorized_keys"

# Install sshpass if it's not already installed
if ! command -v sshpass &> /dev/null; then
    echo "sshpass not found. Installing..."
    sudo apt-get update
    sudo apt-get install -y sshpass
fi

# Generate SSH keys if they do not already exist
if [ ! -f "$SSH_DIR/id_rsa" ]; then
    echo "Generating SSH keys for $USER..."
    sudo -u $USER ssh-keygen -t rsa -b 4096 -f "$SSH_DIR/id_rsa" -N ""
fi

# Set correct permissions for the SSH directory and keys
sudo -u $USER chmod 700 "$SSH_DIR"
sudo -u $USER chmod 600 "$SSH_DIR/id_rsa"
sudo -u $USER chmod 644 "$SSH_DIR/id_rsa.pub"

# List of all nodes (adjust IP addresses as needed)
NODES=("192.168.56.4" "192.168.56.5" "192.168.56.6") # Add your node IPs here

# Loop through each node and copy the public key to authorized_keys
for NODE in "${NODES[@]}"; do
    echo "Copying SSH key to $NODE..."
    # Use sshpass to automate password entry
    sshpass -p "vagrant" ssh-copy-id -o StrictHostKeyChecking=no -i "$SSH_DIR/id_rsa.pub" vagrant@$NODE
done

echo "SSH key setup completed."
