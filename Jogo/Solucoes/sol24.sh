NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	for j in $(seq 1 25)
	do
		cat "../$i/$2/Site/ATP/robots.txt" | grep -o "#.*" | caesar $j | cut -c 3- | cut -c 1-23 | grep "TreasureHunt"
	done
done
