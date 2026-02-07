#!/bin/bash

# Exit if run as root, as it performs user-specific configurations.
if [ "$(whoami)" == "root" ]; then
    echo "This script should not be run as root. Exiting."
    exit 1
fi

# Store the current directory for later use (where the script is located).
ruta=$(pwd)

echo "Starting system update and package installation for Ubuntu 24.04 LTS..."

# Update and upgrade the system
sudo apt update
sudo apt upgrade -y

# Install build essentials and common dependencies
echo "Installing core dependencies..."
sudo apt install -y build-essential git vim xcb libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev

# Install requirements for Polybar
echo "Installing Polybar build dependencies..."
sudo apt install -y cmake cmake-data pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev libjsoncpp-dev libmpdclient-dev libuv1-dev libnl-genl-3-dev

# Dependencies for Picom
echo "Installing Picom build dependencies..."
sudo apt install -y meson libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev libxcb-glx0-dev libpcre3 libpcre3-dev ninja-build

# Install additional packages
echo "Installing additional utility packages and desktop components..."
sudo apt install -y feh flameshot scrub zsh rofi xclip bat locate wmname acpi bspwm sxhkd imagemagick ranger

# Create a directory for cloning repositories
echo "Creating ~/github directory for cloning repositories..."
mkdir -p ~/github

# Download necessary repositories
echo "Cloning Polybar and Picom repositories..."
cd ~/github
git clone --recursive https://github.com/polybar/polybar || { echo "Failed to clone Polybar"; exit 1; }
git clone https://github.com/ibhagwan/picom.git || { echo "Failed to clone Picom"; exit 1; }

# Install Polybar
echo "Building and installing Polybar..."
cd ~/github/polybar
mkdir -p build
cd build
cmake .. || { echo "Polybar CMake failed"; exit 1; }
make -j$(nproc) || { echo "Polybar make failed"; exit 1; }
sudo make install || { echo "Polybar install failed"; exit 1; }
echo "Polybar installed successfully."

# Install Picom
echo "Building and installing Picom..."
cd ~/github/picom
git submodule update --init --recursive || { echo "Picom submodule update failed"; exit 1; }
meson --buildtype=release . build || { echo "Picom Meson failed"; exit 1; }
ninja -C build || { echo "Picom ninja build failed"; exit 1; }
sudo ninja -C build install || { echo "Picom install failed"; exit 1; }
echo "Picom installed successfully."

# Install Powerlevel10k for zsh
echo "Installing Powerlevel10k..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k || { echo "Failed to clone Powerlevel10k"; exit 1; }
echo 'source ~/.powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
echo "Powerlevel10k installed for user."

# Install Powerlevel10k for root
echo "Installing Powerlevel10k for root..."
sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/.powerlevel10k || { echo "Failed to clone Powerlevel10k for root"; exit 1; }
echo "Powerlevel10k installed for root."

# Copy Rofi themes
echo "Copying Rofi themes..."
mkdir -p ~/.config/rofi/themes
cp "$ruta/rofi/"* ~/.config/rofi/themes/
cp "$ruta/rofi/template" ~/.config/rofi/themes/.
echo "Rofi themes copied."

# Install lsd (provided .deb package)
echo "Installing lsd .deb package..."
sudo dpkg -i "$ruta/lsd.deb" || { echo "Failed to install lsd.deb. Attempting to fix dependencies..."; sudo apt --fix-broken install -y; sudo dpkg -i "$ruta/lsd.deb"; }
echo "lsd installed."

# Install HackNerdFonts
echo "Installing HackNerdFonts..."
sudo mkdir -p /usr/local/share/fonts/HNF/
sudo cp -v "$ruta/fonts/HNF/"* /usr/local/share/fonts/HNF/
echo "HackNerdFonts copied."

# Install Polybar specific fonts
echo "Installing Polybar specific fonts..."
sudo mkdir -p /usr/share/fonts/truetype/polybar/
sudo cp -v "$ruta/Config/polybar/fonts/"* /usr/share/fonts/truetype/polybar/
echo "Polybar fonts copied."

# Update font cache
echo "Updating font cache..."
sudo fc-cache -fv
echo "Font cache updated."

# Install S4vitar Wallpaper
echo "Setting up Wallpaper and Screenshots directories..."
mkdir -p ~/Wallpaper
cp -v "$ruta/Wallpaper/"* ~/Wallpaper
mkdir -p ~/ScreenShots
echo "Wallpaper copied and Screenshots directory created."

# Copy configuration files
echo "Copying configuration files to ~/.config/ and /opt/kitty..."
cp -rv "$ruta/Config/"* ~/.config/ || { echo "Failed to copy user config files"; }
sudo mkdir -p /opt/kitty
sudo cp -rv "$ruta/kitty" /opt/ || { echo "Failed to copy kitty to /opt/"; } # Original script had /opt/, maintaining it.

# Kitty Root config
echo "Copying Kitty config for root..."
sudo mkdir -p /root/.config/
sudo cp -rv "$ruta/Config/kitty" /root/.config/ || { echo "Failed to copy kitty config for root"; }

# Copy .p10k.zsh and .zshrc
echo "Copying .zshrc and .p10k.zsh configurations..."
rm -f ~/.zshrc # Use -f for force removal without prompt
cp -v "$ruta/.zshrc" ~/.zshrc
cp -v "$ruta/.p10k.zsh" ~/.p10k.zsh
sudo cp -v "$ruta/.p10k.zsh-root" /root/.p10k.zsh
echo "Zsh configurations copied."

# Copy system scripts
echo "Copying system scripts..."
sudo mkdir -p /usr/local/bin/
sudo cp -v "$ruta/scripts/whichSystem.py" /usr/local/bin/
echo "System scripts copied."

# Install ZSH Plugins
echo "Installing ZSH plugins..."
sudo apt install -y zsh-syntax-highlighting zsh-autosuggestions zsh-autocomplete
sudo mkdir -p /usr/share/zsh-sudo
cd /usr/share/zsh-sudo
sudo wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/sudo/sudo.plugin.zsh || { echo "Failed to download zsh sudo plugin"; }
echo "ZSH plugins installed."

# Change default shell to zsh
echo "Changing default shell to zsh for user and root..."
chsh -s /usr/bin/zsh || { echo "Failed to change user shell to zsh"; }
sudo usermod --shell /usr/bin/zsh root || { echo "Failed to change root shell to zsh"; }
sudo ln -s -fv ~/.zshrc /root/.zshrc # Symlink user's zshrc to root's for consistency if not already done
echo "Default shell changed to zsh."

# Assign execute permissions to scripts
echo "Assigning execute permissions to various scripts..."
chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.config/bspwm/scripts/bspwm_resize
chmod +x ~/.config/bin/ethernet_status.sh
chmod +x ~/.config/bin/htb_status.sh
chmod +x ~/.config/bin/htb_target.sh
chmod +x ~/.config/polybar/launch.sh
sudo chmod +x /usr/local/bin/whichSystem.py
echo "Execute permissions set."

# Configure Rofi Theme (interactive step)
echo "Launching Rofi theme selector. Please choose your preferred theme."
rofi-theme-selector

# Cleaning up downloaded repositories
echo "Cleaning up temporary GitHub repositories..."
rm -rf ~/github
# The original script tried to remove its own directory ($ruta).
# This is dangerous and can lead to unexpected behavior if the script is moved.
# It is better to leave the source directory unless explicitly requested to remove it.
# rm -rf "$ruta"
echo "Cleanup complete. The source directory '$ruta' has been left intact."

# Installation complete notification
echo "BSPWM installation for Ubuntu 24.04 LTS complete!"
notify-send "BSPWM INSTALADO" "BSPWM and its components have been installed successfully on your Ubuntu 24.04 LTS system."
