NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	outguess -r "../$i/$2/ronald.jpg" "../$i/$2/saida.txt"
	if [ $(strings "../$i/$2/saida.txt" | base64 -d | grep "Treasure" | wc -l) -eq 0 ]
	then
		outguess -k $i -r "../$i/$2/ronald.jpg" "../$i/$2/saida.txt"
	fi
done
for i in $(seq $NUM_INSTANCIAS)
do
	strings "../$i/$2/saida.txt" | cut -c -32 | base64 -d
	rm "../$i/$2/saida.txt"
done
