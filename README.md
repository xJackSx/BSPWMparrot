# Script Parrot

1.- Uso del Script

git clone https://github.com/xJackSx/BSPWMparrot.git

cd BSPWMparrot

chmod +x install.sh

./install.sh

"FULL UPGRADEADO"

y esta pensada en correr en maquinas virtuales de VMware

Buenas compañeros,

Espero les sirva este pequeño aporte

Hare algunas sugerencias que ya dependeran del gusto de cada quien

1.- PICOM

El picom ya no funciona con la variable del

--experimental-backends &

como diria el buen s4vitar, ya quedo deprecated.

los que dispongan de un buen equipo que pueda soportar las configuraciones de picom lo pueden activar en el archivo de configuración de bspwm.

picom &

si muestra lentitud tu equipo puedes desactivarlo desde el archivo de configuración del bspwmrc, que se encuentra en la siguiente ruta

~/.config/bspwm/bspwmrc

solo debes descomentar la linea y listo, reinicias la sesión con

kill -9 -1

y ya no arrancara el picom. esto afectara a la transparencia de la kitty y a los bordeados de las mismas terminales.

2.- Wallpaper

El wallpaper de nuestro queridisimo s4vitar esta alojado en una carpeta Wallpaper que se crea en nuestro HOME.

La configuración del mismo es al gusto.

3.- Nvim

Esta no esta incluida en el scripts

UN GRAN SALUDO A NUESTRO GRAN AMIGO S4VITAR.
