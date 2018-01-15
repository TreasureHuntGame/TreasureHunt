NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	outguess -r "../$i/$2/ronald.jpg" "../$i/$2/aula.pyc"
done
for i in $(seq 1 $NUM_INSTANCIAS)
do
	strings "../$i/$2/aula.pyc" | grep TreasureHunt | rev | cut -c 2- | rev
	rm "../$i/$2/aula.pyc"
done
