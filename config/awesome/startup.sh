#!/bin/sh
#

pkill conky
(sleep 6 ; conky -c $HOME/.config/awesome/conky.conkyrc) &

######## DO NOT REMOVE THIS BLOCK ########
if [[ -f "/usr/local/bin/startup" ]]; then
	sh /usr/local/bin/startup
fi
######## DO NOT REMOVE THIS BLOCK ########