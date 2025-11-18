#!/bin/bash
# Quick Install Script for Unified Cyber Warfare Platform
set -e

echo "🚀 Installing Unified Cyber Warfare Platform..."

# Clone repository
git clone -b unified-cyber-warfare-platform https://github.com/uinio6324-code/rtd.git ucwp
cd ucwp/UNIFIED_CYBER_WARFARE_PLATFORM

# Install system dependencies
if command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update && sudo apt-get install -y python3 python3-pip python3-venv git curl wget nmap tor proxychains4 postgresql redis-server
elif command -v yum >/dev/null 2>&1; then
    sudo yum install -y python3 python3-pip git curl wget nmap tor proxychains-ng postgresql redis
elif command -v pacman >/dev/null 2>&1; then
    sudo pacman -Syu --noconfirm python python-pip git curl wget nmap tor proxychains-ng postgresql redis
elif command -v brew >/dev/null 2>&1; then
    brew install python3 git curl wget nmap tor proxychains-ng postgresql redis
fi

# Setup Python environment
python3 -m venv venv
source venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt
pip install aiohttp dnspython cryptography numpy pandas matplotlib seaborn psutil stem PySocks websockets pymongo redis psycopg2-binary PyJWT scapy requests beautifulsoup4

# Start services
sudo systemctl start tor 2>/dev/null || true
sudo systemctl start postgresql 2>/dev/null || true
sudo systemctl start redis 2>/dev/null || true

# Create startup script
cat > run.sh << 'EOF'
#!/bin/bash
cd "$(dirname "$0")"
source venv/bin/activate
python3 unified_interface.py --interactive
EOF
chmod +x run.sh

echo "✅ Installation complete!"
echo "📍 Directory: $(pwd)"
echo "🚀 To start: ./run.sh"
echo "🎯 Or run: python3 real_penetration_engine.py"