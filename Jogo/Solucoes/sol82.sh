NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	for j in $(seq 1 25)
	do
		cat "../$i/$2/saida.out" | caesar $j > "../$i/$2/resposta$j.jpg"
		outguess -r "../$i/$2/resposta$j.jpg" "../$i/$2/saida.txt"
		if [ ! -z "$(cat ../$i/$2/saida.txt | grep TreasureHunt)" ]
		then
			rm "../$i/$2/resposta$j.jpg"
			break
		fi
		rm "../$i/$2/resposta$j.jpg"
	done
done
for i in $(seq 1 $NUM_INSTANCIAS)
do
	cat "../$i/$2/saida.txt" | grep TreasureHunt | cut -c -22
	rm "../$i/$2/saida.txt"
done
