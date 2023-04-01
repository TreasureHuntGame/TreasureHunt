#!/bin/bash

CURRENT_PATH=$(pwd)

case $CURRENT_PATH in
	/*/Jogo/Scripts) cd ../ ;;
	/*/TreasureHunt/Jogo) ;;
	*) echo "Diretório inválido, execute o script a partir do diretório de Scripts do TreasureHunt." && exit 1 ;;
esac

FIX_CAESAR_PATH=$(which caesar)
grep -rl --exclude="${0##*/}" --exclude="Composer.sh" 'caesar' * | xargs sed -i "s#caesar#${FIX_CAESAR_PATH}#g"