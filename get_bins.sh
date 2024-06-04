#!/bin/sh

wget https://github.com/xen-troops/zephyr-dom0-xt/raw/rpi5_dom0_dev/prebuilt/zephyr_blinky.dtb -O zephyr_blinky.dtb
wget https://github.com/xen-troops/zephyr-dom0-xt/raw/rpi5_dom0_dev/prebuilt/zephyr_sync.dtb -O zephyr_sync.dtb
wget https://github.com/aoscloud/demo-services/raw/main/monkey_zephyr/src/helloworld_xen-arm64 -O helloworld_xen-arm64

