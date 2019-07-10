# Odoo 12.0 Install Script

This script is based on Chapter 1 of Odoo 12 Development Cookbook Third Edition

## Installation procedure

##### 1. Download the script:
```
wget https://raw.githubusercontent.com/alanhou/odoo12-cookbook/master/Chapter01/odoo-install.sh
```

#### 2. Make the script executable
```
sudo chmod +x odoo-install.sh
```
##### 3. Execute the script:
```
sudo ./odoo-install.sh
```

##### 4. Stop all Odoo proccesses: 
```
ps -ef | grep odoo | awk '{ print $2}' | xargs kill -9
```

##### 5. To restart Odoo with logs enabled:  
```
~/odoo-12.0/bin/python3 ~/odoo-dev/odoo/odoo-bin -d odoo-test
```
