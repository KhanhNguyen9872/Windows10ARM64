#!/data/data/com.termux/files/usr/bin/bash
# KhanhNguyen9872
# Update package
red='\033[1;31m'
green='\033[1;32m'
yellow='\033[1;33m'
blue='\033[1;34m'
light_cyan='\033[1;96m'
reset='\033[0m'
pkg update -y && pkg upgrade -y && pkg install wget tar qemu-system-aarch64-headless -y
# Download base and sha512sum
clear
cd 2> /dev/null
printf "\n\n${light_cyan} - Dang tai ve....(2.54GB)${green}\n\n"
wget -O base_arm64-khanhnguyen.tar.xz "https://cdn-104.anonfiles.com/13D4q8mbv6/739a1420-1638777742/base_arm64-khanhnguyen.tar.xz"
wget -O base_arm64-khanhnguyen.sha512sum "https://github.com/KhanhNguyen9872/Windows10ARM64/releases/download/Win10ARM64Base/base_arm64-khanhnguyen.sha512sum" 2> /dev/null
# Verify base file
clear
printf "\n\n${light_cyan} - Dang kiem tra file cai dat.....${green}\n\n"
sha512sum -c base_arm64-khanhnguyen.sha512sum || {
            printf "${red} File cai dat bi hong. Vui long cai lai \n\n${reset}"
			rm -f base_arm64-khanhnguyen.tar.xz 2> /dev/null
			rm -f win10 2> /dev/null
			rm -f base_arm64-khanhnguyen.sha512sum 2> /dev/null
            exit 1
}
# Install
printf "\n\n${light_cyan} - Dang cai dat! Vui long cho.....${green}\n\n"
rm -f base_arm64-khanhnguyen.sha512sum 2> /dev/null
if [ -f base_arm64-khanhnguyen.tar.xz ] 2> /dev/null; then
	tar -xJf base_arm64-khanhnguyen.tar.xz 2> /dev/null || :
	rm -f base_arm64-khanhnguyen.tar.xz 2> /dev/null
else
	printf "${red} - Cai dat that bai! Vui long thu lai sau! ${reset}\n"
	exit 1
fi
cd 2> /dev/null
wget -O win10 "https://raw.githubusercontent.com/KhanhNguyen9872/Windows10ARM64/main/win10" 2> /dev/null
# Configuring base
printf "\n\n${light_cyan} - Configuring base.....${green}\n\n"
mv win10 ${PREFIX}/bin/win10 2> /dev/null
chmod 777 ${PREFIX}/bin/win10 2> /dev/null
chmod 777 base_arm64 2> /dev/null
if [ -f base_arm64/khanh/base_arm64.qcow2 ] 2> /dev/null; then
	if [ -f base_arm64/khanh/BIOS.img ] 2> /dev/null; then
		if [ -f base_arm64/khanh/qemu.conf ] 2> /dev/null; then
			success=1 2> /dev/null
		else
			success=0 2> /dev/null
		fi
	else
	success=0 2> /dev/null
	fi
else
success=0 2> /dev/null
fi
clear
if [[ $success -eq 1 ]] 2> /dev/null; then
	printf "\n ${yellow} - INSTALL COMPLETED!\n"
	printf "${light_cyan} You can run 'win10' to start Windows10ARM64\n"
	printf "\n${yellow} - Use 'VNC Viewer' to connect 127.0.0.1:1\n${reset}"
	exit 0
else
	printf "\n ${red} - INSTALL FAILED!\n"
	printf "${light_cyan} Please try again!\n"
	rm -f ${PREFIX}/bin/win10 2> /dev/null
	exit 1
fi


