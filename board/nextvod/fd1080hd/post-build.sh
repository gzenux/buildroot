#!/bin/sh

BOARD_DIR="$(dirname $0)"

# Try to use vendor's version of mkimage
MKIMAGE=${BUILD_DIR}/uboot-1.3.1/tools/mkimage
[ -f "$MKIMAGE" ] || MKIMAGE=${HOST_DIR}/bin/mkimage
[ -f "$MKIMAGE" ] || { echo "$MKIMAGE not found!"; exit 1; }

# vendor u-boot uses vmlinux.ub
if [ -e ${BINARIES_DIR}/vmlinux ]; then
	OBJCOPY=${HOST_DIR}/bin/sh4-linux-objcopy
	$OBJCOPY -O binary ${BINARIES_DIR}/vmlinux ${BINARIES_DIR}/vmlinux.bin
	gzip --best --force ${BINARIES_DIR}/vmlinux.bin
	$MKIMAGE -A sh -O linux -T kernel -C gzip -a 0x80800000 -e 0x80801000 \
		-n Linux -d ${BINARIES_DIR}/vmlinux.bin.gz ${BINARIES_DIR}/vmlinux.ub
	cp -f ${BINARIES_DIR}/vmlinux.ub ${TARGET_DIR}/
elif [ -e ${BINARIES_DIR}/uImage ]; then
	cp -f ${BINARIES_DIR}/uImage ${BINARIES_DIR}/vmlinux.ub
else
	echo "No linux kernel image found!"
fi