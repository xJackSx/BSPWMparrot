The `install_ubuntu.sh` script has been created in the `BSPWMparrot/` directory.

To install BSPWM and its components on Ubuntu 24.04 LTS, please follow these steps:

1.  **Navigate to the `BSPWMparrot` directory:**
    ```bash
    cd BSPWMparrot/
    ```

2.  **Run the installation script:**
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

Let me know if you encounter any issues or have further questions.