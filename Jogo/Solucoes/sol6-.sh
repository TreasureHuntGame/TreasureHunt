NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	strings "../$i/$2/Desafio.class" | grep TreasureHunt
done
