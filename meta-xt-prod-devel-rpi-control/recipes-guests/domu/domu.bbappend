FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

RDEPENDS:${PN} += " backend-ready"
SRC_URI += "\
    file://domu-vdevices.cfg \
    file://domu-set-root \
    file://domu-set-root.conf \
    file://pvr-${XT_DOMU_CONFIG_NAME} \
"

FILES:${PN} += " \
    ${libdir}/xen/bin/domu-set-root \
    ${sysconfdir}/systemd/system/domu.service.d/domu-set-root.conf \
"

# It is used a lot in the do_install, so variable will be handy
CFG_FILE="${D}${sysconfdir}/xen/domu.cfg"

do_install:append() {

    cat ${WORKDIR}/domu-vdevices.cfg >> ${CFG_FILE}
    cat ${WORKDIR}/pvr-${XT_DOMU_CONFIG_NAME} >> ${CFG_FILE}

    # Install domu-set-root script
    install -d ${D}${libdir}/xen/bin
    install -m 0744 ${WORKDIR}/domu-set-root ${D}${libdir}/xen/bin
    install -d ${D}${sysconfdir}/systemd/system/domu.service.d

    install -m 0644 ${WORKDIR}/domu-set-root.conf ${D}${sysconfdir}/systemd/system/domu.service.d

}
