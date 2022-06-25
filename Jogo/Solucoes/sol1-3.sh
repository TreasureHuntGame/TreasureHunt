NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	echo $(cat "../$i/$2/index.html" | grep "<!--" | tail -c -37 | cut -c -33) | base64 -d
done
