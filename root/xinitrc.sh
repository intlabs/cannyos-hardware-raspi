#!/bin/sh 

#if [ -d /etc/X11/xinit/xinitrc.d ]; then 
#for f in /etc/X11/xinit/xinitrc.d/*; do 
#[ -x "$f" ] && . "$f" 
#done 
#unset f 
#fi

#exec startxfce4
exec midori -i 120 -e Fullscreen -e Navigationbar -a http://www.google.com