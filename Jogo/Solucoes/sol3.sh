NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	cat "../$i/$2/index.html" | grep -n TreasureHunt | tail -c -31 | cut -c -26
done
