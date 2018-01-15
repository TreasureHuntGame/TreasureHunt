NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	mv "../$i/$2/Site/ATP/robots.txt" "../$i/$2/Site/ATP/robots.jpg"
	outguess -r "../$i/$2/Site/ATP/robots.jpg" "../$i/$2/Site/ATP/robots_novo.txt"
done
for i in $(seq $NUM_INSTANCIAS)
do
	cat "../$i/$2/Site/ATP/robots_novo.txt" | grep -o "# Treasure.*" | cut -c 3- | cut -c -46
	rm "../$i/$2/Site/ATP/robots_novo.txt"
	mv "../$i/$2/Site/ATP/robots.jpg" "../$i/$2/Site/ATP/robots.txt"
done
