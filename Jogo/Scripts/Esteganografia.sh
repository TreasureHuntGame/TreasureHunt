# Recebe o diretório das imagens
# Se não for indicado, pega o diretório atual.
if [ $# -eq 0 ]
	then DIRETORIO="../$pwd/"
	else DIRETORIO="$1"
fi

SAIDA=$2

if [ $(ls $DIRETORIO | grep .jpg | wc -l) -eq 0 ]
	then echo "O diretório informado não contém imagem(ns)."
	else
	
		# Sorteia uma imagem no diretório
		while [ true ]
		do
			# Não funciona para arquivo com espaço em branco e extensão diferente de .jpg
			ARQUIVO=$(ls "$DIRETORIO" | grep .jpg | shuf -n 1) 
		
			# Volta ao laço se for um diretório;
			# interrompe caso contrário
			[ -d "$DIRETORIO$ARQUIVO" ] || break
		done
	
		if [ $# -eq 5 ]
		then
			# Esteganografa a flag na imagem sorteada
			if [ $5 -eq 1 ]
				then outguess -k $4 -d $3 $DIRETORIO$ARQUIVO $SAIDA
				else outguess -d $3 $DIRETORIO$ARQUIVO $SAIDA
			fi
		else
			# Gera a flag
			FLAG="TreasureHunt{"$(cat /dev/urandom | tr -cd 'a-z0-9' | head -c 8)"}"
		
			# Salva a flag em arquivo
			echo $FLAG > flag

			# Esteganografa a flag na imagem sorteada
			if [ $4 -eq 1 ]
				then outguess -k $3 -d flag $DIRETORIO$ARQUIVO $SAIDA
				else outguess -d flag $DIRETORIO$ARQUIVO $SAIDA
			fi
	
			# Remove o arquivo flag
			[ -e flag ] && rm flag
		fi
fi
