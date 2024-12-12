#!/bin/bash
echo ===========================================================================
echo BEGIN FILE: openhw_products.sh
echo -e "===========================================================================\n"

ipgrid_server=localhost
ipgrid_port=4000

admin_user=ipgrid_admin
admin_pwd=ipgrid_pwd

integ_user=james.wilson@ipgrid.com
integ_pwd=james1234

# login as admin to create the company
#ipg auth login --host ${ipgrid_server} --port ${ipgrid_port} \
#        --login ${admin_user} --password ${admin_pwd}

# setup openhw company
#ipgrid-admin --config ${config_app_rootdir}/config.yaml company create --name openhw --legal-name "OpenHardware" \
#	--email info@openhw.com --url "http://www.openhw.com"

# login as James Wilson to do the openhw products
ipg auth login --host ${ipgrid_server} --port ${ipgrid_port} \
        --login ${integ_user} --password ${integ_pwd}

rm -rf */.ipg

# define the products to be initialized: (name, release, company)
openhwdirs=(
    'asiclib|1.2.0|Low-level ASIC Cell Library'
    'axi|2.4.1|AXI Master and Slave Interface'
    'edma|2.2.1|Lightweight DMA Engine'
    'emmu|1.4.1|Memory translation unit'
    'gpio|0.4.2|General Purpose Software Priogrammable IO'
    'spi|3.1.5|Serial Peripheral Interface'
    'stdlib|1.1.1|Vectorized Standard Cell Building Blocks'
)

# copy the products to the testbench
TOP=$(pwd)

saveIFS="$IFS"
for entry in "${openhwdirs[@]}"; do
    IFS='|' read -r name release descr <<< "$entry"
    cd ${TOP}

    echo "Initializing product: $name"
    cd $name

    ipg prod init --company openhw --product $name --description "$descr" --type soft_ip --package-sources

    # add some patterns to the ipgignore file
    echo -e ".git\n.gitignore\n.ipg\n.ipgignore\n" > .ipgignore

    # add and commit the product to ipgrid
    ipg prod add .
    ipg prod commit --release $release --quiet


done
IFS="$saveIFS"


cd ${TOP}

