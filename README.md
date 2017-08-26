# Packer Server Build

This project builds virtual machine with packer and uploads it to vsphere vcenter.

## Getting Started

Packer is using vmware to create a base box that is uploaded to vsphere.
settings.cfg contains variables used by packer.
PowerCLI is used to convert uploaded VM to template.

### Prerequisites

[VMware Fusion](http://www.vmware.com/products/fusion.html) - VMWare Fusion is used to build the machines.

[Hashicorp - Packer](https://www.packer.io/) - Packer <1.0 for running the build process and automated installation.

[Docker](https://www.docker.com) - Docker to run PowerCLI shell

[Dockerhub - PowerCLI](https://hub.docker.com/r/vmware/powerclicore/) - PowerCLI

ISO files for each operating system that you want to install.
- [CENTos7](https://www.centos.org/download/)
- [Ubuntu](https://www.ubuntu.com/)
- [Windows Server](https://www.visualstudio.com/)


## Running the script

Install all prerequisites. Then run either of the build scripts

```
./packer_build_centos7_base.sh
```

Convert machines to templates. This requires that settings.cfg is loaded

```
source ./settings.cfg

docker run --rm -i -v $(pwd):/packer \
  --entrypoint='/usr/bin/powershell' \
  vmware/powerclicore \
  /packer/packer/scripts/powercli_convert_to_template.ps1 \
  -VM_NAME $VM_NAME \
  -VSPHERE_SERVER $VSPHERE_SERVER \
  -VSPHERE_PASSWORD $VSPHERE_PASSWORD \
  -VSPHERE_USER $VSPHERE_USER
```

## Authors

* **Patrik W Martin** - *Initial work* - [PatrikWM](https://github.com/patrikwm)

## Acknowledgments

* https://github.com/sotayamashita/packer-example
