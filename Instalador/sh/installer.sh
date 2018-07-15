#!/bin/bash

DIST=`sherlock.sh | grep -oP '(?<=DISTRIBUTION=).*'`
echo "Distribuição detectada: $DIST"

ni=()

if [ $DIST="debian" ];then
	
elif [ $DIST="arch" ]; then
	echo "pacman"
elif [ $DIST="redhat" ]; then
	echo "yum"
else
	echo "Instalador não compatível com distribuição."
fi