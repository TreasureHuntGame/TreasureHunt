NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	cat "../$i/$2/Site/ATP/robots.txt" | grep -ow '.\{34\}' | grep -ow '.\{32\}' | base64 -d | strings | grep "TreasureHunt" | tail -c -24
done
