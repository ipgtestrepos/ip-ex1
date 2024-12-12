#!/bin/bash
echo ===========================================================================
echo BEGIN FILE: openhw_products_v2.0.sh
echo -e "===========================================================================\n"

# update revisions

ipgrid_server=localhost
ipgrid_port=4000

integ_user=james.wilson@ipgrid.com
integ_pwd=james1234

# login as James Wilson to do the openhw products
ipg auth login --host ${ipgrid_server} --port ${ipgrid_port} --login ${integ_user} --password ${integ_pwd}

# define the products to be initialized: (name, release, company)
openhwdirs=(
    'asiclib|1.3.0|Maintenance update'
    'axi|2.6.0|Maintenance update'
    'edma|2.4.0|Maintenance update'
    'emmu|1.5.5|Maintenance update'
    'gpio|1.0.4|Maintenance update'
    'spi|3.2.2|Maintenance update'
    'stdlib|1.2.2|Maintenance update'
)

git checkout v2.0

# copy the products to the testbench
TOP=$(pwd)

saveIFS="$IFS"
for entry in "${openhwdirs[@]}"; do
    IFS='|' read -r name release descr <<< "$entry"
    cd ${TOP}
    cd $name

    ipg prod checkout openhw/$name --index-only --destination .

    # add and commit the product to ipgrid
    ipg prod add .
    ipg prod commit --release $release --description $descr --quiet
done
IFS="$saveIFS"


cd ${TOP}

