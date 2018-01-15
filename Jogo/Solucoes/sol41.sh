NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	cat "../$i/$2/Site/ATP/robots.txt" | base64 -d > "../$i/$2/robots.txt"
	cat "../$i/$2/robots.txt" | grep -o "# Treasure.*" | cut -c 3- | cut -c -46
	rm "../$i/$2/robots.txt"
done
