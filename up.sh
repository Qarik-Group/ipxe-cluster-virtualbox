#!/bin/bash

[[ -f ipxe.iso ]] || { wget -c https://boot.ipxe.org/ipxe.iso; }

count=${1-1}

for i in $(seq 1 ${count}); do
    name=node-z${i}
    disk="$HOME/VirtualBox VMs/${name}/${name}.vdi"
    VBoxManage createvm --name ${name} \
               --ostype Linux_64 --register
    VBoxManage modifyvm ${name} \
               --memory 2056 \
               --nic1 bridged --nictype1 82545EM \
               --bridgeadapter1 'en0: Wi-Fi (AirPort)' \
               --boot1 dvd --boot2 disk --boot3 none --boot4 none \
               --acpi off
    VBoxManage createmedium disk \
               --filename "${disk}" --size 10000 --format VDI
    VBoxManage storagectl ${name} \
               --name "SATA Controller" \
               --add sata --controller IntelAhci
    VBoxManage storageattach ${name} \
               --storagectl "SATA Controller" --port 0 --device 0 \
               --type hdd --medium "${disk}"
    VBoxManage storagectl ${name} \
               --name IDE --add ide
    VBoxManage storageattach ${name} \
               --storagectl IDE --port 0 --device 0 \
               --type dvddrive --medium $(pwd)/ipxe.iso
    VBoxManage startvm ${name}
done
