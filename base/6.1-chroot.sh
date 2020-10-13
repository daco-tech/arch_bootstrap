

# Configure Grub Boot
printinfo "\n"
printinfo "Installing and configuring GRUB"
grub-install --target=x86_64-efi --efi-directory="/boot/efi" --bootloader-id=arch_grub --recheck && sync
cp /etc/default/grub /etc/default/grub.backup
sed -i 's#[[DISK_UUID]]#'"$(lsblk -no UUID [[DEVICE]])"'#g' /tmp/chroot/sysfiles/grub
cat /tmp/chroot/sysfiles/grub
cp /tmp/chroot/sysfiles/grub
chmod u=rw,g=r,o=r /etc/default/grub

mkdir -p /tmp/
curl "https://github.com/daco-tech/poly-dark/archive/master.zip" -L -o /tmp/polydark.zip
unzip /tmp/polydark.zip -d /tmp
rm /tmp/poly-dark-master/install.sh
mv /tmp/poly-dark-master /boot/grub/themes/polydark

grub-mkconfig -o /boot/grub/grub.cfg

# Recreate InitRam
mkinitcpio -p linux