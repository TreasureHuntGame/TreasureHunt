NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	echo $(cat "../$i/$2/index.html" | grep "<!--" | tail -c -45 | cut -c -41) | base32 -d
done
