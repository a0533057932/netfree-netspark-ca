# WSA_Netfree_CA_Add
adds netfree CAs to windows subsystem for android

### Download msixbundle (~1.2GB)

Use this [link](https://store.rg-adguard.net/) to download the msixbundle with the settings ProductId: 9P3395VX91NR, Ring: SLOW

### Install WSL2

Ubuntu is used in this guide, but any other distro will work for this just fine.

(We are assuming that you are using the exact terminal, and you are also continuing this from where the last command has been left off)


### Extract msixbundle

Download 7zip or a similar archival program and open the recently downloaded msixbundle. Find the msix file inside the msixbundle relating to your architecture and extract that to a folder.
Delete the files appxblockmap, appxsignature and \[content_types\] along with the folder appxmetadata.

### Clone this repo and populate the directories

For Ubuntu

```bash
git clone https://github.com/Sivan22/WSA_Netfree_CA_Add
cd WSAGAScript/\#IMAGES
mv /mnt/path-to-extracted-msix/*.img .
```

paths in wsl follow the same as windows after /mnt/ its just the drive letter then folder structure as normal. For example /mnt/c/users would be the c:\users folder

### Edit scripts

Set scripts to unix format
```bash
cd ..
dos2unix extend_and_mount_images.sh
dos2unix apply_certs.sh
dos2unix unmount_images.sh
```


```bash
cd ..
chmod +x extend_and_mount_images.sh
chmod +x apply_certs.sh
chmod +x unmount_images.sh
```

Set executable permission for the scripts

```bash
cd ..
chmod +x extend_and_mount_images.sh
chmod +x apply_certs.sh
chmod +x unmount_images.sh
```

### Run the scripts

make sure you're in the same directory as the scripts before running, then run:

```bash
sudo ./extend_and_mount_images.sh
sudo ./apply_certs.sh
sudo ./unmount_images.sh
```

### Copy the edited images

```bash
cd \#IMAGES
cp *.img /mnt/path-to-extracted-msix/
```

### Register the edited WSA

- Enable developer mode in windows settings.
- Uninstall any other installed versions of WSA
- Open powershell as admin and run `Add-AppxPackage -Register path-to-extracted-msix\AppxManifest.xml`

WSA will install with netfree CAs
