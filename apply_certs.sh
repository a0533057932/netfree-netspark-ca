#!/bin/bash

. ./VARIABLES.sh




echo "copying CAerts"
cp  $CertsDir/*   $InstallDir/etc/security/cacerts 

echo "Applying root file ownership"
find  $InstallDir/etc/security/cacerts -exec chown root:root {} &>/dev/null \;

echo "Setting directory permissions"
find $InstallDir/etc/security/cacerts -type d -exec chmod 755 {} \;


echo "Setting file permissions"
find  $InstallDir/etc/security/cacerts -type f -exec chmod 644 {} \;

echo "Applying SELinux security contexts to directories"
find  $InstallDir/etc/security/cacerts -type d -exec chcon --reference=$InstallDir/etc/fs_config_dirs {} \;

echo "Applying SELinux security contexts to files"
find  $InstallDir/etc/security/cacerts -type f -exec chcon --reference=$InstallDir/etc/fs_config_dirs {} \;

echo "Applying SELinux policy"
# Sed will remove the SELinux policy for plat_sepolicy.cil, preserve policy using cp
cp $InstallDir/etc/selinux/plat_sepolicy.cil $InstallDir/etc/selinux/plat_sepolicy_new.cil
sed -i 's/(allow gmscore_app self (process (ptrace)))/(allow gmscore_app self (process (ptrace)))\n(allow gmscore_app self (vsock_socket (read write create connect)))\n(allow gmscore_app device_config_runtime_native_boot_prop (file (read)))/g' $InstallDir/etc/selinux/plat_sepolicy_new.cil
cp $InstallDir/etc/selinux/plat_sepolicy_new.cil $InstallDir/etc/selinux/plat_sepolicy.cil
rm $InstallDir/etc/selinux/plat_sepolicy_new.cil

# Prevent android from using cached SELinux policy
echo '0000000000000000000000000000000000000000000000000000000000000000' > $InstallDir/etc/selinux/plat_sepolicy_and_mapping.sha256

echo "!! Apply completed !!"
