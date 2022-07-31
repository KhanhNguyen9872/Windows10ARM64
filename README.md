# Windows10ARM64
Run Windows10 ARM64 on Android Device
# How to install?
1 - Download Termux APK (click on Picture): 
<a href="https://khanhnguyen9872.github.io/Ninja_Server_Termux/CONF_FILE/termux_0.118.apk" target="_blank">
    <img alt="Termux" src="https://github.com/KhanhNguyen9872/Ninja_Server_Termux/raw/main/image/termux.png" />
</a>


2 - Install Termux APK

3 - Copy this line and paste it to Termux
```bash
function install () {
  clear; curl -L --max-redirs 15 --progress-bar "https://raw.githubusercontent.com/KhanhNguyen9872/Windows10ARM64/main/install-win10.sh" --output script_install.sh && bash script_install.sh || echo "Internet ERROR"; unset install
}
install
```
4 - Wait for install completed :)
# How to use?
- Use this command to start
```bash
win10arm
```

- Use 'VNC Viewer' connect IP 127.0.0.1:1 or localhost:1

