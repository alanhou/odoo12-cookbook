#!/bin/bash
################################################################################
# Script for installing Odoo 12 on Ubuntu & Debian
# Author: Alan Hou
# Website: https://alanhou.org
#-------------------------------------------------------------------------------
# sudo chmod +x odoo-install.sh
# ./odoo-install
################################################################################

echo -e "\n---- Update Ubuntu ----"
sudo apt-get update

echo -e "\n---- Install main dependencies ----"
sudo apt-get install -y git python3.5 postgresql nano \
virtualenv xz-utils wget fontconfig libfreetype6 libx11-6 \
libxext6 libxrender1 xfonts-75dpi

echo -e "\n---- Install wkhtmltopdf ----"
wget "https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.xenial_amd64.deb" -O /tmp/wkhtml.deb
sudo dpkg -i /tmp/wkhtml.deb
sudo apt-get -fy install

echo -e "\n---- Install build dependencies ----"
sudo apt-get install -y gcc python3.5-dev libxml2-dev \
libxslt1-dev libevent-dev libsasl2-dev libssl1.0-dev libldap2-dev \
libpq-dev libpng-dev libjpeg-dev

echo -e "\n---- Configure PostgreSQL ----"
sudo -u postgres createuser --createdb $(whoami)
createdb $(whoami)

# echo -e "\n---- Configure git ----"
# git config --global user.name "Your Name"
# git config --global user.email youremail@example.com

echo -e "\n---- Clone the Odoo code base ----"
mkdir ~/odoo-dev
cd ~/odoo-dev
git clone -b 12.0 --depth 1 --single-branch https://github.com/odoo/odoo.git
cd odoo

echo -e "\n---- Create virtualenv ----"
virtualenv -p python3 ~/odoo-12.0
source ~/odoo-12.0/bin/activate

echo -e "\n---- Install Python dependencies  ----"
pip3 install -r requirements.txt

echo -e "\n---- Start Odoo instance  ----"
createdb odoo-test
python3 odoo-bin -d odoo-test --addons-path=addons \
--db-filter=odoo-test$

echo "-----------------------------------------------------------"
echo "Done! Open your browser and visit http://localhost:8069"
echo "Default login & password: admin"
echo "-----------------------------------------------------------"