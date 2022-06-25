NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	cat "../$i/$2/saida.out" | base64 -d | awk '{ for(i=1;i<=NF;i++) printf("%c",$i); print ""; }' | sed 's/.*\(TreasureHunt{.*\)/\1/' | cut -c -20
done