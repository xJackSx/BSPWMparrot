#! /bin/sh

#Instalar Entrono BSPWM 2022

sudo apt update

sudo apt install -y build-essential git vim xcb libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev build-essential git cmake cmake-data pkg-config python3-sphinx python3-packaging libuv1-dev libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libpcre3-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev meson kitty feh scrot firejail zsh rofi xclip bat locate testdisk neofetch wmname acpi bspwm sxhkd zsh-syntax-highlighting zsh-autosuggestions zsh-autocomplet

# Creando carpeta de Reposistorios

mkdir ~/github

# Descargar Repositorios Necesarios

cd ~/github
git clone --recursive https://github.com/polybar/polybar
git clone https://github.com/yshui/picom.git

# Instalando Polybar

cd ~/github/polybar
mkdir build
cd build
cmake ..
make -j$(nproc)
sudo make install

# Instalando Picom

cd ~/github/picom
git submodule update --init --recursive
meson --buildtype=release . build
ninja -C build
sudo ninja -C build install

cd ~/autoBSPWMvmware

# Instalando p10k

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
echo 'source ~/.powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

# Instalando p10k root

sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/.powerlevel10k

# Configuramos el tema Nord de Rofi:

mkdir -p ~/.config/rofi/themes
cp ~/autoBSPWMvmware/rofi/nord.rasi ~/.config/rofi/themes/

# Instando lsd

sudo dpkg -i ~/autoBSPWMvmware/lsd.deb

# Instalamos las HackNerdFonts

sudo cp -v ~/autoBSPWMvmware/fonts/HNF/* /usr/local/share/fonts/

# Instalando Fuentes de Polybar

sudo cp -v ~/autoBSPWMvmware/Config/polybar/fonts/* /usr/share/fonts/truetype/

# Instalando Wallpaper de S4vitar

mkdir ~/Wallpaper
cp -v ~/autoBSPWMvmware/Wallpaper/* ~/Wallpaper
mkdir ~/ScreenShots

# Copiando Archivos de Configuración

rm -r ~/.config/polybar
cp -rv ~/autoBSPWMvmware/Config/* ~/.config/

# Copia de configuracion de .p10k.zsh y .zshrc

rm -rf ~/.zshrc
cp -v ~/autoBSPWMvmware/.zshrc ~/.zshrc

cp -v ~/autoBSPWMvmware/.p10k.zsh ~/.p10k.zsh
sudo cp -v ~/autoBSPWMvmware/.p10k.zsh-root /root/.p10k.zsh

# Script

sudo cp -v ~/autoBSPWMvmware/scripts/cleartarget /usr/local/bin/
sudo cp -v ~/autoBSPWMvmware/scripts/settarget /usr/local/bin/
sudo cp -v ~/autoBSPWMvmware/scripts/wichSystem.py /usr/local/bin/
sudo cp -v ~/autoBSPWMvmware/scripts/screenshot /usr/local/bin/

# Plugins ZSH

sudo mkdir /usr/share/zsh-sudo
cd /usr/share/zsh-sudo
sudo wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/sudo/sudo.plugin.zsh

# Cambiando de SHELL a zsh

chsh -s /usr/bin/zsh
sudo usermod --shell /usr/bin/zsh root
sudo ln -s -fv ~/.zshrc /root/.zshrc

# Asignamos Permisos a los Scritps

chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.config/bspwm/scripts/bspwm_resize
chmod +x ~/.config/bin/ethernet_status.sh
chmod +x ~/.config/bin/htb_status.sh
chmod +x ~/.config/bin/htb_target.sh
chmod +x ~/.config/polybar/launch.sh
sudo chmod +x /usr/local/bin/cleartarget
sudo chmod +x /usr/local/bin/settarge
sudo chmod +x /usr/local/bin/wichSystem.py
sudo chmod +x /usr/local/bin/screenshot

# Configuramos el Tema de Rofi

rofi-theme-selector

# Removiendo Repositorio

rm -rfv ~/github
rm -rfv ~/autoBSPWMvmware

# Mensaje de Instalado

notify-send "BSPWM INSTALADO"
