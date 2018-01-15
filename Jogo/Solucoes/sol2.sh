NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	for j in $(seq 1 25)
	do
		cat "../$i/$2/saida.out" | caesar $j > "../$i/$2/resposta"
		if [ ! -z "$(cat ../$i/$2/resposta | grep TreasureHunt)" ]
		then
			cat "../$i/$2/resposta" | grep -n TreasureHunt | tail -c 24
			rm "../$i/$2/resposta"
			break
		fi
		rm "../$i/$2/resposta"
	done
done
