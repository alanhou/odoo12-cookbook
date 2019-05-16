# Odoo 12.0 Install Script for production use

This script is based on Chapter 3 of Odoo 12 Development Cookbook Third Edition

## Installation procedure

##### 1. Download the script:
```
wget https://raw.githubusercontent.com/alanhou/odoo12-cookbook/master/Chapter03/odoo-install.sh
```

#### 2. Make the script executable & Execute the script:
```
sudo chmod +x odoo-install.sh && bash odoo-install.sh
```

#### 3. Run your odoo instance:
```
sudo su - odoo
~/odoo-prod/project/bin/start-odoo
```