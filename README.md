# WhatsApp Proxy One-Click Installer

A simple, secure, and production-ready **one-command installer** for the **official WhatsApp Proxy** on your VPS.  
Uses Meta’s **official Docker image** for maximum reliability and compliance.

> ⚠️ **Important Limitation (Official)**  
> This proxy supports **WhatsApp text messages and media** (images, videos, documents).  
> **Voice calls, video calls, and status updates are NOT supported.**

---

## ✨ Features

-  True **one-click installation**
-  Uses **official WhatsApp Proxy image**  
  `ghcr.io/whatsapp/proxy:latest`
- 🔧 Automatically installs Docker (if missing)
- 🔐 Auto-configures UFW firewall
  - Opens **port 443**
  - Keeps **SSH access**
-  Lightweight & fast
-  Secure by default
-  Easy update & management
-  No PHP, no panel, no bloat

---

## 📋 Requirements

- Ubuntu / Debian VPS  
  - Ubuntu **22.04+ recommended**
- Root access
- Public IPv4 address
- Minimum **1 GB RAM**

---

## 🚀 One-Click Installation

Run the following command **as root**:

```bash
curl -fsSL https://raw.githubusercontent.com/kobzpanel/wa-proxy-installer/refs/heads/main/install.sh | bash
```

---

## 🛠️ Useful Commands

### Check proxy status
```bash
docker ps
```

### View logs
```bash
docker logs whatsapp-proxy
```

### Restart proxy
```bash
docker restart whatsapp-proxy
```

---

## 💖 Support & Donation

If this project helps you, you can support its development ❤️  

👉 **Donate here:**  
https://alamindev.site/payment-link/1311700226  

> Donation is **optional**. Installer works without payment.

---

## 📄 License

MIT License
