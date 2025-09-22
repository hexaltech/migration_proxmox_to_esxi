# Migration Proxmox vers VMware ESXi 8.0

Ce guide explique comment migrer une machine virtuelle depuis **Proxmox** (format RAW ou QCOW2) vers **VMware ESXi** en utilisant `qemu-img` et `vmkfstools`.

---

## 🔹 Migration d’une VM RAW (LVM / block device)

```bash
qemu-img convert -p -f raw -O vmdk   /dev/pve/votreimagedisqueraw   /root/migration/votreimage.vmdk   -o subformat=streamOptimized,adapter_type=lsilogic,compat6
```

### Normalisation du VMDK avec `vmkfstools`
```bash
vmkfstools -i /vmfs/volumes/68d0ed43-b43670e0-fce9-000c297bf606/VM/WINSERVER2025/vm-113-disk-1.vmdk   -d thin   /vmfs/volumes/68d0ed43-b43670e0-fce9-000c297bf606/VM/WINSERVER2025/vm-113-disk-1-fixed.vmdk
```

---

## 🔹 Migration d’une VM QCOW2

```bash
qemu-img convert -p -f qcow2 -O vmdk   votreimage.qcow2   /root/migration/votreimage.vmdk   -o subformat=streamOptimized,adapter_type=lsilogic,compat6
```

### Normalisation du VMDK avec `vmkfstools`
```bash
vmkfstools -i votreimage.vmdk   -d thin   vm-100-disk-0-fixed.vmdk
```

---

## 📌 Notes
- Vérifiez que la VM est **éteinte** avant d’exporter le disque.  
- Utilisez `scp` ou `rsync` pour transférer vos fichiers `.vmdk` vers le datastore ESXi.  
- Lors de la création de la VM sur ESXi, configurez le **contrôleur SCSI (LSI Logic SAS)**.  

---

✦ Auteur : [Hexaltech](https://github.com/hexaltech)  
✦ Repo : [migration_proxmox_to_esxi](https://github.com/hexaltech/migration_proxmox_to_esxi/)
