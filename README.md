# Jimmy's ZYNQ System
## Initial Environment
```bash
git submodule update --init --recursive
```
## fpga
- PL design, synthesis script, fsbl


## dtc
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

## u-boot-xlnx
- The u-boot bootloader with Xilinx patches and drivers
- Compile command
```bash
sudo apt-get install libssl-dev
CROSS_COMPILE=arm-xilinx-linux-gnueabi-
export CROSS_COMPILE
make zynq_zed_defconfig
make all
```

## device-tree-xlnx
- Device Tree generator plugin for xsdk


## linux-xlnx
- The Linux kernel with Xilinx patches and drivers




