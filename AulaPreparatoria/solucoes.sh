# Script de solução dos desafios de aula.
while :
do
	# Solicita o número do exercício a ter a solução executada.
	echo "Entre com o número do exercício (0 para sair):"
	read NUM

	case $NUM in

		# Encerra o programa.
		0) exit 1 ;;

		# Procura caracteres imprimíveis no arquivo e
		# filtra pela expressão "y0u" (Solução 1).
		1) strings furacao.jpg | grep y0u
		
		# Procura caracteres imprimíveis no arquivo e
		# salva em saida.txt. Logo depois, imprime o
		# conteúdo deste arquivo e filtra pela expressão
		# "y0u" (Solução 2).
		# strings furacao.jpg > saida.txt
		# cat saida.txt | grep y0u

		# Imprime os metadados da imagem com a ferramenta
		# exiftool e filtra pela expressão "y0u" (Solução 3).
		# exiftool furacao.jpg | grep y0u #sol 3
		;;

		# Decifra o texto com a chave 23.
		2) echo "TXH DXOD FKDWD!" | caesar 23 ;;

		# Verifica que o arquivo é de texto e decifra com chave 24.
		# Salva o arquivo como exercicio.c e substitui a ocorrência
		# de %i por %c para imprimir caracteres.
		# Neste ponto, observar o código comentado seria suficiente.
		# Depois, é necessário compilar e executar o arquivo.
		3) file exercicio.exe
		cat exercicio.exe | caesar 24 > exercicio.c
		sed -i 's/%i/%c/g' exercicio.c
		gcc -o exercicio exercicio.c
		./exercicio
		;;

		# Imprime a expressão e decodifica em base64.
		4) echo "TyBxdWUgZGl6IGFxdWk/Cg==" | base64 -d ;;

		#
		5) file compactado.zip
		mv compactado.zip compactado.jpg
		outguess -r compactado.jpg out.txt
		cat out.txt
		;;

		# Testa se os arquivos são iguais.
		6) diff file1 file2 ;;

		7)
		unzip files.zip
		echo "Arquivos únicos: "
		for i in $(seq 1 7)
		do
			x=0
			for j in $(seq 1 7)
			do
				if [ $i -eq $j ]
				then continue
				fi

				if [ -z "$(diff file$i file$j)" ]
				then
					x=1
					break
				fi
			done
			if [ $x -eq 0 ]
			then echo $i
			fi
		done
		;;

		8)
		xxd -p upp.jpg | sed '0,/00000000/s/00000000/ffd8ffe0/' | xxd -p -r > original.jpg
		display original.jpg ;; # desnecessauro

		# Qualquer outro valor informado é considerado inválido.
		*) echo "Exercício inválido!" ;;
	esac
done
