# Odoo 12.0 Install Script
#### With standardized structure for production

This script is based on Chapter 2 of Odoo 12 Development Cookbook Third Edition

## Installation procedure

##### 1. Download the script:
```
wget https://raw.githubusercontent.com/alanhou/odoo12-cookbook/master/Chapter02/odoo-install.sh
```

#### 2. Make the script executable & Execute the script:
```
sudo chmod +x odoo-install.sh && bash odoo-install.sh
```

##### 3. Start Odoo(you may need to change projectname & dbname): 
```
~/odoo-dev/projectname/bin/odoo -d dbname start Odoo
```


## Start Odoo manually

##### 1. Activate virtualenv:
```
source  ~/odoo-dev/projectname/env/bin/activate
```

##### 2. Go to the Odoo source directory:
```
cd ~/odoo-dev/${projectname}/src/odoo
```

##### 3. Start odoo:
```
./odoo-bin --addons-path=addons,../../local -d test-12 -i account,sale,purchase --log-level=debug"
```