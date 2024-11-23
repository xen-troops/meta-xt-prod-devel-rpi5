FILESEXTRAPATHS:prepend := "${THISDIR}/files/:"

BRANCH = "master"
SRCREV = "6613476e225e090cc9aad49be7fa504e290dd33d"
LINUX_VERSION = "6.8.0-rc1"

SRC_URI = " \
    git://github.com/torvalds/linux.git;branch=${BRANCH};protocol=https \
    file://defconfig \
"
