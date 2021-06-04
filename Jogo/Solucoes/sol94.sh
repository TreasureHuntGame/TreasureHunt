NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	cat "../$i/$2/Site/ATP/robots.txt" | grep -ow '#.\{41\}' | tail -c 41 | base32 -d
	#cat "../$i/$2/Site/ATP/robots.txt" | sed '/#/!d' | grep -ow '.\{43\}' | grep -ow '.\{41\}' | base32 -d | grep TreasureHunt | tail -c -24
done
