#!/bin/bash
set -e

echo "======================================"
echo " WhatsApp Proxy One-Click Installer"
echo "======================================"

if [ "$EUID" -ne 0 ]; then
  echo "❌ Please run as root"
  exit 1
fi

echo "🔄 Updating system..."
apt update -y >/dev/null 2>&1

echo "📦 Installing dependencies..."
apt install -y curl ufw >/dev/null 2>&1

if ! command -v docker >/dev/null 2>&1; then
  echo "🐳 Installing Docker..."
  curl -fsSL https://get.docker.com | sh >/dev/null 2>&1
fi

systemctl enable docker >/dev/null 2>&1
systemctl start docker

echo "🔥 Configuring firewall..."
ufw allow 22 >/dev/null 2>&1
ufw allow 443 >/dev/null 2>&1
ufw --force enable >/dev/null 2>&1

echo "📥 Pulling WhatsApp Proxy image..."
docker pull ghcr.io/whatsapp/proxy:latest >/dev/null 2>&1

echo "🚀 Starting WhatsApp Proxy..."
docker rm -f whatsapp-proxy >/dev/null 2>&1 || true
docker run -d \
  --name whatsapp-proxy \
  --restart unless-stopped \
  -p 443:443 \
  ghcr.io/whatsapp/proxy:latest >/dev/null 2>&1

# Robust IP detection (fallback options)
IP=$(curl -s https://api.ipify.org || curl -s https://ifconfig.me || curl -s https://icanhazip.com)

echo ""
echo "======================================"
echo " ✅ WHATSAPP PROXY IS READY"
echo "======================================"
echo " 🌐 Proxy Address : $IP:443"
echo ""
echo " 📱 WhatsApp App Setup:"
echo " 1. Open WhatsApp → Settings → Storage and data → Proxy"
echo " 2. Turn on 'Use proxy'"
echo " 3. Enter proxy address: $IP:443"
echo " 4. Tap Save"
echo ""
echo " ⚠️  This is a public proxy — anyone with the address can use it."
echo "     Share responsibly (high bandwidth usage possible)."
echo ""
echo " 🔍 Check status: docker ps"
echo " 🛑 Stop/remove: docker stop whatsapp-proxy && docker rm whatsapp-proxy"
echo "======================================"
