# PRE-CONFIGURED IMAGES COMING SOON

# BUILD
# Build instructions

# Download Raspbian Jessie
wget https://downloads.raspberrypi.org/raspbian_lite_latest

# Flash Raspbian on SD Card (replace sdX with your device | ex: dd if=*.img of=/dev/sdb)
unzip raspbian_lite_latest
dd if=*.img of=/dev/sdX

# Custom kernel build
# more infos: https://www.raspberrypi.org/documentation/linux/kernel/building.md

# Need raspbian gcc compiler from raspberry tools
git clone https://github.com/raspberrypi/tools

# Download kernel builder with MPTCP patched kernel for rpi
git clone http://github.com/richardwithnell/mptcp-rpi

# Forked and adapted from https://gist.github.com/RichardWithnell/50a505b9104fb4c425d1
# and https://www.raspberrypi.org/documentation/linux/kernel/building.md

make mrproper

# 32 Bit
# export CCPREFIX=/home/user/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin/arm-linux-gnueabihf- 
# 64 Bit
export CCPREFIX=/home/user/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin/arm-linux-gnueabihf-
make ARCH=arm CROSS_COMPILE=$CCPREFIX bcm2709_defconfig
make ARCH=arm CROSS_COMPILE=$CCPREFIX menuconfig

# MENUCONFIG STEPS
# select Networking support --> Networking Options --> MPTCP protocol
# select MPTCP: advanced path-manager control ---> MPTCP Full-Mesh Path-Manager
# select MPTCP: advanced path-manager control ---> Default MPTCP Path-Manager ---> Full mesh
# select MPTCP: advanced scheduler control
# save and exit

# Compile kernel
make ARCH=arm CROSS_COMPILE=$CCPREFIX 

# Mount Raspbian SD Card
mkdir -p mnt/fat32
mkdir -p mnt/ext4
sudo mount /dev/sdX1 mnt/fat32
sudo mount /dev/sdX2 mnt/ext4

# Load modules into Raspbian
make ARCH=arm CROSS_COMPILE=$CCPREFIX  INSTALL_MOD_PATH=mnt/ext4 modules
sudo make ARCH=arm CROSS_COMPILE=$CCPREFIX  INSTALL_MOD_PATH=mnt/ext4 modules_install

# Load the kernel into Raspbian
sudo cp mnt/fat32/$KERNEL.img mnt/fat32/$KERNEL-backup.img
sudo scripts/mkknlimg arch/arm/boot/zImage mnt/fat32/$KERNEL.img
sudo cp arch/arm/boot/dts/*.dtb mnt/fat32/
sudo cp arch/arm/boot/dts/overlays/*.dtb* mnt/fat32/overlays/
sudo cp arch/arm/boot/dts/overlays/README mnt/fat32/overlays/
sudo umount mnt/fat32
sudo umount mnt/ext4

# Plug the SD Card into Raspberry pi 2
 instructions_build_rpi2_mptcp.sh

# PRE-CONFIGURED IMAGES COMING SOON

# BUILD
# Build instructions

# Download Raspbian Jessie
wget https://downloads.raspberrypi.org/raspbian_lite_latest

# Flash Raspbian on SD Card (replace sdX with your device | ex: dd if=*.img of=/dev/sdb)
unzip raspbian_lite_latest
dd if=*.img of=/dev/sdX

# Custom kernel build
# more infos: https://www.raspberrypi.org/documentation/linux/kernel/building.md

# Need raspbian gcc compiler from raspberry tools
git clone https://github.com/raspberrypi/tools

# Download kernel builder with MPTCP patched kernel for rpi
git clone http://github.com/richardwithnell/mptcp-rpi

# Forked and adapted from https://gist.github.com/RichardWithnell/50a505b9104fb4c425d1
# and https://www.raspberrypi.org/documentation/linux/kernel/building.md

make mrproper

# 32 Bit
# export CCPREFIX=/home/user/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin/arm-linux-gnueabihf- 
# 64 Bit
export CCPREFIX=/home/user/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin/arm-linux-gnueabihf-
make ARCH=arm CROSS_COMPILE=$CCPREFIX bcm2709_defconfig
make ARCH=arm CROSS_COMPILE=$CCPREFIX menuconfig

# MENUCONFIG STEPS
# select Networking support --> Networking Options --> MPTCP protocol
# select MPTCP: advanced path-manager control ---> MPTCP Full-Mesh Path-Manager
# select MPTCP: advanced path-manager control ---> Default MPTCP Path-Manager ---> Full mesh
# select MPTCP: advanced scheduler control
# save and exit

# Compile kernel
make ARCH=arm CROSS_COMPILE=$CCPREFIX 

# Mount Raspbian SD Card
mkdir -p mnt/fat32
mkdir -p mnt/ext4
sudo mount /dev/sdX1 mnt/fat32
sudo mount /dev/sdX2 mnt/ext4

# Load modules into Raspbian
make ARCH=arm CROSS_COMPILE=$CCPREFIX  INSTALL_MOD_PATH=mnt/ext4 modules
sudo make ARCH=arm CROSS_COMPILE=$CCPREFIX  INSTALL_MOD_PATH=mnt/ext4 modules_install

# Load the kernel into Raspbian
sudo cp mnt/fat32/$KERNEL.img mnt/fat32/$KERNEL-backup.img
sudo scripts/mkknlimg arch/arm/boot/zImage mnt/fat32/$KERNEL.img
sudo cp arch/arm/boot/dts/*.dtb mnt/fat32/
sudo cp arch/arm/boot/dts/overlays/*.dtb* mnt/fat32/overlays/
sudo cp arch/arm/boot/dts/overlays/README mnt/fat32/overlays/
sudo umount mnt/fat32
sudo umount mnt/ext4

# Plug the SD Card into Raspberry pi 2
