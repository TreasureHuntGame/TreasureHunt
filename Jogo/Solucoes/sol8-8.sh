NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	outguess -k $i -r "../$i/$2/ronald.jpg" "../$i/$2/au1.jpg"
	outguess -r "../$i/$2/ronald.jpg" "../$i/$2/au2.jpg"
done

RESPOSTA=$(file "../$i/$2/au1.jpg" | grep JPEG | wc -l)
if [ $RESPOSTA -eq 0 ]
	then RESPOSTA=2
	else RESPOSTA=1
fi

for i in $(seq 1 $NUM_INSTANCIAS)
do
	outguess -k $i -r "../$i/$2/au$RESPOSTA.jpg" "../$i/$2/sai1.txt"
	outguess -r "../$i/$2/au$RESPOSTA.jpg" "../$i/$2/sai2.txt"
done

RESPOSTA=$(grep "Trea" "../$i/$2/sai1.txt" | wc -l)
if [ $RESPOSTA -eq 0 ]
	then RESPOSTA=2
	else RESPOSTA=1
fi

for i in $(seq 1 $NUM_INSTANCIAS)
do
	cat "../$i/$2/sai$RESPOSTA.txt" | cut -c -22
	rm "../$i/$2/au1.jpg" "../$i/$2/sai1.txt" "../$i/$2/au2.jpg" "../$i/$2/sai2.txt"
done