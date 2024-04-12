FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "\
    file://domd-set-root \
"

FILES:${PN} += " \
    ${libdir}/xen/bin/domd-set-root \
"

DOMD_RAM_SIZE:mem8gb = "2048"
DOMD_RAM_SIZE:mem4gb = "1024"

# It is used a lot in the do_install, so variable will be handy
CFG_FILE="${D}${sysconfdir}/xen/domd.cfg"

do_install:append() {

    touch ${CFG_FILE}
    echo "" >> ${CFG_FILE}
    echo "# Initial memory allocation (MB)" >> ${CFG_FILE}
    echo "memory = ${DOMD_RAM_SIZE}" >> ${CFG_FILE}

    # Install domd-set-root script
    install -d ${D}${libdir}/xen/bin
    install -m 0744 ${WORKDIR}/domd-set-root ${D}${libdir}/xen/bin

    # Call domd-set-root script
    echo "[Service]" >> ${D}${systemd_unitdir}/system/domd.service
    echo "ExecStartPre=${libdir}/xen/bin/domd-set-root" >> ${D}${systemd_unitdir}/system/domd.service

    sed -i "s/\[VIRTIO_EXTRA_PARAMETERS\]//" ${CFG_FILE}
}
