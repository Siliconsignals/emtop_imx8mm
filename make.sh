#!/bin/sh

export PATH=/home/chengpg/bin/arm/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu/bin:$PATH
export ARCH=arm64
export CROSS_COMPILE=arm-linux-

DESTDIR="/dev/shm/"

build_arm64() {
	SRCDTB="arch/arm64/boot/dts/freescale/fsl-imx8mm-demo.dtb"
	DSTDTB="fsl-imx8mm-demo.dtb"
	SRCKER="arch/arm64/boot/Image"
	DSTKER="Image"

	if ! [ -f ".config" ]; then
		# make imx_v8_defconfig
		make imx8mm_demo_defconfig
		[ $? != 0 ] && exit 1
	fi
    corenum=`cat /proc/cpuinfo |grep processor |wc -l`
    if test ; then
        make dtbs Image -j$corenum
        [ $? != 0 ] && exit 1
    else
        make dtbs Image modules -j$corenum
        [ $? != 0 ] && exit 1
        make INSTALL_MOD_PATH=/dev/shm/ modules_install
    fi
	for d in $DESTDIR; do
		! [ -d "$d" ] && continue
		echo "Info: COPY ${SRCDTB} -> ${d}/${DSTDTB}"
		cp -f ${SRCDTB} ${d}/${DSTDTB}
		echo "Info: COPY ${SRCKER} ->  ${d}/${DSTKER}"
		cp -f ${SRCKER} ${d}/${DSTKER}
	done
}

build_arm64
