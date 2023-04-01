#!/bin/bash

# Considere executar este arquivo do diretório $DIR/TreasureHunt/Jogo/Scripts
# O objetivo deste script é substituir as chamadas à ferramenta caesar por diretório/completo/do/caesar,
# um problema comum em versões recentes do Linux.
# O script substituirá a expressão "caesar" em todas as suas aparições nos arquivos do diretório, exceto
# neste arquivo, para não afetar o script de correção, e no arquivo Composer.sh, que menciona caesar
# apenas em alguns comentários e não faz chamadas à ferramenta.

# Obtém o diretório padrão
CURRENT_PATH=$(pwd)

# Verifica se o diretório padrão corresponde a um subdiretório potencial do jogo
# Caso você crie outros diretórios com esta estrutura, o script executará normalmente e pode alterar
# seus arquivos. Portanto, evite mover o arquivo de diretório
case $CURRENT_PATH in
	/*/Jogo/Scripts) cd ../ ;;
	/*/TreasureHunt/Jogo) ;;
	*) echo "Diretório inválido, execute o script a partir do diretório de Scripts do TreasureHunt." && exit 1 ;;
esac

# Obtém o caminho absoluto onde se encontra a ferramenta caesar
FIX_CAESAR_PATH=$(which caesar)

# Procura a expressão "caesar" recursivamente no diretório, exceto neste arquivo e no arquivo Composer.sh, e
# substitui todas as ocorrências de "caesar" por "diretório/completo/do/caesar".
grep -rl --exclude="${0##*/}" --exclude="Composer.sh" 'caesar' * | xargs sed -i "s#caesar#${FIX_CAESAR_PATH}#g"

# Obs.: o arquivo não foi exaustivamente testado e foi fornecido como solução emergencial. Caso note algum
# problema, envie-nos uma mensagem!