NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	cat "../$i/$2/saida.out" | base32 -d >> "../$i/$2/resposta.jpg"
	outguess -r "../$i/$2/resposta.jpg" "../$i/$2/saida1.txt"
	outguess -k $i -r "../$i/$2/resposta.jpg" "../$i/$2/saida2.txt"
	rm "../$i/$2/resposta.jpg"
done

RESPOSTA=$(grep "Trea" "../$i/$2/saida1.txt" | wc -l)
if [ $RESPOSTA -eq 0 ]
	then RESPOSTA=2
	else RESPOSTA=1
fi

for i in $(seq $NUM_INSTANCIAS)
do
	strings "../$i/$2/saida$RESPOSTA.txt" | grep TreasureHunt | cut -c -22
	rm "../$i/$2/saida1.txt" "../$i/$2/saida2.txt"
done
