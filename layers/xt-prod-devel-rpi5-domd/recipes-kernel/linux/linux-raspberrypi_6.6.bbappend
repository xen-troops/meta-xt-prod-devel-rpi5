require include/dt_config.inc
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " \
    file://optee.cfg \
"

RPI_KERNEL_DEVICETREE:append = " \
    broadcom/${SCMI_XEN_DT_NAME}.dtbo \
    broadcom/${SCMI_DOMD_DT_NAME}.dtbo \
    broadcom/${SCMI_DOMD_PCIE1_DT_NAME}.dtbo \
    broadcom/${DOMD_WIFI_DT_NAME}.dtbo \
    broadcom/${XEN_WIFI_PASSTHROUGH_DT_NAME}.dtbo \
"

SRC_URI:append = " \
    file://${SCMI_XEN_DT_NAME}.dtso;subdir=git/arch/${ARCH}/boot/dts/broadcom \
    file://${SCMI_DOMD_DT_NAME}.dtso;subdir=git/arch/${ARCH}/boot/dts/broadcom \
    file://${SCMI_DOMD_PCIE1_DT_NAME}.dtso;subdir=git/arch/${ARCH}/boot/dts/broadcom \
    file://${DOMD_WIFI_DT_NAME}.dtso;subdir=git/arch/${ARCH}/boot/dts/broadcom \
    file://${XEN_WIFI_PASSTHROUGH_DT_NAME}.dtso;subdir=git/arch/${ARCH}/boot/dts/broadcom \
"
