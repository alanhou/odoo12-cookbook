#!/bin/bash
#!/bin/bash
################################################################################
# Script for installing Odoo 13 with standardized structure
# Author: Alan Hou
# Website: https://alanhou.org
#-------------------------------------------------------------------------------
# sudo chmod +x odoo-structure.sh && bash odoo-structure.sh


install_dependencies(){
  echo -e "\n---- Installing dependencies----"
  cd ~/odoo-dev/${projectname}
  source env/bin/activate
  sudo apt-get update -y
  sudo apt install git python3-pip build-essential wget python3-dev python3-venv \
  python3-wheel libxslt-dev libzip-dev libldap2-dev libsasl2-dev python3-setuptools
  
  echo -e "\n---- Installing wkhtmltopdf----"
  wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.bionic_amd64.deb
  sudo dpkg -i wkhtmltox_0.12.5-1.bionic_amd64.deb
  sudo apt-get install -f
  rm -f wkhtmltox_0.12.5-1.bionic_amd64.deb

  echo -e "\n---- Installing PostgreSQL----"
  sudo apt install postgresql -y
  sudo -u postgres createuser --superuser $(whoami)
  pip3 install psycopg2-binary
  pip3 install -r src/odoo/requirements.txt


  echo "Please input your db name:"
  read -t 30 -p "(Default: odoo-test):" odoodb
  if [ -z "${odoodb}" ];then
    odoodb="odoo-test"
  fi

  createdb ${odoodb}

  echo -e "\n---- Initialize config file ----"
  bin/odoo --stop-after-init --save -d ${odoodb} -i base --addons-path src/odoo/odoo/addons,src/odoo/addons,local --data-dir filestore


  IP_ADDR=`ip addr | grep 'state UP' -A2 | grep inet|grep -v docker|tail -n1 | awk '{print $2}' | cut -f1  -d'/'`

  echo "-----------------------------------------------------------"
  echo "Done! Activate your virtualenv & use ~/odoo-dev/${projectname}/bin/odoo -c ~/odoo-dev/${projectname}/${projectname}.cfg to start Odoo"
  echo "To start odoo manually:"
  echo "1. Activate virtualenv: source  ~/odoo-dev/${projectname}/env/bin/activate"
  echo "2. cd ~/odoo-dev/${projectname}/src/odoo"
  echo "3. ./odoo-bin --addons-path=addons,../../local -d ${odoodb} -i account,sale,purchase --log-level=debug"
  echo "4. Open your browser and visit http://localhost:8069 or http://${IP_ADDR}:8069"
  echo "Default login & password: admin"
  echo "Press Ctrl+C to stop odoo"
  echo "-----------------------------------------------------------"
}





echo "Please input your project name:"
read -t 30 -p "(Default: projectname):" projectname
if [ -z "${projectname}" ];then
  projectname="projectname"
fi

echo -e "\n---- Creating standardized directories ----"


mkdir -p ~/odoo-dev/${projectname}
cd ~/odoo-dev/${projectname}
python3 -m venv env
mkdir src local bin filestore logs
git clone -b 13.0 --single-branch --depth 1 https://github.com/odoo/odoo.git src/odoo


echo -e "\n---- Creating bin/odoo ----"
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


echo -e "\n---- Creating .gitignore ----"

cat > .gitignore<<EOF
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

echo -e "\n---- Odoo standardized structure completed ----"



while true; do
    read -p "Do you wish to install install_dependencies?" yn
    case $yn in
        [Yy]* ) install_dependencies; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done