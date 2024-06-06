## System Requirements

[Moulin requirements](https://moulin.readthedocs.io/en/latest/about.html#requirements-and-installation)

[Yocto requirements](https://docs.yoctoproject.org/ref-manual/system-requirements.html)

[Zephyr requirements](https://docs.zephyrproject.org/latest/develop/getting_started/index.html)

## Build

```
mkdir <my_build_dir>
cd <my_build_dir>
curl -O https://raw.githubusercontent.com/xen-troops/meta-xt-prod-devel-rpi5/master/rpi5.yaml
moulin rpi5.yaml
ninja
```

## Create sd image

```
ninja full.img
```
or
```
ninja full.img.bmap
```
or
```
ninja full.img.gz
```

In case of use domd rootfs from the usb flash drive rootfs partition will not be created in image. Rootfs
image should be written separately to the appropriate partition on media with command:
```
dd if=yocto/build-domd/tmp/deploy/images/raspberrypi5/rpi5-image-xt-domd-raspberrypi5.rootfs.ext4 of=<partition device> bs=1M
```
Note: before writing rootfs media should be properly partitioned for example with `fdisk` command
## Known issues
1. Sometime rpi boot firmware files are not deployed during build. In this case rpi-bootfiles, rpi-config and
rpi-cmdline recipes should be cleaned with yocto command:
```
cd yocto
. poky/oe-init-build-env build-domd
bitbake -c clean rpi-bootfiles -c clean rpi-config -c clean rpi-cmdline
cd ../..
ninja
```
2. Same behaviour as in previous section can be observed with the following packages:

In DomD build deployment can be forced using the following commands:
```
cd yocto
. poky/oe-init-build-env build-domd
bitbake trusted-firmware-a xen linux-raspberrypi xen-tools u-boot -c do_deploy --force
cd ../..
ninja
```

In DomU:

```
cd yocto
. poky/oe-init-build-env build-domu
bitbake linux-generic-armv8 -c do_deploy --force
cd ../..
ninja
```
