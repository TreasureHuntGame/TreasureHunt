NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	strings "../$i/$2/Desafio.pyc" | grep TreasureHunt | cut -c -22
done
