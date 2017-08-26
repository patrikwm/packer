#!/usr/bin/env bash
set -x
 
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
yum -y update
yum -y install net-tools vim tcpdump curl
#yum -y install gcc make gcc-c++ kernel-devel-`uname -r` perl