#!/bin/bash

export PATH=/root/bin/arm/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu/bin:$PATH
export ARCH=arm64
export CROSS_COMPILE=arm-linux-

DESTDIR="/dev/shm/"

to_build_modules=false
[ "$1" = "modules" ] && to_build_modules=true

build_imx8mm() {
	SRCDTB1="arch/arm64/boot/dts/freescale/fsl-imx8mm-demo.dtb"
	DSTDTB1="fsl-imx8mm-demo.dtb"
	SRCDTB2="arch/arm64/boot/dts/freescale/fsl-imx8mm-demo-hdmi.dtb"
	DSTDTB2="fsl-imx8mm-demo-hdmi.dtb"
	SRCDTB3="arch/arm64/boot/dts/freescale/fsl-imx8mm-demo-lt8912-lvds.dtb"
	DSTDTB3="fsl-imx8mm-demo-lt8912-lvds.dtb"
	SRCDTB4="arch/arm64/boot/dts/freescale/fsl-imx8mm-demo-vislcd-mipi.dtb"
	DSTDTB4="fsl-imx8mm-demo-vislcd-mipi.dtb"
	SRCDTB5="arch/arm64/boot/dts/freescale/fsl-imx8mm-demo-no-pcie.dtb"
	DSTDTB5="fsl-imx8mm-demo-no-pcie.dtb"
	SRCKER="arch/arm64/boot/Image"
	DSTKER="Image"

	if ! [ -f ".config" ]; then
		# make imx_v8_defconfig
		make imx8mm_demo_defconfig
		[ $? != 0 ] && exit 1
	fi
    corenum=`cat /proc/cpuinfo |grep processor |wc -l`

    if [ "$to_build_modules" = true ]; then
        make dtbs Image modules -j$corenum
        [ $? != 0 ] && exit 1
        make INSTALL_MOD_PATH=/dev/shm/ modules_install
    else
        make dtbs Image -j$corenum
        [ $? != 0 ] && exit 1
    fi
	for d in $DESTDIR; do
		! [ -d "$d" ] && continue
		echo "Info: COPY ${SRCDTB1} -> ${d}/${DSTDTB1}"
		cp -f ${SRCDTB1} ${d}/${DSTDTB1}
		echo "Info: COPY ${SRCDTB2} -> ${d}/${DSTDTB2}"
		cp -f ${SRCDTB2} ${d}/${DSTDTB2}
		echo "Info: COPY ${SRCDTB3} -> ${d}/${DSTDTB3}"
		cp -f ${SRCDTB3} ${d}/${DSTDTB3}
		echo "Info: COPY ${SRCDTB4} -> ${d}/${DSTDTB4}"
		cp -f ${SRCDTB4} ${d}/${DSTDTB4}
		echo "Info: COPY ${SRCDTB5} -> ${d}/${DSTDTB5}"
		cp -f ${SRCDTB5} ${d}/${DSTDTB5}
		echo "Info: COPY ${SRCKER} ->  ${d}/${DSTKER}"
		cp -f ${SRCKER} ${d}/${DSTKER}
	done
}
#------------------------------------------------------------------------------
build_imx8mn() {
	SRCDTB="arch/arm64/boot/dts/freescale/fsl-imx8mn-demo.dtb"
	DSTDTB="fsl-imx8mn-demo.dtb"
	SRCKER="arch/arm64/boot/Image"
	DSTKER="Image"

	if ! [ -f ".config" ]; then
		# make imx_v8_defconfig
		make imx8mm_demo_defconfig
		[ $? != 0 ] && exit 1
	fi
    corenum=`cat /proc/cpuinfo |grep processor |wc -l`

    if [ "$to_build_modules" = true ]; then
        make dtbs Image modules -j$corenum
        [ $? != 0 ] && exit 1
        make INSTALL_MOD_PATH=/dev/shm/ modules_install
    else
        make dtbs Image -j$corenum
        [ $? != 0 ] && exit 1
    fi
	for d in $DESTDIR; do
		! [ -d "$d" ] && continue
		echo "Info: COPY ${SRCDTB} -> ${d}/${DSTDTB}"
		cp -f ${SRCDTB} ${d}/${DSTDTB}
		echo "Info: COPY ${SRCKER} ->  ${d}/${DSTKER}"
		cp -f ${SRCKER} ${d}/${DSTKER}
	done
}

#------------------------------------------------------------------------------
build_imx8mp() {
	SRCDTB="arch/arm64/boot/dts/freescale/emtop-imx8mp-cm4io.dtb"
	DSTDTB="emtop-imx8mp-cm4io.dtb"
	SRCKER="arch/arm64/boot/Image"
	DSTKER="Image"

	if ! [ -f ".config" ]; then
		# make imx_v8_defconfig
		make imx8mm_demo_defconfig
		[ $? != 0 ] && exit 1
	fi
    corenum=`cat /proc/cpuinfo |grep processor |wc -l`

    if [ "$to_build_modules" = true ]; then
        make dtbs Image modules -j$corenum
        [ $? != 0 ] && exit 1
        make INSTALL_MOD_PATH=/dev/shm/ modules_install
    else
        make dtbs Image -j$corenum
        [ $? != 0 ] && exit 1
    fi
	for d in $DESTDIR; do
		! [ -d "$d" ] && continue
		echo "Info: COPY ${SRCDTB} -> ${d}/${DSTDTB}"
		cp -f ${SRCDTB} ${d}/${DSTDTB}
		echo "Info: COPY ${SRCKER} ->  ${d}/${DSTKER}"
		cp -f ${SRCKER} ${d}/${DSTKER}
	done
}

# main entry
build_imx8mm
# build_imx8mn
# build_imx8mp
