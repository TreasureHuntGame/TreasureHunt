NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	# era cat
	strings "../$i/$2/saida.out" | base64 -d > "../$i/$2/resposta"
done

for i in $(seq $NUM_INSTANCIAS)
do
	base32 -d < "../$i/$2/resposta" | grep "TreasureHunt" | tail -c -24
	rm "../$i/$2/resposta"
done
