# autoBSPWMvmware

0.- Uso del Scrip

git clone https://github.com/xJackSx/autoBSPWMvmware.git

cd autoBSPWMvmware

chmod +x install.sh

./install.sh

Esta probada tanto en ParrotOS como en Kali-Linux
y esta pensada en correr en maquinas virtuales de VMware

Buenas compañeros,

Espero les sirva este pequeño aporte

Hare algunas sugerencias que ya dependeran del gusto de cada quien

1 Scrip de ethernet

Para los que lo instalaran en Kali es necesario modificar el scrip de ethernet_status, por la interfaz que tenga su equipo,
el scrip esta alojado en la siguiente ruta:

~/.config/bin/ethernet_status.sh

con el comando "ifconfig" puedes saber la interfaz de red que tienes asignada

2.- PICOM

El picom ya no funciona con la variable del

--experimental-backends &

como diria el buen s4vitar, ya quedo deprecated.

Entonces corre por defecto con la variable

picom &

por defecto, si muestra lentitud tu equipo puedes desactivarlo desde el archivo de configuración del bspwmrc, que se encuentra en la siguiente ruta

~/.config/bspwm/bspwmrc

solo debes de comentar la linea y listo, reinicias la sesión y ya no arrancara el picom.
esto afectara a la transparencia de la kitty y a los bordeados de las mismas terminales.

3.- Wallpaper

El wallpaper de nuestro queridisimo s4vitar esta alojado en una carpeta en el Desktop.
La configuración del mismo es al gusto.

4.- Nvim

Esta no esta incluida en el scripts

UN GRAN SALUDO A NUESTRO GRAN AMIGO S4VITAR.
