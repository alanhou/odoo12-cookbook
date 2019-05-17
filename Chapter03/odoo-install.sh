#!/bin/bash
################################################################################
# Script for installing Odoo 12 for production use
# Author: Alan Hou
# Website: https://alanhou.org
#-------------------------------------------------------------------------------
# sudo chmod +x odoo-install.sh && bash odoo-install.sh
################################################################################

# IP_ADDR=`ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"​|head -1`
IP_ADDR=`ip addr | grep 'state UP' -A2 | grep inet|grep -v docker|tail -n1 | awk '{print $2}' | cut -f1  -d'/'`

echo -e "\n---- Install dependencies ----"
sudo apt-get update
sudo apt-get install -y git python3.5 postgresql nano virtualenv \
 gcc python3.5-dev libxml2-dev libxslt1-dev \
 libevent-dev libsasl2-dev libldap2-dev libpq-dev \
 libpng-dev libjpeg-dev \
 xfonts-75dpi xfonts-base wget xz-utils


echo -e "\n---- Install wkhtmltopdf ----"
wget "https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.xenial_amd64.deb" -O /tmp/wkhtml.deb
sudo dpkg -i /tmp/wkhtml.deb
sudo apt-get -fy install

echo -e "\n---- Database related settings ----"
# sudo adduser odoo
groupadd odoo
sudo useradd -m odoo -g odoo
sudo -u postgres createuser odoo
sudo -u postgres createdb -O odoo odoo_project

echo -e "\n---- Set up project files ----"
sudo su - odoo <<EOFOUT
mkdir ~/odoo-prod
cd ~/odoo-prod
mkdir -p project/src
cd project/src
git clone -b 12.0 --depth 1 --single-branch https://github.com/odoo/odoo.git odoo

echo -e "\n---- virtualenv ----"
virtualenv -p python3 ~/env-odoo-12.0
# source ~/env-odoo-12.0/bin/activate
~/env-odoo-12.0/bin/pip3 install -r odoo/requirements.txt
git clone -b 12.0 https://github.com/OCA/partner-contact.git

mkdir ~/odoo-prod/project/bin

cat>~/odoo-prod/project/bin/start-odoo<<'EOF'
#!/bin/sh
PYTHON=~/env-odoo-12.0/bin/python3
ODOO=~/odoo-prod/project/src/odoo/odoo-bin
CONF=~/odoo-prod/project/production.conf
\${PYTHON} \${ODOO} -c \${CONF} "\$@"
EOF

chmod +x ~/odoo-prod/project/bin/start-odoo
cd ~/odoo-prod/project/
mkdir local-addons filestore logs
echo -e "\n---- Dummy hack ----"
mkdir -p local-addons/dummy
touch local-addons/dummy/__init__.py
echo '{"name": "dummy", "installable": False}' >\
local/dummy/__manifest__.py

echo -e "\n---- Add .gitignore ----"
cat>.gitignore<<EOF
# dotfiles, with exceptions:
.*
!.gitignore
# python compiled files
*.py[co]
# emacs backup files
*~
# not tracked subdirectories
/src/
/filestore/
/logs/
EOF
EOFOUT

sudo apt-get remove gcc -y


echo "-----------------------------------------------------------"
echo "Done!"
echo "To start odoo:"
echo "1. Switch User: sudo su - odoo"
echo "2. Activate virtualenv: source env-odoo-12.0/bin/activate"
echo "3. Initialize: ~/odoo-prod/project/bin/start-odoo -d odoo_project --save -i base --stop-after-init"
echo "4. Run your odoo instance: ~/odoo-prod/project/bin/start-odoo"
echo "4. Open your browser and visit http://localhost:8069 or http://${IP_ADDR}:8069"
echo "Default login & password: admin"
echo "Press Ctrl+C to stop odoo"
echo "-----------------------------------------------------------"