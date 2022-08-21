---
title: ZFS and dm-crypt On Windows 10/11 WSL2 using custom kernel
date: 2022-08-08
desc: "Enable ZFS and dm-crypt support on Windows using custom compiled WSL2 kernel"
keywords: "Linux, Windows, Sys Ops, WSL2"
categories: [Linux, Windows, WSL2]
tags: [Linux, Windows, Sys Ops, WSL2]
icon: fa-book
---

## Introduction and Context

### ZFS

### DM-Crypt

### Custom WSL2 kernel

## Steps to enable ZFS and dm-crypt on Windows WSL2

### Build custom WSL2 kernerl with ZFS and dm-crypt support: 

1. Use this well-written script to download and setup the kernel source files and the ZFS module : [build_wsl_kernel](https://github.com/alexhaydock/zfs-on-wsl/blob/main/build_wsl_kernel.sh) which uses the kernel config from [the official Microsoft WSL2 kernel repository](https://github.com/microsoft/WSL2-Linux-Kernel).
1. `cd /usr/src/linux-${KERNELVER}-${KERNELNAME}`
1. Install ncurses library needed for menuconfig: `sudo apt install libncurses-dev`.
1. Enable dm_crypt, cryptographic API and other kernel modules as necessary using menuconfig: `sudo make menuconfig`

    ```bash

    [*] Enable loadable module support

    Device Drivers --->
    [*] Multiple devices driver support (RAID and LVM) --->
        <*> Device mapper support
        <M>   Crypt target support    

    General setup  --->
        [*] Initial RAM filesystem and RAM disk (initramfs/initrd) support

    Device Drivers --->
        [*] Block Devices ---> 
            <*> Loopback device support 

    File systems ---> 
        <*> FUSE (Filesystem in Userspace) support 
    ```

1. Choose the cipher and digest algorithms you want to use:
    1.1. Enable `XTS Support` under `Cryptographic API`

    ```bash
    [*] Cryptographic API --->
        <*> XTS support
        <*> SHA224 and SHA256 digest algorithm
        <*> AES cipher algorithms
        <*> AES cipher algorithms (x86_64)
        <*> User-space interface for hash algorithms
        <*> User-space interface for symmetric key cipher algorithms
        <*> RIPEMD-160 digest algorithm 
        <*> SHA384 and SHA512 digest algorithms 
        <*> Whirlpool digest algorithms 
        <*> LRW support 
        <*> Serpent cipher algorithm 
        <*> Twofish cipher algorithm
    ``` 
1. Install necessary system requirements for compiling the kernel: `sudo apt install uuid-dev libz-dev libudev-dev libblkid-dev libssl-dev libaio-dev flex bison libelf-dev`

1. Compile and build the custom kernel: `sudo make install && sudo make modules_install `

1. Copy the new kernel to the `C:\Users\<username>` directory on Windows where `<username>` should be replaced with your Windows user name: `cp arch/x86_64/boot/bzImage /mnt/c/Users/<username>`

1. On your Windows host, create (if does not exist) or update: `C:\Users\<username>\.wslconfig` file to have the following contents:

    ```toml
    [wsl2]
    kernel=C:\\Users\\<username>\\bzImage
    swap=0
    localhostForwarding=true
    ```

    Save and close the file.

1. Reboot WSL2 using a Windows `cmd` prompt or powershell: `wsl --shutdown`

1. Open a new WSL2 session and load the `dm-crypt` kernel module: `sudo modprobe -v dm-crypt`

    You should see an output similar to the following :

    ```bash
    insmod /lib/modules/4.19.81-microsoft-standard/kernel/drivers/md/dm-crypt.ko
    ```

**You can now use dm-crypt on Windows WSL2 to load your encrypted disks and/or setup and access ZFS and zpools!**

1. Attach a test disk drive to your Windows host via USB to test.
1. Using a Window cmd prompt launched with Adminstrative privileges, run the following command to mount the test disk drive to the WSL2 container:

    ```cmd
    wmic diskdrive list brief4.wsl --mount \.\PHYSICALDRIVE1 --bareWLS2
    ```

1. Using a bash terminal, run the following command: `lsblk`. You should see your ZFS and dm-crypt devices.

**Go ahead and unlock your encrypted disk drive and mount or setup/import your `zpool` volumes and filesystems!**