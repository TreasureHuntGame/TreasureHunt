NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	awk '{ for(i=1;i<=NF;i++) printf("%c",$i); print ""; }' "../$i/$2/dados.dat" | sed 's/.*\(TreasureHunt{.*\)/\1/' | cut -c -20
done
