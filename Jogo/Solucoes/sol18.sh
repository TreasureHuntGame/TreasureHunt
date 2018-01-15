NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	outguess -r "../$i/$2/ronald.jpg" "../$i/$2/saida.txt"
done
for i in $(seq $NUM_INSTANCIAS)
do
	cat "../$i/$2/saida.txt" | cut -c -32 | base64 -d
	rm "../$i/$2/saida.txt"
done
