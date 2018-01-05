#!/bin/sh

BOARD_DIR="$(dirname $0)"
LINUX_DIR=${BUILD_DIR}/linux-3.16
OBJCOPY=${HOST_DIR}/bin/sh4-linux-objcopy
MKIMAGE=${BUILD_DIR}/uboot-1.3.1/tools/mkimage

# use vendor's version of mkimage
[ -f "$MKIMAGE" ] || { echo "$MKIMAGE not found!"; exit 1; }

# vendor u-boot uses vmlinux.ub
$OBJCOPY -O binary ${BINARIES_DIR}/vmlinux ${BINARIES_DIR}/vmlinux.bin
gzip --best --force ${BINARIES_DIR}/vmlinux.bin
$MKIMAGE -A sh -O linux -T kernel -C gzip -a 0x80800000 -e 0x80801000 \
-n Linux -d ${BINARIES_DIR}/vmlinux.bin.gz ${BINARIES_DIR}/vmlinux.ub
cp -f ${BINARIES_DIR}/vmlinux.ub ${TARGET_DIR}/
