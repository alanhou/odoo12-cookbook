#!/bin/bash
################################################################################
# Script for installing Odoo 12 on Ubuntu & Debian
# Author: Alan Hou
# Website: https://alanhou.org
#-------------------------------------------------------------------------------
# sudo chmod +x odoo-install.sh
# ./odoo-install.sh
################################################################################

IP_ADDR=`ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"​|head -1`

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
libxslt1-dev libevent-dev libsasl2-dev libssl-dev libldap2-dev \
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
# source ~/odoo-12.0/bin/activate

echo -e "\n---- Install Python dependencies  ----"
~/odoo-12.0/bin/pip3 install -r requirements.txt

echo -e "\n---- Start Odoo instance  ----"
cd ~/odoo-dev/odoo/
nohup ~/odoo-12.0/bin/python3 ~/odoo-dev/odoo/odoo-bin -d odoo-test --addons-path=~/odoo-dev/odoo/addons \
--db-filter=odoo-test$ -i base >/dev/null 2>&1 &

echo "-----------------------------------------------------------"
echo "Done! Open your browser and visit http://localhost:8069 or http://${IP_ADDR}:8069"
echo "Default login & password: admin"
echo "Stop all Odoo proccesses: ps -ef | grep odoo | awk '{ print $2}' | xargs kill -9"
echo "To restart Odoo with logs enabled:  ~/odoo-12.0/bin/python3 ~/odoo-dev/odoo/odoo-bin -d odoo-test"
echo "-----------------------------------------------------------"