# BSPWMparrot for Ubuntu 24.04 LTS

This repository contains the configuration files and an installation script for setting up a BSPWM environment, originally created by **xJackSx**, adapted for **Ubuntu 24.04 LTS**.

## Original Source

The original configuration and scripts were developed by [xJackSx](https://github.com/xJackSx). This repository is an adaptation to ensure compatibility and ease of installation on Ubuntu 24.04 LTS.

## Installation on Ubuntu 24.04 LTS

To install BSPWM and its components on Ubuntu 24.04 LTS, please follow these steps:

1.  **Navigate to the `BSPWMparrot` directory:**
    Assuming you have cloned this repository, navigate into it:
    ```bash
    cd BSPWMparrot/
    ```

2.  **Make the installation script executable:**
    ```bash
    chmod +x install_ubuntu.sh
    ```

3.  **Run the installation script:**
    ```bash
    ./install_ubuntu.sh
    ```

**Important Notes:**
*   The script will ask for your `sudo` password multiple times during the installation process.
*   The script will launch `rofi-theme-selector` interactively. Please choose your preferred Rofi theme when prompted.
*   The script will change your default shell to `zsh`. You will need to log out and log back in (or restart your terminal) for this change to take effect.
*   Some parts of the installation (like compiling Polybar and Picom) can take a few minutes depending on your system's performance.
*   The original `BSPWMparrot` directory and its contents (`install.sh`, `lsd.deb`, `Config`, `fonts`, etc.) are left intact after the installation for your reference.
*   After the installation, you might need to select `bspwm` as your desktop environment at your login screen.

## What's Included:

This setup typically includes:
*   **bspwm**: Tiling window manager
*   **sxhkd**: Hotkey daemon
*   **Polybar**: Status bar
*   **Picom**: Compositor
*   **Rofi**: Application launcher
*   **Kitty**: Terminal emulator
*   **Zsh with Powerlevel10k**: Shell with a powerful theme
*   **lsd**: Next-gen `ls` command
*   **Feh**: Wallpaper setter
*   **Flameshot**: Screenshot tool
*   Various utilities and configurations.