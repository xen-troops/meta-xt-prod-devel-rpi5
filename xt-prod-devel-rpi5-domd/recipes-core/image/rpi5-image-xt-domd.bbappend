PACKAGE_INSTALL:append = " \
    kernel-modules \
"

WIFI_PACKAGES = "			\
    wpa-supplicant			\
    iw					\
    wireless-regdb-static		\
    linux-firmware-rpidistro-bcm43455	\
    kernel-module-brcmfmac		\
"

IMAGE_INSTALL:append = "	\
    optee-test			\
    xen-tools-vchan		\
    ${@bb.utils.contains("MACHINE_FEATURES", "domd_wifi", "${WIFI_PACKAGES}", "" ,d)} \
"
