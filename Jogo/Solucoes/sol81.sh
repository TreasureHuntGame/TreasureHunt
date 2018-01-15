NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	cat "../$i/$2/saida.out" | base64 -d >> "../$i/$2/resposta.jpg"
	outguess -r "../$i/$2/resposta.jpg" "../$i/$2/saida.txt"
	rm "../$i/$2/resposta.jpg"
done
for i in $(seq $NUM_INSTANCIAS)
do
	cat "../$i/$2/saida.txt" | grep TreasureHunt | cut -c -22
	rm "../$i/$2/saida.txt"
done
