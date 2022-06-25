NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	awk '{ for(i=1;i<=NF;i++) printf("%c",$i); print ""; }' "../$i/$2/saida.out" | awk '{ for(i=1;i<=NF;i++) printf("%c",$i); print ""; }' | sed -n 's/.*\(TreasureHunt\)/\1/p' | cut -c -20
done
