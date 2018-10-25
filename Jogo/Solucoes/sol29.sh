NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	cat "../$i/$2/saida.out" | base32 -d > "../$i/$2/resposta"
	for j in $(seq 1 25)
	do
		cat "../$i/$2/resposta" | caesar $j > "../$i/$2/resposta$j"
		if [ ! -z "$(cat ../$i/$2/resposta$j | grep TreasureHunt)" ]
		then
			cat "../$i/$2/resposta$j" | grep -n TreasureHunt | tail -c 24
			rm "../$i/$2/resposta$j"
			break
		fi
		rm "../$i/$2/resposta$j"
	done
	rm "../$i/$2/resposta"
done
