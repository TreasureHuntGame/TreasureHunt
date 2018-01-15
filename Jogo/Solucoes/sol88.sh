NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	outguess -r "../$i/$2/ronald.jpg" "../$i/$2/au.jpg"
done
for i in $(seq 1 $NUM_INSTANCIAS)
do
	outguess -r "../$i/$2/au.jpg" "../$i/$2/sai.txt"
done
for i in $(seq 1 $NUM_INSTANCIAS)
do
	cat "../$i/$2/sai.txt" | cut -c -22
	rm "../$i/$2/au.jpg" "../$i/$2/sai.txt"
done
