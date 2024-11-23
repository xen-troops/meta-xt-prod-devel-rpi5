# Simple initramfs image. Mostly used for live images.
DESCRIPTION = "Generic xen dom0 vm image capable of booting other VMs as \
configured. RAM-based Initial Root Filesystem (initramfs) is used to avoid \
need for accessing block/mtd devices. Shall contain kernel images for other \
VMs."

IMAGE_INSTALL = "packagegroup-core-boot ${CORE_IMAGE_EXTRA_INSTALL}"

IMAGE_LINGUAS = ""

LICENSE = "MIT"

IMAGE_FSTYPES = "${INITRAMFS_FSTYPES}"

inherit core-image

BAD_RECOMMENDATIONS += "busybox-syslog"

IMAGE_ROOTFS_SIZE ?= "8192"
