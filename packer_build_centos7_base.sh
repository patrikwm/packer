#!/bin/bash

# Exit on errors
set -e

# Load settings
echo "Loading settings.cfg"
source ./settings.cfg

echo "Building centos7 vm and uploading it to vcenter"
packer build \
    -var vm_name=$VM_NAME \
    -var vmware_user=$VI_USER \
    -var vmware_password=$VI_PASSWORD \
    -var vmware_host=$VI_SERVER \
    packer/vsphere/centos7.1/base.json
