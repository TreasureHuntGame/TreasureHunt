NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	for j in $(seq 1 25)
	do
		cat "../$i/$2/saida.out" | caesar $j > "../$i/$2/index.html"
		if [ ! -z "$(cat ../$i/$2/index.html | grep TreasureHunt)" ]
		then
			cat "../$i/$2/index.html" | grep -n TreasureHunt | tail -c 31 | cut -c -26
			rm "../$i/$2/index.html"
			break
		fi
		rm "../$i/$2/index.html"
	done
done
