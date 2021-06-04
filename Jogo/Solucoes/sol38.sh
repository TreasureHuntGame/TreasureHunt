NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	outguess -r "../$i/$2/ronald.jpg" "../$i/$2/index.html"
	if [ $(cat "../$i/$2/index.html" | grep "Treasure" | wc -l) -eq 0 ]
	then
		outguess -k $i -r "../$i/$2/ronald.jpg" "../$i/$2/index.html"
	fi
done
for i in $(seq $NUM_INSTANCIAS)
do
	cat "../$i/$2/index.html" | grep -n TreasureHunt | tail -c 31 | cut -c -26
	rm "../$i/$2/index.html"
done
