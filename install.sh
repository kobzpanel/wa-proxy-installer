bash <<'EOF'
#!/bin/bash
set -e

echo "Updating package list..."
apt update

echo "Installing Docker and curl..."
apt install -y docker.io curl ca-certificates

echo "Enabling and starting Docker..."
systemctl enable --now docker

echo "Pulling official WhatsApp Proxy image..."
docker pull facebook/whatsapp_proxy:latest

echo "Starting WhatsApp Proxy container..."
docker run -d --name whatsapp_proxy --restart unless-stopped \
  -p 80:80 \
  -p 443:443 \
  -p 5222:5222 \
  -p 8080:8080 \
  -p 8443:8443 \
  -p 8222:8222 \
  -p 8199:8199 \
  -p 587:587 \
  -p 7777:7777 \
  facebook/whatsapp_proxy:latest

echo "Configuring firewall (UFW if installed)..."
if command -v ufw &> /dev/null; then
  ufw allow 80/tcp
  ufw allow 443/tcp
  ufw allow 5222/tcp
  ufw allow 8080/tcp
  ufw allow 8443/tcp
  ufw allow 8222/tcp
  ufw allow 8199/tcp
  ufw allow 587/tcp
  ufw allow 7777/tcp
  ufw reload
  echo "UFW ports opened automatically."
else
  echo "UFW not found. Manually open these ports in your VPS firewall/security group:"
  echo "80, 443, 5222, 8080, 8443, 8222, 8199, 587, 7777"
fi

IP=$(curl -s icanhazip.com)

echo ""
echo "=========================================="
echo "WhatsApp Proxy Installed Successfully!"
echo "=========================================="
echo "Your public IP: $IP"
echo ""
echo "Recommended proxy addresses to share in WhatsApp app:"
echo "   $IP:443   (Primary - HTTPS)"
echo "   $IP:80    (Fallback - HTTP)"
echo "   $IP:5222  (Alternative)"
echo ""
echo "View stats/monitoring: http://$IP:8199"
echo "View logs: docker logs -f whatsapp_proxy"
echo ""
echo "Note: First startup generates self-signed certificates (takes 1-5 minutes)."
echo "      Check logs if needed."
echo "To stop: docker stop whatsapp_proxy"
echo "To restart: docker restart whatsapp_proxy"
echo "To update: docker pull facebook/whatsapp_proxy:latest && docker restart whatsapp_proxy"
echo ""
echo "Share the proxy address in WhatsApp: Settings > Storage and data > Proxy > Use proxy."
EOF
