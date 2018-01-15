NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	cat "../$i/$2/saida.out" | base64 -d > "../$i/$2/dados.dat"
	awk '{ for(i=1;i<=NF;i++) printf("%c",$i); print ""; }' "../$i/$2/dados.dat" | sed 's/.*\(TreasureHunt{.*\)/\1/' | cut -c -20
	rm "../$i/$2/dados.dat"
done
