NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	for j in $(seq 1 25)
	do
		strings "../$i/$2/Desafio.pyc" | caesar $j | grep TreasureHunt | tail -c -25 | cut -c -23
	done
done
