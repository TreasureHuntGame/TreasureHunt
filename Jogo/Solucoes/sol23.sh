NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	sol=$(cat "../$i/$2/index.html" | grep "<!-- " | tail -c -28 | cut -c -24)
	for j in $(seq 1 25)
	do
		echo $sol | caesar $j | grep TreasureHunt
	done
done
