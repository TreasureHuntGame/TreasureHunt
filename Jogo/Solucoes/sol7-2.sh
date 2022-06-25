NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	for j in $(seq 1 25)
	do

		cat "../$i/$2/saida.out" | caesar $j > "../$i/$2/Desafio.pyc"
		if [ ! -z "$(cat ../$i/$2/Desafio.pyc | grep TreasureHunt)" ]
		then
			strings "../$i/$2/Desafio.pyc" | grep TreasureHunt | cut -c -22
			rm "../$i/$2/Desafio.pyc"
			break
		fi
		rm "../$i/$2/Desafio.pyc"
	done
done
