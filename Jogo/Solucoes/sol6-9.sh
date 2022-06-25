NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	cat "../$i/$2/saida.out" | base32 -d > "../$i/$2/Desafio.class"
	strings "../$i/$2/Desafio.class" | grep TreasureHunt | cut -c -22
	rm "../$i/$2/Desafio.class"
done
