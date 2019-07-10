#!/bin/bash
################################################################################
# Script for installing Odoo 12 with standardized structure
# Author: Alan Hou
# Website: https://alanhou.org
#-------------------------------------------------------------------------------
# sudo chmod +x odoo-install.sh && bash odoo-install.sh
################################################################################

echo "Please input your project name:"
read -t 30 -p "(Default: projectname):" projectname
if [ -z "${projectname}" ];then
	projectname="projectname"
fi

read -t 30 -p "Please input your Git username(Hit Enter to skip):" git_user
read -t 30 -p "Please input your Git email(Hit Enter to skip):" git_email

# IP_ADDR=`ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"​|head -1`
IP_ADDR=`ip addr | grep 'state UP' -A2 | grep inet|grep -v docker|tail -n1 | awk '{print $2}' | cut -f1  -d'/'`

echo -e "\n---- Update Ubuntu ----"
wget -q -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
sudo apt-get update

echo -e "\n---- Install main dependencies ----"
sudo apt-get install -y git python3.5 postgresql-10 nano \
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


echo -e "\n---- Create Project Directory ----"
mkdir -p ~/odoo-dev/${projectname}
cd ~/odoo-dev/${projectname}

echo -e "\n---- Create standardized directories ----"
virtualenv -p python3 env
mkdir src local bin filestore logs
git clone -b 12.0 --depth 1 --single-branch https://github.com/odoo/odoo.git src/odoo
env/bin/pip3 install -r src/odoo/requirements.txt


echo -e "\n---- Create bin/odoo ----"
cat>bin/odoo<<EOF
#!/bin/sh
ROOT=\$(dirname \$0)/..
PYTHON=\$ROOT/env/bin/python3
ODOO=\$ROOT/src/odoo/odoo-bin
\$PYTHON \$ODOO -c \$ROOT/${projectname}.cfg "\$@"
exit \$?
EOF
chmod +x bin/odoo


echo -e "\n---- Dummy hack ----"
mkdir -p local/dummy
touch local/dummy/__init__.py
echo '{"name": "dummy", "installable": False}' >\
local/dummy/__manifest__.py


echo -e "\n---- Initialize config file ----"
bin/odoo --stop-after-init --save \
 --addons-path src/odoo/odoo/addons,src/odoo/addons,local \
 --data-dir filestore

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
/env/
/src/
/filestore/
/logs/
EOF

if [ -n "${git_user}" ]&&[ -n "${git_email}" ];then
	echo -e "\n---- Configure git & commit ----"
	git config --global user.name "${git_user}"
	git config --global user.email "${git_email}"
	git init
	git add .
	git commit -m "initial version of ${projectname}"
fi


echo "-----------------------------------------------------------"
echo "Done! Use ~/odoo-dev/${projectname}/bin/odoo -d dbname to start Odoo"
echo "To start odoo manually:"
echo "1. Activate virtualenv: source  ~/odoo-dev/${projectname}/env/bin/activate"
echo "2. cd ~/odoo-dev/${projectname}/src/odoo"
echo "3. ./odoo-bin --addons-path=addons,../../local -d test-12 -i account,sale,purchase --log-level=debug"
echo "4. Open your browser and visit http://localhost:8069 or http://${IP_ADDR}:8069"
echo "Default login & password: admin"
echo "Press Ctrl+C to stop odoo"
echo "-----------------------------------------------------------"
