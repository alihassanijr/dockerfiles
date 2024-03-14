#!/bin/bash

service ssh restart

GT_USERNAME=$(cat username)

echo -n "GT VPN Password for ${GT_USERNAME}:"
read -s password

(echo $password; echo "push1"; echo $password; echo "push1") | openconnect \
    --user=$GT_USERNAME \
    https://vpn.gatech.edu \
    --mtu 1200 \
    --base-mtu 1200 \
    --protocol=gp \
    --authgroup="NI Gateway" \
    --passwd-on-stdin
