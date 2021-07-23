# For ubuntu 20.04 and above

sudo apt update -y && sudo apt upgrade -y

# Install ansible and python-deps
sudo apt install -y wget git ansible python3-pip python-apt

# Install Azurerm plugin
pip3 install ansible[azure]

# Configure SP and credentials
# az account show to see subscription and tenantid

# make sure to not have quotes for the values
mkdir -p ~/.azure && echo "[default] 
subscription_id=sub_id 
client_id=sp_client_id 
secret=sp_secret 
tenant=tenant_id" > ~/.azure/credentials

# Ensure the agent has access to install tools on linux and windows hosts
# via ssh, basic_auth, kerberos, etc.