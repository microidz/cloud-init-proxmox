#!/bin/bash

wget https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img
qemu-img convert -f raw -O qcow2 focal-server-cloudimg-amd64.img focal-server-cloudimg-amd64.qcow2
qm create 9000 --memory 2048 --net0 virtio,bridge=vmbr1
qm importdisk 9000 focal-server-cloudimg-amd64.qcow2 local
qm set 9000 --scsihw virtio-scsi-pci --scsi0 local:9000/vm-9000-disk-0.qcow2
qm set 9000 --ide2 local:cloudinit
qm set 9000 --boot c --bootdisk scsi0
# qm set 9000 --serial0 socket --vga serial0
# Keep Default
