#!/bin/bash
# Fixed Installation Script
set -e

echo "🔧 Fixing installation issues..."

# Navigate to the correct directory
cd ~/ucwp/UNIFIED_CYBER_WARFARE_PLATFORM

# Activate virtual environment
source venv/bin/activate

# Install minimal requirements that work
echo "📦 Installing minimal requirements..."
pip install aiohttp dnspython cryptography numpy pandas matplotlib seaborn psutil stem PySocks websockets pymongo redis psycopg2-binary PyJWT scapy requests beautifulsoup4 lxml fake-useragent python-whois pyyaml colorama tqdm click

# Test imports
echo "🧪 Testing imports..."
python3 -c "
import aiohttp, dnspython, cryptography, numpy, pandas
import psutil, stem, websockets, pymongo, redis, psycopg2
import scapy, requests, bs4, yaml
print('✅ All core modules imported successfully!')
"

# Create simple run script
cat > run.sh << 'EOF'
#!/bin/bash
cd "$(dirname "$0")"
source venv/bin/activate
echo "🚀 Starting Unified Cyber Warfare Platform..."
python3 unified_interface.py --interactive
EOF
chmod +x run.sh

# Create penetration test script
cat > run_penetration.sh << 'EOF'
#!/bin/bash
cd "$(dirname "$0")"
source venv/bin/activate
echo "💥 Starting Real Penetration Engine..."
python3 real_penetration_engine.py
EOF
chmod +x run_penetration.sh

echo "✅ Installation fixed!"
echo "🚀 To start platform: ./run.sh"
echo "💥 To run penetration test: ./run_penetration.sh"