NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	base32 -d "../$i/$2/saida.out" > "../$i/$2/resposta"
	base32 -d "../$i/$2/resposta" > "../$i/$2/texto"
	cat "../$i/$2/texto" | grep -n "TreasureHunt" | tail -c 24
	rm "../$i/$2/resposta"
	rm "../$i/$2/texto"
done
