NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	outguess -r "../$i/$2/ronald.jpg" "../$i/$2/aula.class"

	if [ $(file "../$i/$2/aula.class" | grep "compiled Java class" | wc -l) -eq 0 ]
	then
			outguess -k $i -r "../$i/$2/ronald.jpg" "../$i/$2/aula.class"
	fi
done

for i in $(seq 1 $NUM_INSTANCIAS)
do
	strings "../$i/$2/aula.class" | grep TreasureHunt
	rm "../$i/$2/aula.class"
done
