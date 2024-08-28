

# Update the package list
sudo apt-get update

# Install unzip and curl if not already installed
sudo apt-get install -y unzip curl

# Download the AWS CLI zip file
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

# Unzip the installer
unzip awscliv2.zip

# Run the installer
sudo ./aws/install

# Verify installation
aws --version