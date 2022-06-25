NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	strings "../$i/$2/saida.out" | base32 -d | grep TreasureHunt | tail -c 24
done
