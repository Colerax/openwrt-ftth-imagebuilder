#!/bin/bash

. lib/ib.sh

function movistar_ftth() {
	local script_dir="$1/usr/sbin"
	local script="$script_dir/movistar"

	[ ! -d "$script_dir" ] && mkdir -p "$script_dir"
	[ ! -f "$script" ] && curl -o "$script" https://raw.githubusercontent.com/openwrt-es/ftth-movistar/master/movistar.sh
	chmod +x "$script"
}

function main() {
	movistar_ftth "$CW_DIR/files_movistar"

	release_version "chaos_calmer" "15.05"
	firmware_packages "luci luci-i18n-base-es kmod-bridge kmod-ipt-nathelper-rtsp swconfig bird4 igmpproxy udpxy luci-app-udpxy nfs-utils kmod-fs-nfs kmod-fs-nfs-common kmod-nls-cp437 kmod-nls-cp850 kmod-nls-cp852 kmod-nls-iso8859-15 kmod-nls-utf8 miniupnpd luci-app-upnp tcpdump htop ddns-scripts ddns-scripts_no-ip_com luci-app-ddns kmod-usb-storage kmod-fs-ntfs kmod-fs-ext4 kmod-fs-vfat block-mount kmod-scsi-core e2fsprogs samba36-server luci-app-samba ntfs-3g fdisk kmod-usb2 nfs-kernel-server usbutils kmod-loop kmod-usb-core kmod-usb-ohci kmod-usb-printer luci-proto-ipv6"

	firmware_files "$CW_DIR/files_movistar/"

	prepare_imagebuilder "ar71xx/generic" "ar71xx-generic"
	build_firmware "ar71xx" "TLWDR4300" "openwrt-*-tl-wdr4300-v1-squashfs*.*"

	# generate_checksums "ar71xx"
}

main

exit 0
