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
