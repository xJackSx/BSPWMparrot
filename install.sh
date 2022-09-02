
#Instalar Entrono BSPWM 2022

sudo apt update

sudo apt install -y build-essential git vim xcb libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev

# Instalando Requerimientos para la polybar

sudo apt install -y build-essential git cmake cmake-data pkg-config python3-sphinx python3-packaging libuv1-dev libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev

# Dependencias de Picom

sudo apt install -y libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libpcre3-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev meson

# Actualizando Repositorios

sudo apt update

# Instalamos paquetes adionales

sudo apt install -y kitty feh scrot firejail zsh rofi xclip bat arandr bat locate testdisk wmname

# Creando carpeta de Reposistorios

mkdir ~/github

# Descargar Repositorios Necesarios

cd ~/github
git clone https://github.com/baskerville/bspwm.git
git clone https://github.com/baskerville/sxhkd.git
git clone --recursive https://github.com/polybar/polybar
git clone https://github.com/yshui/picom.git

# Instalando BSPWM

cd ~/github/bspwn
make
sudo make install

sudo apt -y install bspwm

# Instalando sxhkd

cd ~/github/sxhkd
make
sudo make install

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

# Instalando p10k

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
echo 'source ~/.powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

# Instalando p10k root

sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/.powerlevel10k

# Configuramos el tema Nord de Rofi:

mkdir -p ~/.config/rofi/themes
cp ~/autoBSPWMvmware/rofi/nord.rasi ~/.config/rofi/themes/

# Instando lsd

cd ~/Descargas

wget https://github.com/Peltoche/lsd/releases/download/0.22.0/lsd_0.22.0_amd64.deb

sudo dpkg -i lsd_0.22.0_amd64.deb

rm -v lsd_0.22.0_amd64.deb

# Instalamos las HackNerdFonts

sudo cp -v ~/autoBSPWMvmware/fonts/HNF/* /usr/local/share/fonts/

# Instalando Wallpaper de S4vitar

mkdir ~/Desktop/Wallpaper
cp -v ~/autoBSPWMvmware/Wallpaper/* ~/Desktop/Wallpaper/

# Copiando mis Archivos de Configuración

cp -rv ~/autoBSPWMvmware/Config/* ~/.config/

# Copia de configuracion de .p10k.zsh y .zshrc

rm -rf ~/.zshrc
cp -v ~/autoBSPWMvmware/.zshrc ~/.zshrc

rm -rf ~/.p10k.zsh
cp -v ~/autoBSPWMvmware/.p10k.zsh ~/.p10k.zsh

sudo rm -rf /root/.p10k.zsh
sudo cp -v ~/autoBSPWMvmware/.p10k.zsh /root/.p10k.zsh-root
sudo mv -v /root/.p10k.zsh-root /root/.p10k.zsh

# Script

sudo cp -v ~/autoBSPWMvmware/scripts/screenshot /usr/local/bin/
sudo cp -v ~/autoBSPWMvmware/scripts/cleartarget /usr/local/bin/
sudo cp -v ~/autoBSPWMvmware/scripts/settarget /usr/local/bin/

# Plugins ZSH

sudo apt install -y zsh-syntax-highlighting zsh-autosuggestions zsh-autocomplete
sudo mkdir /usr/share/zsh-sudo
cd /usr/share/zsh-sudo
sudo wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/sudo/sudo.plugin.zsh

# Cambiando de SHELL a zsh

chsh -s /usr/bin/zsh
sudo usermod --shell /usr/bin/zsh root

# Asignamos Permisos a los Scritps

chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.config/bspwm/scripts/bspwm_resize
chmod +x ~/.config/bin/ethernet_status.sh
chmod +x ~/.config/bin/htb_status.sh
chmod +x ~/.config/bin/htb_target.sh
chmod +x ~/.config/polybar/launch.sh
sudo chmod +x /usr/local/bin/screenshot
sudo chmod +x /usr/local/bin/cleartarget
sudo chmod +x /usr/local/bin/settarget
