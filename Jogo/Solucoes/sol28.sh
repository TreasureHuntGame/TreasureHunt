NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	outguess -r "../$i/$2/ronald.jpg" "../$i/$2/saida1"
	outguess -k $i -r "../$i/$2/ronald.jpg" "../$i/$2/saida2"
done
for i in $(seq $NUM_INSTANCIAS)
do
	for j in $(seq 1 25)
	do
		strings "../$i/$2/saida1" | caesar $j | grep TreasureHunt | cut -c -23
		strings "../$i/$2/saida2" | caesar $j | grep TreasureHunt | cut -c -23
	done
	rm "../$i/$2/saida1" "../$i/$2/saida2"
done
