===============================
Box-Internet-Debout
===============================



![Box Internet Debout](/box-internet-debout.png)


## I - Présentation

Vous pouvez trouver la présentation du projet sur la page wiki de Nuit Debout:

https://wiki.nuitdebout.fr/wiki/Box_Internet_Debout


Discussions/Questions/Aide/Equipe Dev:

https://chat.nuitdebout.fr/channel/dev-mesh-network

## II - Installation

Support matériel nécessaire: Raspberry pi 2

Deux solutions sont possibles pour l'installation, la plus simple est de télécharger l'image déjà construite et de la flasher sur la carte SD qui sera utilisée avec les raspberry.

La 2ème solution est de construire l'image soit-même en suivant les étapes décrites plus bas.

#####  A) En téléchargant directement l'image déjà construite

```
# Télécharger et extraire l'image compréssée d'OpenWRT
git clone https://github.com/dlf2042/Box-Internet-Debout
cd Box-Internet-Debout
gunzip -d openwrt-brcm2708-bcm2709-sdcard-vfat-ext4.img.gz
```


```
# Flasher sur une carte SD l'image extraite
dd if=openwrt-brcm2708-bcm2709-sdcard-vfat-ext4.img of=/dev/sdX # Remplacer X par la lettre correspondante
```

#####  B) Construire l'image soit-même

```
# Faites toutes ces instructions en mode utilisateur et PAS EN MODE ROOT
```


```
# Installer les dépendances
# https://wiki.openwrt.org/doc/howto/buildroot.exigence
```


```
# Cloner le git 
git clone git://git.openwrt.org/15.05/openwrt.git
git clone git.github.com/dlf2042/mptcp_openwrt
```


```
# Télécharger le patch MPTCP pour le kernel 3.18
wget http://multipath-tcp.org/patches/mptcp-v3.18.26-0411d31b5311.patch
cp mptcp-v3.18.26-0411d31b5311.patch target/linux/generic/patches-3.18/622-mptcp_linux_kernel.patch
```


```
# Ajouter les scripts pour MPTCP
cp -R mptcp_openwrt/package openwrt/
```


```
# Entrez dans le dossier Openwrt et préparez la compilation
cd openwrt

./scripts/feeds update -a
./scripts/feeds install -a
```


```
# La configuration se fait en mode graphique
make ARCH=arm menuconfig
```


```
menuconfig:
---------------------------
Target system > broadcom BCM2708/BCM2709:
---Select: Subtarget: BCM2709
Kernel Modules > Wireless Drivers:
---Select: rtl8187
Network > VPN:
---Select: openvpn-easy-rsa
---Select: openvpn-nossl
---Select: openvpn-openssl
Network:
---Select: mptcp
---Select: wpad-mini
---Select: wwan
Luci > Applications:
---Select: mwan3
---------------------------
```


```
# La configuration se fait en mode graphique
make ARCH=arm kernel_menuconfig

---------------------------
System type:
-----Select: BCM2709
Networking Support > Networking options:
---Select: IPv6:
-----Select: Multiple Routing Tables
---Select: MPTCP protocol
# A partir de la beaucoup de choix sont possibles, la configuration actuellement testée est:
# Advanced path-manager control: Full mesh
# Advanced Scheduler control: Default
# Advanced congestion control: lia
-----Select: MPTCP: advanced path-manager control
-----Select: MPTCP: advanced scheduler control
---Select: TCP: advanced congestion control
---------------------------
```


```
# ajoutez 2 nouveaux chemins à la variable PATH
PATH=openwrt/staging_dir/host/bin:openwrt/staging_dir/toolchain-arm_cortex-a7+vfp_gcc-4.8-linaro_uClibc-0.9.33.2_eabi/bin:$PATH
```


```
# Compilez
make ARCH=arm
```


```
# Les images et archives se trouvent dans le dossier bin
ls bin/brcm2708/
```


```
# Flashez l'image obtenue sur votre carte SD
# sudo fdisk -l (pour trouver la lettre correspondante)
```


```
sudo dd if= bin/brcm2708/openwrt-brcm2708-bcm2709-sdcard-vfat-ext4.img of=/dev/sdX # remplacez sdX par la lettre correspondante
```


## III - Travaux en cours

Configuration du réseau (interfaces, routage, firewall, etc...) en utilisant mwan3:

https://wiki.openwrt.org/doc/howto/mwan3



Configuration OpenVPN:

https://openvpn.net/index.php/open-source/documentation.html


Ressources utiles:

https://wiki.openwrt.org/doc/howto/start

