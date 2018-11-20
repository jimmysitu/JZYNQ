# Jimmy's ZYNQ System
## Initial Environment
```bash
git submodule update --init --recursive
```
## Build FPGA
- PL design, synthesis script, fsbl

## Prepare Utility
### dtc
- Device Tree compiler (required to build U-Boot)
- Compile command
```bash
sudo apt-get install swig python-dev
make
```

- After the build process completes the dtc binary is created within the current directory. It is neccessary to make the path to the dtc binary accessible to tools (eg, the U-Boot build process). To make dtc available in other steps, it is recommended to add the tools directory to your $PATH variable.
```bash
export PATH=`pwd`:$PATH
```

### u-boot-xlnx
- The u-boot bootloader with Xilinx patches and drivers
- Compile command
```bash
export CROSS_COMPILE=arm-xilinx-linux-gnueabi-
sudo apt-get install libssl-dev
make zynq_zed_defconfig
make all
```

### device-tree-xlnx
- Device Tree generator plugin for xsdk

## Build Linux Kernel
### linux-xlnx
- The Linux kernel with Xilinx patches and drivers
```bash
export PATH=$PATH:/cad/Xilinx/SDK/2015.2/gnu/arm/lin/bin
export PATH=$PATH:$PWD/../u-boot-xlnx
make ARCH=arm UIMAGE_LOADADDR=0x8000 uImage
```

## Build and Modify a Rootfs
- Build command
```bash
mkdir build
cp arm_ramdisk.image.org.gz arm_ramdisk.image.gz
gunzip arm_ramdisk.image.gz
chmod u+rwx ramdisk.image
mkdir ./mntRamdisk
sudo mount -o loop arm_ramdisk.image ./mntRamdisk
sudo rm -rf ./mntRamdisk/lib/modules
export PATH=$PATH:/cad/Xilinx/SDK/2015.2/gnu/arm/lin/bin
export PATH=$PATH:$PWD/../u-boot-xlnx
export CROSS_COMPILE=arm-xilinx-linux-gnueabi-
export INSTALL_MOD_PATH=${PWD}/mntRamdisk
make ARCH=arm modules -C linux-xlnx
sudo make modules_install -C linux-xlnx
sudo umount ./mntRamdisk
gzip arm_ramdisk.image
./u-boot-xlnx/tools/mkimage -A arm -T ramdisk -C gzip -d arm_ramdisk.image.gz ./build/uramdisk.image.gz
```

