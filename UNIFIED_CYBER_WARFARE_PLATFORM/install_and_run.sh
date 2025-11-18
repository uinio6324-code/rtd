#!/bin/bash

# UNIFIED CYBER WARFARE PLATFORM - COMPLETE INSTALLATION SCRIPT
# This script clones the repository and installs all frameworks automatically
# AUTHORIZED USE ONLY - FOR PENETRATION TESTING WITH WRITTEN PERMISSION

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Banner
echo -e "${PURPLE}"
echo "╔══════════════════════════════════════════════════════════════════════════════╗"
echo "║                    UNIFIED CYBER WARFARE PLATFORM                           ║"
echo "║                         INSTALLATION SCRIPT v2.1                           ║"
echo "║                                                                              ║"
echo "║  🎯 Nation-State Level Penetration Testing System                           ║"
echo "║  👻 Military-Grade Stealth & Anonymity                                      ║"
echo "║  🧠 AI Tactical Operator with Crypto Specialization                         ║"
echo "║  ⚡ Complete Exploitation Arsenal Integration                                ║"
echo "║  🔍 Intelligent Target Expansion Engine                                     ║"
echo "║                                                                              ║"
echo "║  ⚠️  AUTHORIZED USE ONLY - PENETRATION TESTING ONLY ⚠️                     ║"
echo "║     Only use on systems you own or have written permission to test          ║"
echo "╚══════════════════════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

echo -e "${CYAN}🚀 Starting Unified Cyber Warfare Platform Installation...${NC}"
echo

# Check if running as root
if [[ $EUID -eq 0 ]]; then
   echo -e "${YELLOW}⚠️  Running as root. This is recommended for full framework installation.${NC}"
else
   echo -e "${YELLOW}⚠️  Not running as root. Some frameworks may require sudo privileges.${NC}"
fi

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install system dependencies
install_system_dependencies() {
    echo -e "${BLUE}📦 Installing system dependencies...${NC}"
    
    if command_exists apt-get; then
        # Debian/Ubuntu
        sudo apt-get update
        sudo apt-get install -y \
            git curl wget python3 python3-pip python3-venv \
            build-essential libssl-dev libffi-dev \
            nmap masscan gobuster dirb nikto \
            sqlmap hydra john hashcat \
            tor proxychains4 \
            postgresql-client mysql-client redis-tools \
            openjdk-11-jdk nodejs npm \
            docker.io docker-compose \
            metasploit-framework \
            beef-xss \
            set \
            burpsuite
    elif command_exists yum; then
        # RHEL/CentOS/Fedora
        sudo yum update -y
        sudo yum install -y \
            git curl wget python3 python3-pip \
            gcc openssl-devel libffi-devel \
            nmap masscan gobuster dirb nikto \
            sqlmap hydra john hashcat \
            tor proxychains-ng \
            postgresql mysql redis \
            java-11-openjdk nodejs npm \
            docker docker-compose \
            metasploit-framework
    elif command_exists pacman; then
        # Arch Linux
        sudo pacman -Syu --noconfirm \
            git curl wget python python-pip \
            base-devel openssl libffi \
            nmap masscan gobuster dirb nikto \
            sqlmap hydra john hashcat \
            tor proxychains-ng \
            postgresql-libs mysql redis \
            jdk11-openjdk nodejs npm \
            docker docker-compose \
            metasploit
    elif command_exists brew; then
        # macOS
        brew update
        brew install \
            git curl wget python3 \
            nmap masscan gobuster dirb \
            sqlmap hydra john hashcat \
            tor proxychains-ng \
            postgresql mysql redis \
            openjdk@11 node \
            docker docker-compose
    else
        echo -e "${RED}❌ Unsupported package manager. Please install dependencies manually.${NC}"
        exit 1
    fi
    
    echo -e "${GREEN}✅ System dependencies installed${NC}"
}

# Function to clone repository
clone_repository() {
    echo -e "${BLUE}📥 Cloning Unified Cyber Warfare Platform repository...${NC}"
    
    REPO_URL="https://github.com/uinio6324-code/rtd.git"
    BRANCH="unified-cyber-warfare-platform"
    INSTALL_DIR="$HOME/unified_cyber_warfare_platform"
    
    if [ -d "$INSTALL_DIR" ]; then
        echo -e "${YELLOW}⚠️  Directory already exists. Updating...${NC}"
        cd "$INSTALL_DIR"
        git fetch origin
        git checkout "$BRANCH"
        git pull origin "$BRANCH"
    else
        git clone -b "$BRANCH" "$REPO_URL" "$INSTALL_DIR"
        cd "$INSTALL_DIR"
    fi
    
    cd "$INSTALL_DIR/UNIFIED_CYBER_WARFARE_PLATFORM"
    echo -e "${GREEN}✅ Repository cloned to: $INSTALL_DIR${NC}"
}

# Function to setup Python environment
setup_python_environment() {
    echo -e "${BLUE}🐍 Setting up Python environment...${NC}"
    
    # Create virtual environment
    python3 -m venv venv
    source venv/bin/activate
    
    # Upgrade pip
    pip install --upgrade pip setuptools wheel
    
    # Install Python dependencies
    pip install -r requirements.txt
    
    # Install additional penetration testing libraries
    pip install \
        scapy \
        impacket \
        pycryptodome \
        paramiko \
        requests-oauthlib \
        selenium \
        beautifulsoup4 \
        lxml \
        python-nmap \
        python-masscan \
        shodan \
        censys \
        dnspython \
        python-whois \
        geoip2 \
        maxminddb \
        yara-python \
        volatility3 \
        binwalk \
        pefile \
        capstone \
        keystone-engine \
        unicorn \
        ropper \
        pwntools \
        angr
    
    echo -e "${GREEN}✅ Python environment configured${NC}"
}

# Function to install penetration testing frameworks
install_penetration_frameworks() {
    echo -e "${BLUE}⚡ Installing penetration testing frameworks...${NC}"
    
    FRAMEWORKS_DIR="/opt/unified_cyber_warfare/frameworks"
    sudo mkdir -p "$FRAMEWORKS_DIR"
    
    # Install Metasploit (if not already installed)
    if ! command_exists msfconsole; then
        echo -e "${YELLOW}📦 Installing Metasploit Framework...${NC}"
        curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall
        chmod 755 msfinstall
        sudo ./msfinstall
        rm msfinstall
    fi
    
    # Install PowerShell Empire
    echo -e "${YELLOW}👑 Installing PowerShell Empire...${NC}"
    cd /tmp
    git clone --recursive https://github.com/EmpireProject/Empire.git
    cd Empire
    sudo ./setup/install.sh
    sudo cp -r . "$FRAMEWORKS_DIR/empire/"
    
    # Install BeEF
    echo -e "${YELLOW}🥩 Installing BeEF Framework...${NC}"
    cd /tmp
    git clone https://github.com/beefproject/beef.git
    cd beef
    sudo ./install
    sudo cp -r . "$FRAMEWORKS_DIR/beef/"
    
    # Install Social Engineer Toolkit
    echo -e "${YELLOW}🎭 Installing Social Engineer Toolkit...${NC}"
    cd /tmp
    git clone https://github.com/trustedsec/social-engineer-toolkit.git setoolkit/
    cd setoolkit
    sudo python3 setup.py install
    sudo cp -r . "$FRAMEWORKS_DIR/set/"
    
    # Install Sliver C2
    echo -e "${YELLOW}🔪 Installing Sliver C2...${NC}"
    cd /tmp
    curl https://sliver.sh/install | sudo bash
    sudo mkdir -p "$FRAMEWORKS_DIR/sliver"
    sudo cp /usr/local/bin/sliver-* "$FRAMEWORKS_DIR/sliver/" 2>/dev/null || true
    
    # Install Havoc C2
    echo -e "${YELLOW}👹 Installing Havoc C2...${NC}"
    cd /tmp
    git clone https://github.com/HavocFramework/Havoc.git
    cd Havoc
    sudo apt-get install -y golang-go
    make
    sudo cp -r . "$FRAMEWORKS_DIR/havoc/"
    
    # Install additional tools
    echo -e "${YELLOW}🔧 Installing additional tools...${NC}"
    
    # Install Gobuster
    if ! command_exists gobuster; then
        go install github.com/OJ/gobuster/v3@latest
        sudo cp ~/go/bin/gobuster /usr/local/bin/
    fi
    
    # Install FFuF
    go install github.com/ffuf/ffuf@latest
    sudo cp ~/go/bin/ffuf /usr/local/bin/
    
    # Install Nuclei
    go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
    sudo cp ~/go/bin/nuclei /usr/local/bin/
    
    # Install Subfinder
    go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
    sudo cp ~/go/bin/subfinder /usr/local/bin/
    
    # Install Httpx
    go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
    sudo cp ~/go/bin/httpx /usr/local/bin/
    
    echo -e "${GREEN}✅ Penetration testing frameworks installed${NC}"
}

# Function to configure Tor and proxies
configure_tor_proxies() {
    echo -e "${BLUE}🧅 Configuring Tor and proxy chains...${NC}"
    
    # Configure Tor
    sudo systemctl enable tor
    sudo systemctl start tor
    
    # Configure ProxyChains
    sudo tee /etc/proxychains4.conf > /dev/null <<EOF
strict_chain
proxy_dns
remote_dns_subnet 224
tcp_read_time_out 15000
tcp_connect_time_out 8000
localnet 127.0.0.0/255.0.0.0
localnet 10.0.0.0/255.0.0.0
localnet 172.16.0.0/255.240.0.0
localnet 192.168.0.0/255.255.0.0

[ProxyList]
socks4  127.0.0.1 9050
EOF
    
    echo -e "${GREEN}✅ Tor and proxy chains configured${NC}"
}

# Function to setup databases
setup_databases() {
    echo -e "${BLUE}🗄️ Setting up databases...${NC}"
    
    # Start database services
    sudo systemctl enable postgresql
    sudo systemctl start postgresql
    sudo systemctl enable redis
    sudo systemctl start redis
    
    # Create database for the platform
    sudo -u postgres createdb unified_cyber_warfare 2>/dev/null || true
    sudo -u postgres psql -c "CREATE USER ucw_user WITH PASSWORD 'ucw_secure_pass';" 2>/dev/null || true
    sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE unified_cyber_warfare TO ucw_user;" 2>/dev/null || true
    
    echo -e "${GREEN}✅ Databases configured${NC}"
}

# Function to create configuration files
create_configuration() {
    echo -e "${BLUE}⚙️ Creating configuration files...${NC}"
    
    # Create main configuration
    cat > config.json <<EOF
{
    "platform": {
        "name": "Unified Cyber Warfare Platform",
        "version": "2.1",
        "threat_level": "NATION_STATE",
        "stealth_level": "MAXIMUM"
    },
    "ghost_mode": {
        "proxy_sources": 300,
        "verification_steps": 10,
        "rotation_interval": 30,
        "tor_enabled": true,
        "traffic_obfuscation": true
    },
    "ai_operator": {
        "model_size": "1.5GB",
        "specialization": "CRYPTO_FUND_DRAINAGE",
        "decision_engine": "ACTIVE",
        "threat_modeling": "NATION_STATE"
    },
    "exploitation": {
        "frameworks": [
            "metasploit",
            "empire", 
            "beef",
            "set",
            "sliver",
            "havoc",
            "custom_crypto"
        ],
        "zero_day_exploits": true,
        "crypto_specific": true
    },
    "database": {
        "host": "localhost",
        "port": 5432,
        "name": "unified_cyber_warfare",
        "user": "ucw_user",
        "password": "ucw_secure_pass"
    },
    "security": {
        "authorized_use_only": true,
        "evidence_encryption": true,
        "stealth_required": true,
        "nda_compliance": true
    }
}
EOF
    
    # Create startup script
    cat > start_platform.sh <<EOF
#!/bin/bash

# Unified Cyber Warfare Platform Startup Script
echo "🚀 Starting Unified Cyber Warfare Platform..."

# Activate Python environment
source venv/bin/activate

# Start required services
sudo systemctl start tor
sudo systemctl start postgresql
sudo systemctl start redis

# Initialize Ghost Mode
echo "👻 Initializing Ghost Mode..."
python3 -c "
from ghost_mode import GhostModeEngine
import asyncio
async def init_ghost():
    ghost = GhostModeEngine()
    await ghost.initialize_ghost_mode()
    print('Ghost Mode Ready')
asyncio.run(init_ghost())
" &

# Start the platform
echo "🎯 Launching Unified Interface..."
python3 unified_interface.py --interactive

EOF
    chmod +x start_platform.sh
    
    echo -e "${GREEN}✅ Configuration files created${NC}"
}

# Function to run system tests
run_system_tests() {
    echo -e "${BLUE}🧪 Running system tests...${NC}"
    
    source venv/bin/activate
    
    # Test Python imports
    python3 -c "
import sys
modules = [
    'ghost_mode', 'ai_tactical_operator', 'target_expansion',
    'exploitation_arsenal', 'real_penetration_engine',
    'resource_optimizer', 'unified_interface'
]

failed = []
for module in modules:
    try:
        __import__(module)
        print(f'✅ {module}')
    except ImportError as e:
        print(f'❌ {module}: {e}')
        failed.append(module)

if failed:
    print(f'\\n❌ Failed modules: {failed}')
    sys.exit(1)
else:
    print('\\n🎉 All modules imported successfully!')
"
    
    # Test framework availability
    echo -e "${YELLOW}🔍 Testing framework availability...${NC}"
    
    frameworks=(
        "msfconsole --version"
        "nmap --version"
        "sqlmap --version"
        "hydra -h"
        "john --version"
        "tor --version"
    )
    
    for cmd in "${frameworks[@]}"; do
        if eval "$cmd" >/dev/null 2>&1; then
            echo -e "✅ ${cmd%% *}"
        else
            echo -e "⚠️  ${cmd%% *} (optional)"
        fi
    done
    
    echo -e "${GREEN}✅ System tests completed${NC}"
}

# Function to display final instructions
display_final_instructions() {
    echo
    echo -e "${GREEN}🎉 INSTALLATION COMPLETED SUCCESSFULLY!${NC}"
    echo
    echo -e "${CYAN}📍 Installation Directory: $HOME/unified_cyber_warfare_platform/UNIFIED_CYBER_WARFARE_PLATFORM${NC}"
    echo
    echo -e "${YELLOW}🚀 TO START THE PLATFORM:${NC}"
    echo -e "${WHITE}cd $HOME/unified_cyber_warfare_platform/UNIFIED_CYBER_WARFARE_PLATFORM${NC}"
    echo -e "${WHITE}./start_platform.sh${NC}"
    echo
    echo -e "${YELLOW}🎯 QUICK START COMMANDS:${NC}"
    echo -e "${WHITE}# Interactive mode${NC}"
    echo -e "${WHITE}python3 unified_interface.py --interactive${NC}"
    echo
    echo -e "${WHITE}# Target a specific system${NC}"
    echo -e "${WHITE}python3 unified_interface.py --target example.com --stealth MAXIMUM${NC}"
    echo
    echo -e "${WHITE}# Run real penetration test${NC}"
    echo -e "${WHITE}python3 real_penetration_engine.py${NC}"
    echo
    echo -e "${RED}⚠️  IMPORTANT SECURITY NOTICE:${NC}"
    echo -e "${RED}   This system is for AUTHORIZED PENETRATION TESTING ONLY${NC}"
    echo -e "${RED}   Only use on systems you own or have written permission to test${NC}"
    echo -e "${RED}   Unauthorized use is illegal and unethical${NC}"
    echo
    echo -e "${PURPLE}🛡️  The platform includes:${NC}"
    echo -e "${WHITE}   • Nation-state level penetration capabilities${NC}"
    echo -e "${WHITE}   • Military-grade stealth and anonymity${NC}"
    echo -e "${WHITE}   • AI tactical operator with crypto specialization${NC}"
    echo -e "${WHITE}   • Real system infiltration and fund drainage discovery${NC}"
    echo -e "${WHITE}   • Complete exploitation arsenal integration${NC}"
    echo
    echo -e "${GREEN}Happy ethical hacking! 🎯${NC}"
}

# Main installation process
main() {
    echo -e "${BLUE}🔧 Starting installation process...${NC}"
    
    # Check for required commands
    if ! command_exists git; then
        echo -e "${RED}❌ Git is required but not installed. Please install git first.${NC}"
        exit 1
    fi
    
    if ! command_exists python3; then
        echo -e "${RED}❌ Python 3 is required but not installed. Please install python3 first.${NC}"
        exit 1
    fi
    
    # Run installation steps
    install_system_dependencies
    clone_repository
    setup_python_environment
    install_penetration_frameworks
    configure_tor_proxies
    setup_databases
    create_configuration
    run_system_tests
    display_final_instructions
    
    echo -e "${GREEN}🎉 Installation completed successfully!${NC}"
}

# Run main function
main "$@"