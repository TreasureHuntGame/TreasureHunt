NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	outguess -r "../$i/$2/ronald.jpg" "../$i/$2/saida.txt"
	if [ $(cat "../$i/$2/saida.txt" | grep "114 101 97 115 117 114 101" | wc -l) -eq 0 ]
	then
		outguess -k $i -r "../$i/$2/ronald.jpg" "../$i/$2/saida.txt"
	fi
done
for i in $(seq $NUM_INSTANCIAS)
do
	awk '{ for(i=1;i<=NF;i++) printf("%c",$i); print ""; }' "../$i/$2/saida.txt" | sed 's/.*\(TreasureHunt{.*\)/\1/' | cut -c -20
	rm "../$i/$2/saida.txt"
done
