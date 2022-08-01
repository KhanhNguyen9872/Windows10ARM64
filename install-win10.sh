#!/data/data/com.termux/files/usr/bin/bash
# KhanhNguyen9872
red='\033[1;31m'
green='\033[1;32m'
yellow='\033[1;33m'
blue='\033[1;34m'
light_cyan='\033[1;96m'
reset='\033[0m'

mkdir /data/data/com.termux/files/home 2> /dev/null
export HOME="/data/data/com.termux/files/home" 2> /dev/null

cd 2> /dev/null
echo "Y" | termux-setup-storage > /dev/null

# Change mirror apt
echo "deb https://packages-cf.termux.dev/apt/termux-main stable main" > /data/data/com.termux/files/usr/etc/apt/sources.list

# Update package
pkg update -y && pkg upgrade -y && pkg install p7zip wget tar qemu-system-aarch64-headless -y

# Download base and sha512sum
clear
cd 2> /dev/null
printf "\n\n${light_cyan} - Downloading....${green}\n\n"
wget -q --show-progress -O base_arm64-khanhnguyen.tar.7z.001 "https://github.com/KhanhNguyen9872/Windows10ARM64/releases/download/Win10ARM64Base/base_arm64-khanhnguyen.tar.7z.001"
if [ -f base_arm64-khanhnguyen.tar.7z.001 ]; then
    wget -q --show-progress -O base_arm64-khanhnguyen.tar.7z.002 "https://github.com/KhanhNguyen9872/Windows10ARM64/releases/download/Win10ARM64Base/base_arm64-khanhnguyen.tar.7z.002"
else
    echo "Error when download file"
    echo "Internet so bad!"
    exit 0
fi
wget -q --show-progress -O base_arm64-khanhnguyen.sha512sum "https://github.com/KhanhNguyen9872/Windows10ARM64/releases/download/Win10ARM64Base/base_arm64-khanhnguyen.sha512sum" 2> /dev/null

# extract file
clear
printf "\n\n${light_cyan} - Extracting....${green}\n\n"
7z x base_arm64-khanhnguyen.tar.7z.001 -aoa > /dev/null
rm -rf base_arm64-khanhnguyen.tar.7z* 2> /dev/null

# Verify base file
clear
printf "\n\n${light_cyan} - Verify file.....${green}\n\n"
sha512sum -c base_arm64-khanhnguyen.sha512sum || {
            printf "${red} File cai dat bi hong. Vui long cai lai \n\n${reset}"
			rm -f base_arm64-khanhnguyen.tar.xz 2> /dev/null
			rm -f win10 2> /dev/null
			rm -f base_arm64-khanhnguyen.sha512sum 2> /dev/null
            exit 1
}

# Install
printf "\n\n${light_cyan} - Installing.....${green}\n\n"
rm -f base_arm64-khanhnguyen.sha512sum 2> /dev/null
if [ -f base_arm64-khanhnguyen.tar.xz ] 2> /dev/null; then
	tar -xJf base_arm64-khanhnguyen.tar.xz 2> /dev/null || :
	rm -f base_arm64-khanhnguyen.tar.xz 2> /dev/null
else
	printf "${red} - Failed when installing! ${reset}\n"
	exit 1
fi
cd 2> /dev/null
wget -O win10arm "https://raw.githubusercontent.com/KhanhNguyen9872/Windows10ARM64/main/win10" 2> /dev/null

# Configuring base
printf "\n\n${light_cyan} - Configuring base.....${green}\n\n"
mv win10arm /data/data/com.termux/files/usr/bin/win10arm 2> /dev/null
chmod 777 /data/data/com.termux/files/usr/bin/win10arm 2> /dev/null
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
cd 2> /dev/null
rm -rf *.sh 2> /dev/null
clear
if [[ $success -eq 1 ]] 2> /dev/null; then
	printf "\n ${yellow} - INSTALL COMPLETED!\n"
	printf "${light_cyan} You can run 'win10arm' to start Windows10ARM64\n"
	printf "\n${yellow} - Use 'VNC Viewer' to connect 127.0.0.1:5901\n${reset}"
	exit 0
else
	printf "\n ${red} - INSTALL FAILED!\n"
	printf "${light_cyan} Please try again!\n"
	rm -f /data/data/com.termux/files/usr/bin/win10arm 2> /dev/null
	rm -rf base_arm64 2> /dev/null
	exit 1
fi


