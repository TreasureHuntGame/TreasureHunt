NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	strings "../$i/$2/saida.out" | base32 -d > "../$i/$2/resposta.html" # era cat
	
	cat "../$i/$2/resposta.html" | grep TreasureHunt | tail -c 31 | cut -c -26
	rm "../$i/$2/resposta.html"
done
