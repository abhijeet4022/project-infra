echo -e "\e[1;36mTerraform Installation.\e[0m"

echo -e "\e[32mSetup The Terraform Repository.\e[0m"
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo

echo -e "\e[32mInstall Terraform.\e[0m"
sudo yum -y install terraform

if [ $? -eq 0 ]; then
  echo -e "\e[1;32mInstallation Completed.\e[0m"
else
  echo -e "\e[1;31mInstallation Failed.\e[0m"
fi