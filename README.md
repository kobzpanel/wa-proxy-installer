# WhatsApp Proxy One-Click Installer

A simple, one-command installer for the official WhatsApp Proxy on your VPS. Uses Meta's official Docker image for reliable, secure setup.

> **Important**: This proxy supports WhatsApp text chat and media (images, videos, files) routing. Voice/video calls and status updates are **not supported** (official limitation).

## Features
- True one-click installation
- Official WhatsApp Proxy image (`ghcr.io/whatsapp/proxy:latest`)
- Automatic Docker installation (if needed)
- UFW firewall auto-configuration (opens port 443 + SSH)
- Lightweight and secure – no unnecessary packages
- Easy updates and management

## Requirements
- Ubuntu/Debian-based VPS (22.04+ recommended)
- Root access
- Public IP address
- At least 1 GB RAM (proxy is very lightweight)

## One-Click Installation

Run this command as root:

```bash
curl -fsSL https://raw.githubusercontent.com/kobzpanel/wa-proxy-installer/refs/heads/main/install.sh | bash
