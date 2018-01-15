NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	for j in $(seq 1 25)
	do

		cat "../$i/$2/saida.out" | caesar $j > "../$i/$2/Desafio.class"
		if [ ! -z "$(cat ../$i/$2/Desafio.class | grep TreasureHunt)" ]
		then
			strings "../$i/$2/Desafio.class" | grep TreasureHunt
			rm "../$i/$2/Desafio.class"
			break
		fi
		rm "../$i/$2/Desafio.class"
	done
done
