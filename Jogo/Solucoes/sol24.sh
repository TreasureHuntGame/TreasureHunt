NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	for j in $(seq 1 25)
	do
		cat "../$i/$2/Site/ATP/robots.txt" | sed '/#/!d' | caesar $j | grep TreasureHunt | tail -c -24
	done
done
