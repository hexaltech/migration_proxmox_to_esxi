# Pour la VM RAW (LVM / block device)

qemu-img convert -p -f raw -O vmdk \
  /dev/pve/votreimagedisqueraw \
  /root/migration/votreimage.vmdk \
  -o subformat=streamOptimized,adapter_type=lsilogic,compat6

#Normaliser le VMDK avec vmkfstools

vmkfstools -i /vmfs/volumes/68d0ed43-b43670e0-fce9-000c297bf606/VM/WINSERVER2025/vm-113-disk-1.vmdk \
-d thin \
/vmfs/volumes/68d0ed43-b43670e0-fce9-000c297bf606/VM/WINSERVER2025/vm-113-disk-1-fixed.vmdk


# Pour la VM QCOW2

qemu-img convert -p -f qcow2 -O vmdk \
  votreimage.qcow2 \
  /root/migration/votreimage.vmdk \
  -o subformat=streamOptimized,adapter_type=lsilogic,compat6

#Normaliser le VMDK avec vmkfstools

vmkfstools -i votreimage.vmdk \
  -d thin \
  vm-100-disk-0-fixed.vmdk
