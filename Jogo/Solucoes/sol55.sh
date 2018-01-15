NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	awk '{ for(i=1;i<=NF;i++) printf("%c",$i); print ""; }' "../$i/$2/saida.out" > "../$i/$2/dados2"
	awk '{ for(i=1;i<=NF;i++) printf("%c",$i); print ""; }' "../$i/$2/dados2" | sed -n 's/.*\(TreasureHunt\)/\1/p' | cut -c -20
	rm "../$i/$2/dados2"
done
