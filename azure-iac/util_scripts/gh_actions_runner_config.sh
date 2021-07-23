# To be run from the agent: 
# chmod +x gh_linux_runner.sh
# gh_linux_runner.sh <token>

# Create a folder
mkdir actions-runner && cd actions-runner

# Download the latest runner package
curl -o actions-runner-linux-x64-2.278.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.278.0/actions-runner-linux-x64-2.278.0.tar.gz

# Extract the installer
tar xzf ./actions-runner-linux-x64-2.278.0.tar.gz

./config.sh --url https://github.com/suren-m/devops --token $1

./run.sh