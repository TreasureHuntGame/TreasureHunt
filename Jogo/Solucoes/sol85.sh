NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	awk '{ for(i=1;i<=NF;i++) printf("%02x ",$i); print ""; }' "../$i/$2/saida.out" > "../$i/$2/saida"
	xxd -p -r "../$i/$2/saida" "../$i/$2/img.jpg"
	outguess -r "../$i/$2/img.jpg" "../$i/$2/sai1"
	outguess -k $i -r "../$i/$2/img.jpg" "../$i/$2/sai2"
done

RESPOSTA=$(grep "Trea" "../$i/$2/sai1" | wc -l)
if [ $RESPOSTA -eq 0 ]
	then RESPOSTA=2
	else RESPOSTA=1
fi

for i in $(seq $NUM_INSTANCIAS)
do
	cat "../$i/$2/sai$RESPOSTA" | cut -c -22
	rm "../$i/$2/saida" "../$i/$2/sai1" "../$i/$2/sai2" "../$i/$2/img.jpg"
done
