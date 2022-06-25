NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	for j in $(seq 1 25)
	do
		cat "../$i/$2/saida.out" | caesar $j > "../$i/$2/resposta$j"
		cat "../$i/$2/resposta$j" | base64 -d > "../$i/$2/respostaNova$j"
		if [ ! -z "$(cat ../$i/$2/respostaNova$j | grep TreasureHunt)" ]
		then
			cat "../$i/$2/respostaNova$j" | grep -n TreasureHunt | tail -c 24
			rm "../$i/$2/respostaNova$j"
			rm "../$i/$2/resposta$j"
			break
		fi
		rm "../$i/$2/respostaNova$j"
		rm "../$i/$2/resposta$j"
	done
done
