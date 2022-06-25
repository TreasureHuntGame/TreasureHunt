#revisar
NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	for j in $(seq 1 25)
	do
		cat "../$i/$2/saida.out" | caesar $j > "../$i/$2/resposta.jpg"

		# "JPEG image data," porque um arquivo dito de imagem, mas que não o é,
		# quando executado o comando file, retorna JPEG image data. Uma imagem
		# legítima retorna mais informações.
		if [ $(file "../$i/$2/resposta.jpg" | grep "JPEG image data," | wc -l) -ne 0 ]
		then
			outguess -r "../$i/$2/resposta.jpg" "../$i/$2/saida.txt"

			if [ $(grep "Treasure" "../$i/$2/saida.txt" | wc -l) -eq 0 ]
			then
				outguess -k $i -r "../$i/$2/resposta.jpg" "../$i/$2/saida.txt"
			fi

			rm "../$i/$2/resposta.jpg"

			break

		fi

	done

done

for i in $(seq 1 $NUM_INSTANCIAS)
do
	strings "../$i/$2/saida.txt" | grep TreasureHunt | cut -c -22
	rm "../$i/$2/saida.txt"
done
