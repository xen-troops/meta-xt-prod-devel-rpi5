require include/dt_config.inc

XEN_OVERLAYS:append = "${@bb.utils.contains("MACHINE_FEATURES", "scmi", " ${XEN_DT_SCMI}.dtbo", "", d)}"

SCMI_PCIE1_DT_NAME_ADD = "${@bb.utils.contains("MACHINE_FEATURES", "domd_nvme", "${SCMI_DOMD_PCIE1_DT_NAME}.dtbo", "", d)}"

DOMD_OVERLAYS:append = "${@bb.utils.contains("MACHINE_FEATURES", "scmi", " ${SCMI_DOMD_DT_NAME}.dtbo", "", d)}"
DOMD_OVERLAYS:append = "${@bb.utils.contains("MACHINE_FEATURES", "scmi", " ${SCMI_PCIE1_DT_NAME_ADD}", "", d)}"
