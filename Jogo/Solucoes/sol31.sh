NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	cat "../$i/$2/saida.out" | base64 -d > "../$i/$2/resposta.html"
	cat "../$i/$2/resposta.html" | grep TreasureHunt | tail -c 31 | cut -c -26
	rm "../$i/$2/resposta.html"
done
